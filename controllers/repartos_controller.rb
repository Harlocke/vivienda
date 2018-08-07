class RepartosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @repartos = Reparto.search(params[:search], params[:page])
    @repartoespecial = ""
    if permiso("repartoautorizacion","C").to_s == "S"
      @repartoespecial = 'SI'
      @repartosp = Reparto.find(:all, :conditions=>["estado = 'ENVIADO'"], :order=>"created_at asc")
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @repartos }
    end
  end

  def show
    @reparto = Reparto.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reparto }
    end
  end

  def new
    @reparto = Reparto.new
    @reparto.entidad1_nit = "900014480-8"
    @reparto.entidad1_nombre = "INSTITUTO SOCIAL DE VIVIENDA Y HÁBITAT DE MEDELLÍN - ISVIMED"
    @reparto.entidad1_naturaleza = "PUBLICA"
    @reparto.estado = 'PENDIENTE'
    render :action => "reparto_form"
  end

  def edit
    @reparto = Reparto.find(params[:id])
    @repartosacto = Repartosacto.new
    @repartosinmueble = Repartosinmueble.new
    respond_to do |format|
      format.html { render :action => "reparto_form" }
    end
  end

  def create
    @reparto = Reparto.new(params[:reparto])
    @reparto.user_solicita = is_admin
    
    if @reparto.save
      flash[:notice] = "Registro Creado con Exito."
      redirect_to edit_reparto_path(@reparto)
    else
      @repartosacto = Repartosacto.new
	    @repartosinmueble = Repartosinmueble.new
      render :action => "reparto_form"
    end
  end

  def update
    @reparto = Reparto.find(params[:id])
    @reparto.user_actualiza = is_admin
    if @reparto.update_attributes(params[:reparto])
      flash[:notice] = "Registro Actualizado con Exito."
      redirect_to edit_reparto_path(@reparto)
    else
      @repartosacto = Repartosacto.new
	  @repartosinmueble = Repartosinmueble.new
      render :action => "reparto_form"
    end
  end

  def destroy
    @reparto = Reparto.find(params[:id])
    @reparto.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro ha sido eliminado con Exito."
        redirect_to busqueda_repartos_path
      }
      format.xml  { head :ok }
    end
  end

  def solicitar
    @reparto = Reparto.find(params[:id])
    @reparto.estado = 'ENVIADO'
    @reparto.save
    flash[:notice] = "Solicitud enviada con Exito."
    redirect_to edit_reparto_path(@reparto)
  end

  def rechazo
    @reparto = Reparto.find(params[:id])
    @reparto.estado = 'RECHAZADO'
    @reparto.save
    flash[:notice] = "Solicitud Rechazada con Exito."
    redirect_to repartos_path
  end    

  def asignacion
    notariaid = 0
    @reparto = Reparto.find(params[:id])
    @reparto.repartosinmuebles.each do |repartosinmueble|
      if repartosinmueble.vivienda_id
        ActiveRecord::Base.connection.execute("update repartos set zona = '#{repartosinmueble.vivienda.esc_registrada_of.to_s}' where id = #{@reparto.id}")
      elsif repartosinmueble.corvide_id
        ActiveRecord::Base.connection.execute("update repartos set zona = 'ZONA SUR' where id = #{@reparto.id} and '#{repartosinmueble.corvide.matricula.to_s}' like '001%'")
        ActiveRecord::Base.connection.execute("update repartos set zona = 'ZONA NORTE' where id = #{@reparto.id} and '#{repartosinmueble.corvide.matricula.to_s}' like '01N%'")
      else
        ActiveRecord::Base.connection.execute("update repartos set zona = 'ZONA SUR' where id = #{@reparto.id} and '#{repartosinmueble.matricula.to_s}' like '001%'")
        ActiveRecord::Base.connection.execute("update repartos set zona = 'ZONA NORTE' where id = #{@reparto.id} and '#{repartosinmueble.matricula.to_s}' like '01N%'")
      end
    end
    @reparto = Reparto.find(params[:id])
    if @reparto.zona.to_s == ""
      flash[:notice] = "El reparto no tiene ZONA, se bloquea la generación"
      redirect_to edit_reparto_path(@reparto)      
    else
      if @reparto.zona.to_s == 'ZONA NORTE'
        notariaid = is_notarianorte
      elsif @reparto.zona.to_s == 'ZONA SUR'
        notariaid = is_notariasur
      end
      @reparto.notaria_id = notariaid
      @reparto.nro_acta = is_nextreparto
      @reparto.anno = Time.now.strftime('%Y')
      @reparto.fecha_reparto = Time.now
      @reparto.user_diligencia = is_admin
      @reparto.estado = 'GENERADO'
      @reparto.save
      ActiveRecord::Base.connection.execute("update notarias set utilizada = 'X' where id = #{notariaid.to_i}")
      flash[:notice] = "Reparto Generado con exito."
      redirect_to edit_reparto_path(@reparto)
    end
  end

  def solicitud
    @reparto = Reparto.find(params[:id])
  end

  def constancia
    @reparto = Reparto.find(params[:id])
  end

  def informe
    if params[:ubicacion][:fchinicial].to_s == "" and params[:ubicacion][:fchfinal].to_s == ""
      flash[:warning] = "No hay resultados de la busqueda"
      redirect_to repartos_path
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Repartos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'     
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @repartos = Reparto.searchreparto(params[:ubicacion][:zona],params[:ubicacion][:fchinicial],params[:ubicacion][:fchfinal])
    end
  end

  def informemas
    if params[:ubicacion][:fchinicial].to_s == "" and params[:ubicacion][:fchfinal].to_s == ""
      flash[:warning] = "No hay resultados de la busqueda"
      redirect_to masive_repartos_path
    else
      @repartos = Reparto.searchrepartomas(params[:ubicacion][:zona],params[:ubicacion][:fchinicial])
    end
  end  

  
  private
  def determine_layout
    if ['mostrar','mostrarconsolidado','asignacion'].include?(action_name)
      "atencion"
    elsif ['solicitud','constancia','informemas','masive'].include?(action_name)
      "new2"      
    elsif ['informe'].include?(action_name)
      "excel"           
    else
      "application"
    end
  end
end

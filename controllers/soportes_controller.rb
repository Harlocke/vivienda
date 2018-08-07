class SoportesController < ApplicationController

  before_filter :require_user

  def index
    @soportes = Soporte.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @soportes }
    end
  end

  def show
    @soporte = Soporte.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @soporte }
    end
  end

  def cruce
     soporte = Soporte.find(params[:id])
    if soporte.identificacion_jefe.to_s != "" and soporte.identificacion_beneficario.to_s != ""
      dat = ""  
      ActiveRecord::Base.connection.execute("begin prc_persona('#{soporte.identificacion_jefe.to_s.strip}','#{soporte.identificacion_beneficario.to_s.strip}'); end;")
      objetos = Objeto.find_by_sql(["select descripcion dato from error"])
      objetos.each do |objeto|
        if objeto.dato.to_s == 'OK'
          dat = 'OK'
        else
          dat = dat + ' - ' + objeto.dato.to_s rescue nil
        end
      end
      sa = Soportesactividad.new
      sa.soporte_id = soporte.id 
      sa.solucionado = '1'
      if dat.to_s == 'OK'
        sa.observacion = 'SE REALIZA LA UNIFICACION SOLICITADA DE MANERA CORRECTA'
      else
        sa.observacion = 'NO SE LOGRA REALIZAR LA UNIFICACION DEBIDO AL SIGUIENTE ERROR: ' + dat.upcase.to_s
      end
      sa.user_id = 10002
      sa.save      
    end
    redirect_to edit_soporte_path(soporte)

  end
  
  def buscar
    @soporte = Soporte.new
    @soporte.user_id   = params[:ubicacion][:usuario]
    @soporte.prioridad = params[:ubicacion][:prioridad]
    @soporte.tipo      = params[:ubicacion][:tipo]
    @soporte.tipo_requerimiento = params[:ubicacion][:tipo_requerimiento]
    @soporte.descripcion = params[:descripcion]
    @soporte.id = params[:ticket]
    @soportes = Soporte.search(@soporte,params[:ubicacion][:fchinicial],
                                        params[:ubicacion][:fchfinal],
                                        params[:ubicacion][:solucionado],
                                        params[:ubicacion][:funcionario])
    if @soportes.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_soportes_path
    elsif @soportes.count == 1
      redirect_to edit_soporte_path(@soportes)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def new
    @soportes = Soporte.all
    if @soportes.length == 0
      @soporte = Soporte.new
    else
      @soporte = Soporte.new
      render :action => "soporte_form"
    end
  end

  def edit
    @soporte = Soporte.find(params[:id])
    @soportesactividad = Soportesactividad.new
    respond_to do |format|
      format.html { render :action => "soporte_form" }
    end
  end

  def create
    @soporte = Soporte.new(params[:soporte])
    @soporte.user_id = is_admin
    if @soporte.save
      Soporte.mensaje(@soporte)
      flash[:notice] = "Requerimiento (" + @soporte.id.to_s + ") registrado con Exito."

      redirect_to menus_url
    else
      render :action => "soporte_form"
    end
  end

  def update
    @soporte = Soporte.find(params[:id])
    if @soporte.update_attributes(params[:soporte])
      flash[:notice] = "Actualizado con Exito"
      redirect_to edit_soporte_path(@soporte)
    else
      flash[:notice] = "Se produjo un error al actualizar el registro"
      @soportesactividad = Soportesactividad.new
      render :action => "soporte_form"
    end
    rescue
      redirect_to edit_soporte_path(@soporte)
  end

  def destroy
    @soporte = Soporte.find(params[:id])
    @soporte.destroy
    flash[:notice] = "Borrado con exito"
    respond_to do |format|
      format.html { redirect_to(soportes_url) }
      format.xml  { head :ok }
    end
  end
end

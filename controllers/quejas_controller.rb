class QuejasController < ApplicationController
   before_filter :require_user, :except=>["new2","create2"]
  layout :determine_layout
  require 'ruby_plsql'

  def index
    #@quejas = Queja.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quejas }
    end
  end

  def visualizar
    @queja    = Queja.find(params[:id])
  end

  def busqueda    
    if Sifi.exists?(["id between 65 and 84 and valor = '#{is_admin}'"]) == true
      @tienependientes = 'SI'
    else
      @quejas = Queja.find(:all, :conditions=>["estado IN ('PENDIENTE','TRASLADADO')"], :order=>"created_at desc")
    end
  end

  def buscar
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end    
    @quejas = Queja.search(params[:ubicacion][:creainicial],
                           params[:ubicacion][:creafinal],
                           params[:ubicacion][:tipopqrs],
                           params[:identificacion],
                           params[:observacion],
                           params[:radicado],params[:page],perpage)
    if @quejas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_quejas_path
    else
      if params[:format] == 'xls'
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_PQRS_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"
        respond_to do |format|
           format.xls
        end
      else
        respond_to do |format|
          format.html
        end
      end
    end
  end

  def new
    @queja = Queja.new
    render :action => "queja_form"
  end

  def edit
    @queja = Queja.find(params[:id])
    @quejasobservacion = Quejasobservacion.new
    @quejasbitacora = Quejasbitacora.new
    @quejasimagen = Quejasimagen.new
    respond_to do |format|
      format.html { render :action => "queja_form" }
    end
  end

#NoMethodError in QuejasController#create
#undefined method `queja_message' for #<Notifier:0x7f6de8c8fde0>

  def create
    @queja = Queja.new(params[:queja])
    @queja.user_id = is_admin
    @queja.estado = "PENDIENTE"
    @queja.identificacion = (params[:queja][:identificacion].to_i).to_s.strip
    if @queja.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_queja_path(@queja)
    else
      render :action => "queja_form"
    end
  end

  #END

  def update
    @queja = Queja.find(params[:id])
    @queja.useract_id = is_admin
    if @queja.update_attributes(params[:queja])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_queja_path(@queja)
    else
      @quejasobservacion = Quejasobservacion.new
      @quejasbitacora = Quejasbitacora.new
      @quejasimagen = Quejasimagen.new
      render :action => "queja_form"
    end
  rescue
    flash[:notice] = "Existen inconsistencias. Verifique!!!"
    redirect_to edit_queja_path(@queja)
  end

  def enviomensaje
    @queja = Queja.find(params[:id])
    Queja.mensaje(@queja)
    flash[:notice] = "La informacion ha sido enviada con Exito via Electronica."
    redirect_to edit_queja_path(@queja)
  end

  def enviomensajejefe
    @queja = Queja.find(params[:id])
    Queja.mensajejefe(@queja)
    flash[:notice] = "La informacion ha sido enviada con Exito via Electronica."
    redirect_to edit_queja_path(@queja)
  end

  def destroy
    @queja = Queja.find(params[:id])
    @queja.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_quejas_path
      }
      format.xml  { head :ok }
    end
  end

  def show
    @quejas = Queja.find_all_by_persona_id(params[:persona_id])
  end

  def new2
    @queja = Queja.new
  end

  def create2
    @queja = Queja.new(params[:queja])
    @queja.estado = "PENDIENTE"
    if params[:queja][:identificacion].to_i > 0
      @queja.identificacion = (params[:queja][:identificacion].to_i).to_s.strip
    end
    @queja.procedencia = "WEBSITE"
    if @queja.save
      #Queja.mensajepqrs(@queja)
      flash[:notice] = "Formulario de PQRS diligenciado correctamente."
      redirect_to :controller=>"quejas", :action=>"alerta", :id=>@queja.id
      correo = @queja.email
      Notifier.deliver_notificacionweb_message(correo, @queja)
    else
      render :action => "new2"
    end
  end

  def newpersona
    @queja = Queja.new
    @persona = Persona.find(params[:id])
    @queja.identificacion = @persona.identificacion
    @queja.primer_nombre = @persona.primer_nombre
    @queja.segundo_nombre = @persona.segundo_nombre
    @queja.primer_apellido = @persona.primer_apellido
    @queja.segundo_apellido = @persona.segundo_apellido
    @queja.telefono = @persona.telefonos1
    @queja.celular = @persona.celular
    @queja.direccion = @persona.direccion
    @queja.email = @persona.e_mail
    @queja.comuna_id = @persona.comuna_id
    @queja.persona_id = @persona.id
  end

  def createpersona
    @queja = Queja.new(params[:queja])
    if @queja.solucion.to_s == ""
      @queja.estado = "PENDIENTE"
    else
      if @queja.tema_p.to_s == "SI"
        @queja.estado = "CERRADO"
      else
        @queja.estado = "TRASLADADO"
      end
    end
    @queja.procedencia = "OTRO"
    @queja.user_id = is_admin
    if @queja.save
      #Queja.mensajepqrs(@queja)
      flash[:notice] = "Formulario de PQRS diligenciado correctamente."
      redirect_to :controller=>"quejas", :action=>"alertapersona", :id=>@queja.id
    else
      render :action => "newpersona"
    end
  end

  def alerta
    queja = Queja.find(params[:id])
    @valor = "Señor(a): " + queja.nombres.to_s + ' <br/>Se ha registrado con exito su '+ queja.tipopqrs.to_s + ' con el consecutivo número '+ queja.id.to_s
    #@valor = "Señor(a): " + queja.nombres.to_s + ' <br/>Se ha registrado con exito su '+ queja.tipopqrs.to_s + ' con el radicado número '+ queja.correspondenciasrecibida.nro_radicado.to_s
  end



  def alertapersona
    queja = Queja.find(params[:id])
    #@valor = "Señor(a): " + queja.nombres.to_s + ' <br/>Se ha registrado con exito su '+ queja.tipopqrs.to_s + ' con el radicado número '+ queja.correspondenciasrecibida.nro_radicado.to_s
    @valor = "Señor(a): " + queja.nombres.to_s + ' <br/>Se ha registrado con exito su '+ queja.tipopqrs.to_s + ' con el consecutivo número '+ queja.id.to_s
    @personaid = queja.persona_id
  end

  def informepqrs
    @fch1 = params[:ubicacion][:fchinicial].to_s
    @fch2 = params[:ubicacion][:fchfinal].to_s
    if @fch1.to_s != "" and @fch2.to_s != ""
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_InfomePQRS_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      ActiveRecord::Base.connection.execute("begin prc_informepqrs('#{@fch1.to_date}','#{@fch2.to_date}'); end;")
      @quejas = Queja.find_by_sql("select * from informesquejaconsol")
    else
      flash[:notice] = "No hay datos para la consuta. Verifique!!"
      redirect_to busqueda_quejas_path
    end
  end

  def radicarrespuesta
    queja = Queja.find(params[:id])
    quejasobservacion = Quejasobservacion.find(params[:quejasobservacion_id])
    correspondenciasrecibida = Correspondenciasrecibida.find(queja.correspondenciasrecibida_id)
    correspondenciasrecibida.respuesta = 'SI'
    correspondenciasrecibida.respuestaobs = quejasobservacion.created_at.strftime("%Y-%m-%d %X").to_s + ' - ' + quejasobservacion.user.nombre.to_s + ' : ' + quejasobservacion.observacion.to_s rescue nil
    correspondenciasrecibida.save
    queja.correspondenciarespuesta = 'SI'
    queja.save
    redirect_to edit_queja_path(queja)
  end

  private
  def determine_layout
    if ['visualizar'].include?(action_name)
      "atencion"
    elsif['informepqrs'].include?(action_name)
      "excel"
    elsif['new2','create2','alerta'].include?(action_name)
      "new2"
    else
      "application"
    end
  end
end
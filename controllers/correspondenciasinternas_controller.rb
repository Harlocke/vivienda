class CorrespondenciasinternasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @correspondenciasinternasrevision = Correspondenciasinterna.find(:all, :conditions=>["user_revisa = '#{is_admin}' and consecutivo is null and estado = 'REVISION'"], :order=>"created_at desc")
    @correspondenciasinternasrechazados = Correspondenciasinterna.find(:all, :conditions=>["user_id = '#{is_admin}' and consecutivo is null and estado = 'RECHAZADO'"], :order=>"created_at desc")
    @correspondenciasinternasaprobadosrev = Correspondenciasinterna.find(:all, :conditions=>["user_envia = '#{is_admin}' and consecutivo is null and estado = 'APROBADOREV'"], :order=>"created_at desc")

    #@correspondenciasinternaspendientes = Correspondenciasinterna.find(:all, :conditions=>["user_envia = '#{is_admin}' and consecutivo is null"], :order=>"created_at asc")
#    @correspondenciasinternase = Correspondenciasinterna.find(:all, :conditions=>["user_envia = '#{is_admin}' and aprueba = 'SI' and aprueba2 != 'SI'"], :order=>"asunto")
#    @correspondenciasinternasr = Correspondenciasinterna.find(:all, :conditions=>["user_envia = '#{is_admin}' and aprueba2 = 'SI' and fecha_radicado is null"], :order=>"asunto")
    #@correspondenciasinternasf = Correspondenciasinterna.find(:all, :conditions=>["user_envia = '#{is_admin}' and consecutivo is not null"], :order=>"created_at desc")
#    @correspondenciasinternast = Correspondenciasinterna.find(:all, :conditions=>["user_id = '#{is_admin}' and aprueba = 'SI' and aprueba2 = 'SI' and fecha_radicado != ''"], :order=>"asunto")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @correspondenciasinternas }
    end
  end

  def visualizar
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
   respond_to do |format|
      format.pdf  { render :layout => false }
    end
  end

  def aprobado
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
    ActiveRecord::Base.connection.execute("update correspondenciasinternas set consecutivo = #{is_nextinterno}, aprueba = 'SI' where id = #{@correspondenciasinterna.id}")
    is_trigger_interno(@correspondenciasinterna.id,is_admin,'SE REALIZA APROBACIÓN DEL DOCUMENTO')
    flash[:notice] = "Memorando aprobado..."
    redirect_to edit_correspondenciasinterna_path(@correspondenciasinterna)
  end

  def aprobado2
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
    ActiveRecord::Base.connection.execute("update correspondenciasinternas set aprueba2 = 'SI' where id = #{@correspondenciasinterna.id}")
    is_trigger_interno(@correspondenciasinterna.id,is_admin,'SE REALIZA APROBACIÓN DEL DOCUMENTO')
    flash[:notice] = "Memorando aprobado..."
    redirect_to edit_correspondenciasinterna_path(@correspondenciasinterna)
  end

  
  def verrecibido
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
  end

  def buscar
    @correspondenciasinternas = Correspondenciasinterna.search(
                             params[:consecutivo],
                             params[:ubicacion][:fchdocinicial],
                             params[:ubicacion][:fchdocfinal],
                             params[:ubicacion][:dependencia_id],
                             params[:asunto],
                             params[:ubicacion][:user_proyecta],
                             params[:ubicacion][:tipo]
                             )
    if @correspondenciasinternas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_correspondenciasinternas_path
    elsif @correspondenciasinternas.count == 1 and params[:format] != 'xls'
      redirect_to edit_correspondenciasinterna_path(@correspondenciasinternas)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def new
    @correspondenciasinterna = Correspondenciasinterna.new
    render :action => "correspondenciasinterna_form"
  end

  def edit
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
    @corresinternasdirigido = Corresinternasdirigido.new
    @corresinternasobservacion = Corresinternasobservacion.new
    @corresinternasimagen = Corresinternasimagen.new
    @corresinternasbitacora = Corresinternasbitacora.new
    @calidadversion = Calidadversion.find(8)
    respond_to do |format|
      format.html { render :action => "correspondenciasinterna_form" }
    end
  end

  def revision
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
    ActiveRecord::Base.connection.execute("update correspondenciasinternas set estado = 'REVISION' where id = #{@correspondenciasinterna.id}")
    flash[:notice] = "Envio de Memorando a revision..."
    redirect_to correspondenciasinternas_path
  end

  def rechazado
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
    ActiveRecord::Base.connection.execute("update correspondenciasinternas set estado = 'RECHAZADO' where id = #{@correspondenciasinterna.id}")
    flash[:notice] = "Memorando Rechazodo con exito..."
    redirect_to correspondenciasinternas_path
  end

  def aprobadarevision 
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
    ActiveRecord::Base.connection.execute("update correspondenciasinternas set estado = 'APROBADOREV', aprueba = 'SI' where id = #{@correspondenciasinterna.id}")
    is_trigger_interno(@correspondenciasinterna.id,is_admin,'SE REALIZA APROBACIÓN DEL DOCUMENTO DE REVISION')
    flash[:notice] = "Memorando Aprobado por la Revision..."
    redirect_to correspondenciasinternas_path
  end


  def create
    @correspondenciasinterna = Correspondenciasinterna.new(params[:correspondenciasinterna])
    @correspondenciasinterna.user_id = is_admin
    @correspondenciasinterna.user_elabora = is_admin
    @correspondenciasinterna.anno = Time.now.strftime("%Y")
    @correspondenciasinterna.estado = 'PENDIENTE'
    if @correspondenciasinterna.save
      flash[:notice] = "Registrado con Exito."
      is_trigger_interno(@correspondenciasinterna.id,is_admin,'CREACION DEL REGISTRO DE LA CORRESPONDENCIA INTERNA')
      redirect_to edit_correspondenciasinterna_path(@correspondenciasinterna)
    else
      flash[:warning] = "Existen inconsistencias, por favor Verifique!!"
      render :action => "correspondenciasinterna_form"
    end
  end

  def update
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
    @correspondenciasinterna.user_actualiza = is_admin
    if @correspondenciasinterna.update_attributes(params[:correspondenciasinterna])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      is_trigger_interno(@correspondenciasinterna.id,is_admin,'MODIFICACIÓN EN EL REGISTRO PRINCIPAL DE LA CORRESPONDENCIA INTERNA')
      redirect_to edit_correspondenciasinterna_path(@correspondenciasinterna)
    else
      @corresinternasdirigido    = Corresinternasdirigido.new
      @corresinternasobservacion = Corresinternasobservacion.new
      @corresinternasimagen      = Corresinternasimagen.new
      @corresinternasbitacora    = Corresinternasbitacora.new
      render :action => "correspondenciasinterna_form"
    end
#    rescue
#      flash[:notice] = "Existen inconsistencias. Verifique!!!"
#      redirect_to edit_correspondenciasinterna_path(@correspondenciasinterna)
  end

  def radicar
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
    @correspondenciasinterna.user_radicado  = is_admin
    @correspondenciasinterna.fecha_radicado = Time.now
    @correspondenciasinterna.estado = 'APROBADOFINAL'
    @correspondenciasinterna.save
    ActiveRecord::Base.connection.execute("update correspondenciasinternas set consecutivo = #{is_nextinterno}, aprueba2 = 'SI' where id = #{@correspondenciasinterna.id}")
    is_trigger_interno(@correspondenciasinterna.id,is_admin,'SE REALIZA APROBACIÓN DEL DOCUMENTO POR PARTE DEL REMITENTE')
    @correos = ""
    @correspondenciasinterna.corresinternasdirigidos.each do |corresinternasdirigido|
      if @correos == ""
        @correos = corresinternasdirigido.user.email.to_s
      else
        @correos = @correos.to_s + ',' + corresinternasdirigido.user.email.to_s
      end
    end
    begin
      @calidadversion = Calidadversion.find(8)
      Notifier.deliver_radicacion_message(@correos,@correspondenciasinterna,@calidadversion)
      is_trigger_interno(@correspondenciasinterna.id,is_admin,"SE ENVIA DOCUMENTO ELECTRONICAMENTE A #{@correos.to_s}")
      rescue Exception => exc
         logger.error("SIFI Correo NO radicacion_message ")
    end    
    flash[:notice] = "Archivo radicado con exito"
    redirect_to edit_correspondenciasinterna_path(@correspondenciasinterna)
  end

  def destroy
    @correspondenciasinterna = Correspondenciasinterna.find(params[:id])
    @correspondenciasinterna.destroy
    respond_to do |format|
       format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_correspondenciasinternas_path
        }
      format.xml  { head :ok }
    end
  end

  def show
    persona   = Persona.find(params[:correspondenciasinterna_id])
    @correspondenciasinternas = persona.correspondenciasinternas.all
  end

  private
  def determine_layout
    if ['visualizar','verrecibido'].include?(action_name)
      "new2"
    else
      "application"
    end
  end
end
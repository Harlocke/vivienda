class TitulacionesdocumentosController < ApplicationController
  before_filter :require_user
  before_filter :find_titulacion_and_titulacionesdocumento

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesdocumentos = titulacion.titulacionesdocumentos.all
  end

  def new
    @titulacionesdocumento = Titulacionesdocumento.new
    @titulacionesdocumento.titulacionesdoctipo_id = params[:titulacionesdoctipo_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @titulacionesdocumento }
    end
  end

  def edit
    @titulacionesdocumento  = Titulacionesdocumento.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesdocumento.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesdocumento" }
    end
  end

  def aprobar
    @titulacionesdocumento = Titulacionesdocumento.new
    titulacionesdocumento   = Titulacionesdocumento.find(params[:id])
    titulacionesdocumento.estado = 'APROBADO'
    titulacionesdocumento.user_estado = is_admin
    @titulacion         = titulacionesdocumento.titulacion
    ok = titulacionesdocumento.update_attributes(params[:titulacionesdocumento])
    respond_to do |format|
      format.js { render :action => "titulacionesdocumentos" }
    end
  end

  def rechazar
    @titulacionesdocumento = Titulacionesdocumento.new
    titulacionesdocumento   = Titulacionesdocumento.find(params[:id])
    titulacionesdocumento.estado = 'RECHAZADO'
    titulacionesdocumento.user_estado = is_admin
    @titulacion         = titulacionesdocumento.titulacion
    ok = titulacionesdocumento.update_attributes(params[:titulacionesdocumento])
    respond_to do |format|
      format.js { render :action => "titulacionesdocumentos" }
    end
  end

  def create
    @titulacionesdocumento = Titulacionesdocumento.new(params[:titulacionesdocumento])
    @titulacionesdocumento.titulacion_id = @titulacion.id
    @titulacionesdocumento.user_id = is_admin
    respond_to do |format|
      if @titulacionesdocumento.save
        is_trigger_tit(@titulacion.id,is_admin,'titulacionesdocumento','I')
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to edit_titulacion_path(@titulacion) }
        format.xml  { render :xml => @titulacionesdocumento, :status => :created, :location => @titulacionesdocumento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @titulacionesdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @titulacionesdocumento        = Titulacionesdocumento.new
    titulacionesdocumento         = Titulacionesdocumento.find(params[:id])
    email = titulacionesdocumento.user.email rescue nil
    @titulacion        = titulacionesdocumento.titulacion
    params[:titulacionesdocumento][:estado] = 'RECHAZADO'
    params[:titulacionesdocumento][:user_estado] = is_admin
    if params[:titulacionesdocumento][:observaciones].to_s != ""
      ok = titulacionesdocumento.update_attributes(params[:titulacionesdocumento])
      flash[:titulacionesdocumento] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
      @tit = Titulacionesdocumento.find(params[:id])
      begin
        Notifier.deliver_titulacionesrechazo_message(email,@tit,@tit.titulacion.cobama)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{email rescue nil}")
      end
      respond_to do |format|
        format.js { render :action => "titulacionesdocumentos" }
      end
    else
      render :update do |page|
         page.alert "Para poder rechazar el documento debe ingresar la observacion"
      end
    end  
  end

  def destroy
    titulacionesdocumento   = Titulacionesdocumento.find(params[:id])
    @titulacion         = titulacionesdocumento.titulacion
    is_trigger_tite(@titulacion.id,is_admin,'titulacionesdocumento','E',titulacionesdocumento.titudocumento_file_name.to_s)
    @titulacionesdocumento  = Titulacionesdocumento.new
    titulacionesdocumento.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_titulacion_and_titulacionesdocumento
      @titulacion = Titulacion.find(params[:titulacion_id])
      @titulacionesdocumento = Titulacionesdocumento.find(params[:id]) if params[:id]
  end

end
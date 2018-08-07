class TitulacionesobservacionesController < ApplicationController
before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesobservaciones = titulacion.titulacionesobservaciones.all
  end

  def edit
    @titulacionesobservacion  = Titulacionesobservacion.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesobservacion.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesobservacion" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesobservacion = Titulacionesobservacion.new(params[:titulacionesobservacion])
    @titulacionesobservacion.user_id = is_admin
    if @titulacionesobservacion.valid?
      @titulacion.titulacionesobservaciones << @titulacionesobservacion
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesobservacion','I')
      @titulacionesobservacion = Titulacionesobservacion.new
      flash[:titulacionesobservacion] = "Se guardo el registro con exito"
    else
      flash[:titulacionesobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesobservaciones" }
    end
  end

  def update
    @titulacionesobservacion        = Titulacionesobservacion.new
    titulacionesobservacion         = Titulacionesobservacion.find(params[:id])
    @titulacion        = titulacionesobservacion.titulacion
    ok = titulacionesobservacion.update_attributes(params[:titulacionesobservacion])
    flash[:titulacionesobservacion] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesobservaciones" }
    end
  end

  def destroy
    titulacionesobservacion   = Titulacionesobservacion.find(params[:id])
    @titulacion  = titulacionesobservacion.titulacion
    @titulacionesobservacion  = Titulacionesobservacion.new
    titulacionesobservacion.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesobservaciones" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionesobservaciones = persona.titulacionesobservaciones.all
  end

  def atencion
    @titulacionesobservaciones = Titulacionesobservacion.find(params[:id])
  end

  def prepara
    @titulacionesobservacion = Titulacionesobservacion.find(params[:id])
  end

  def envia
    titulacionesobservacion = Titulacionesobservacion.find(params[:id].to_i)
    logger.error("valor..."+params[:id].to_s)
    if params[:ubicacion][:user_id].to_s == ""
      flash[:warning] = "Debe registrar el usuario a quien va trasladar la atención registrada"
      redirect_to :controller=>"titulacionesobservaciones", :action=>"prepara", :id=>titulacionesobservacion.id
    else
      @user = User.find(params[:ubicacion][:user_id].to_i)
      #Enviar Email
      begin
        Notifier.deliver_trasladatitulacionesobs_message(@user,titulacionesobservacion,titulacionesobservacion.titulacion.cobama.to_s)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{@user.email rescue nil}")
      end
      #Actualiza Observacion
      @obs = ". #{Time.now.strftime("%Y-%m-%d %X")} SE TRASLADA A "+@user.nombre.to_s+" PARA ASIGNACION DE TRAMITE"
      titulacionesobservacion.observacion = titulacionesobservacion.observacion.to_s+@obs.to_s
      titulacionesobservacion.save
      flash[:notice] = "Enviado"
      redirect_to :controller=>"titulacionesobservaciones", :action=>"enviado"
    end
  end

  private
  def determine_layout
    if ['atencion','prepara','envia','enviado'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

class TitulacionesvisitasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesvisitas = titulacion.titulacionesvisitas.all
  end

  def edit
    @titulacionesvisita  = Titulacionesvisita.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesvisita.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesvisita" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesvisita = Titulacionesvisita.new(params[:titulacionesvisita])
    @titulacionesvisita.user_id = is_admin
    if @titulacionesvisita.valid?
      @titulacion.titulacionesvisitas << @titulacionesvisita
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesvisita','I')
      @titulacionesvisita = Titulacionesvisita.new
      flash[:titulacionesvisita] = "Se guardo el registro con exito"
    else
      flash[:titulacionesvisita] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesvisitas" }
    end
  end

  def update
    @titulacionesvisita        = Titulacionesvisita.new
    titulacionesvisita         = Titulacionesvisita.find(params[:id])
    @titulacion        = titulacionesvisita.titulacion
    ok = titulacionesvisita.update_attributes(params[:titulacionesvisita])
    flash[:titulacionesvisita] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesvisitas" }
    end
  end

  def destroy
    titulacionesvisita   = Titulacionesvisita.find(params[:id])
    @titulacion  = titulacionesvisita.titulacion
    @titulacionesvisita  = Titulacionesvisita.new
    titulacionesvisita.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesvisitas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionesvisitas = persona.titulacionesvisitas.all
  end

  def atencion
    @titulacionesvisitas = Titulacionesvisita.find(params[:id])
  end

  def prepara
    @titulacionesvisita = Titulacionesvisita.find(params[:id])
  end

  def envia
    titulacionesvisita = Titulacionesvisita.find(params[:id].to_i)
    if params[:ubicacion][:user_id].to_s == ""
      flash[:warning] = "Debe registrar el usuario a quien va trasladar la atención registrada"
      redirect_to :controller=>"Titulacionesvisitas", :action=>"prepara", :id=>titulacionesvisita.id
    else
      @user = User.find(params[:ubicacion][:user_id].to_i)
      #Enviar Email
      begin
        Notifier.deliver_trasladatitulacionesvisitaobs_message(@user,titulacionesvisita,titulacionesvisita.titulacion.cobama.to_s)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{@user.email rescue nil}")
      end
      #Actualiza Observacion
      @obs = ". #{Time.now.strftime("%Y-%m-%d %X")} SE TRASLADA A "+@user.nombre.to_s+" PARA ASIGNACION DE TRAMITE"
      if  titulacionesvisita.clase.to_s == "VISITA DE SOCIALIZACION"
        titulacionesvisita.soc_observaciones = titulacionesvisita.soc_observaciones.to_s+@obs.to_s
      elsif titulacionesvisita.clase.to_s == "VISITA DE LEVANTAMIENTO"
        titulacionesvisita.lev_observaciones = titulacionesvisita.lev_observaciones.to_s+@obs.to_s
      end
      titulacionesvisita.save
      flash[:notice] = "Enviado"
      redirect_to :controller=>"titulacionesvisitas", :action=>"enviado"
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
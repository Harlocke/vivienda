class TitulacionesusersController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesusers = titulacion.titulacionesusers.all
  end

  def edit
    @titulacionesuser  = Titulacionesuser.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesuser.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesuser" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesuser = Titulacionesuser.new(params[:titulacionesuser])
    if @titulacionesuser.valid?
      @titulacion.titulacionesusers << @titulacionesuser
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesuser','I')
      @titulacionesuser = Titulacionesuser.new
      flash[:titulacionesuser] = "Se guardo el registro con exito"
    else
      flash[:titulacionesuser] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesusers" }
    end
  end

  def update
    @titulacionesuser        = Titulacionesuser.new
    titulacionesuser         = Titulacionesuser.find(params[:id])
    @titulacion        = titulacionesuser.titulacion
    ok = titulacionesuser.update_attributes(params[:titulacionesuser])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesuser','A')
    end
    flash[:titulacionesuser] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesusers" }
    end
  end

  def destroy
    titulacionesuser   = Titulacionesuser.find(params[:id])
    @titulacion  = titulacionesuser.titulacion
    @titulacionesuser  = Titulacionesuser.new
    titulacionesuser.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesusers" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionesusers = persona.titulacionesusers.all
  end

  private
  def determine_layout
    if ['atencion'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

class TitulacionesafectasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesafectas = titulacion.titulacionesafectas.all
  end

  def edit
    @titulacionesafecta  = Titulacionesafecta.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesafecta.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesafecta" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesafecta = Titulacionesafecta.new(params[:titulacionesafecta])
    @titulacionesafecta.user_id = is_admin
    if @titulacionesafecta.valid?
      @titulacion.titulacionesafectas << @titulacionesafecta
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesafecta','I')
      @titulacionesafecta = Titulacionesafecta.new
      flash[:titulacionesafecta] = "Se guardo el registro con exito"
    else
      flash[:titulacionesafecta] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesafectas" }
    end
  end

  def update
    @titulacionesafecta        = Titulacionesafecta.new
    titulacionesafecta         = Titulacionesafecta.find(params[:id])
    @titulacion        = titulacionesafecta.titulacion
    ok = titulacionesafecta.update_attributes(params[:titulacionesafecta])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesafecta','A')
    end
    flash[:titulacionesafecta] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesafectas" }
    end
  end

  def destroy
    titulacionesafecta   = Titulacionesafecta.find(params[:id])
    @titulacion  = titulacionesafecta.titulacion
    @titulacionesafecta  = Titulacionesafecta.new
    titulacionesafecta.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesafectas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionesafectas = persona.titulacionesafectas.all
  end

  def atencion
    @titulacionesafectas = Titulacionesafecta.find(params[:id])
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
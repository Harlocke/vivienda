class TitulacionesprofesionalesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesprofesionales = titulacion.titulacionesprofesionales.all
  end

  def edit
    @titulacionesprofesional  = Titulacionesprofesional.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesprofesional.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesprofesional" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesprofesional = Titulacionesprofesional.new(params[:titulacionesprofesional])
    if @titulacionesprofesional.valid?
      @titulacion.titulacionesprofesionales << @titulacionesprofesional
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesprofesional','I')
      @titulacionesprofesional = Titulacionesprofesional.new
      flash[:titulacionesprofesional] = "Se guardo el registro con exito"
    else
      flash[:titulacionesprofesional] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesprofesionales" }
    end
  end

  def update
    @titulacionesprofesional        = Titulacionesprofesional.new
    titulacionesprofesional         = Titulacionesprofesional.find(params[:id])
    @titulacion        = titulacionesprofesional.titulacion
    ok = titulacionesprofesional.update_attributes(params[:titulacionesprofesional])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesprofesional','A')
    end
    flash[:titulacionesprofesional] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesprofesionales" }
    end
  end

  def destroy
    titulacionesprofesional   = Titulacionesprofesional.find(params[:id])
    @titulacion  = titulacionesprofesional.titulacion
    @titulacionesprofesional  = Titulacionesprofesional.new
    titulacionesprofesional.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesprofesionales" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionesprofesionales = persona.titulacionesprofesionales.all
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

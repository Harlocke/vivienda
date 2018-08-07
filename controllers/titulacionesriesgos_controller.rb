class TitulacionesriesgosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesriesgos = titulacion.titulacionesriesgos.all
  end

  def edit
    @titulacionesriesgo  = Titulacionesriesgo.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesriesgo.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesriesgo" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesriesgo = Titulacionesriesgo.new(params[:titulacionesriesgo])
    @titulacionesriesgo.user_id = is_admin
    if @titulacionesriesgo.valid?
      @titulacion.titulacionesriesgos << @titulacionesriesgo
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesriesgo','I')
      @titulacionesriesgo = Titulacionesriesgo.new
      flash[:titulacionesriesgo] = "Se guardo el registro con exito"
    else
      flash[:titulacionesriesgo] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesriesgos" }
    end
  end

  def update
    @titulacionesriesgo        = Titulacionesriesgo.new
    titulacionesriesgo         = Titulacionesriesgo.find(params[:id])
    @titulacion        = titulacionesriesgo.titulacion
    ok = titulacionesriesgo.update_attributes(params[:titulacionesriesgo])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesriesgo','A')
    end
    flash[:titulacionesriesgo] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesriesgos" }
    end
  end

  def destroy
    titulacionesriesgo   = Titulacionesriesgo.find(params[:id])
    @titulacion  = titulacionesriesgo.titulacion
    @titulacionesriesgo  = Titulacionesriesgo.new
    titulacionesriesgo.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesriesgos" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionesriesgos = persona.titulacionesriesgos.all
  end

  def atencion
    @titulacionesriesgos = Titulacionesriesgo.find(params[:id])
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
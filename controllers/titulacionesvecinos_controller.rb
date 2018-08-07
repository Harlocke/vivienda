class TitulacionesvecinosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesvecinos = titulacion.titulacionesvecinos.all
  end

  def edit
    @titulacionesvecino  = Titulacionesvecino.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesvecino.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesvecino" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesvecino = Titulacionesvecino.new(params[:titulacionesvecino])
    if @titulacionesvecino.valid?
      @titulacion.titulacionesvecinos << @titulacionesvecino
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesvecino','I')
      @titulacionesvecino = Titulacionesvecino.new
      flash[:titulacionesvecino] = "Se guardo el registro con exito"
    else
      flash[:titulacionesvecino] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesvecinos" }
    end
  end

  def update
    @titulacionesvecino        = Titulacionesvecino.new
    titulacionesvecino         = Titulacionesvecino.find(params[:id])
    @titulacion        = titulacionesvecino.titulacion
    ok = titulacionesvecino.update_attributes(params[:titulacionesvecino])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesvecino','A')
    end
    flash[:titulacionesvecino] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "titulacionesvecinos" }
    end
  end

  def destroy
    titulacionesvecino   = Titulacionesvecino.find(params[:id])
    @titulacion  = titulacionesvecino.titulacion
    @titulacionesvecino  = Titulacionesvecino.new
    titulacionesvecino.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesvecinos" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @titulacionesvecinos = persona.titulacionesvecinos.all
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

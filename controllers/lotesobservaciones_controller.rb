class LotesobservacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    lote   = Lote.find(params[:lote_id])
    @lotesobservaciones = lote.lotesobservaciones.all
  end

  def edit
    @lotesobservacion  = Lotesobservacion.find(params[:id], :include => "lote")
    @lote  = @lotesobservacion.lote
    respond_to do |format|
      format.js { render :action => "edit_lotesobservacion" }
    end
  end

  def create
    @lote  = Lote.find(params[:lote_id])
    @lotesobservacion = Lotesobservacion.new(params[:lotesobservacion])
    @lotesobservacion.user_id = is_admin
    if @lotesobservacion.valid?
      @lote.lotesobservaciones << @lotesobservacion
      @lote.save
      @lotesobservacion = Lotesobservacion.new
      flash[:lotesobservacion] = "Se guardo el registro con exito"
    else
      flash[:lotesobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "lotesobservaciones" }
    end
  end

  def update
    @lotesobservacion        = Lotesobservacion.new
    lotesobservacion         = Lotesobservacion.find(params[:id])
    @lote        = lotesobservacion.lote
    ok = lotesobservacion.update_attributes(params[:lotesobservacion])
    flash[:lotesobservacion] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "lotesobservaciones" }
    end
  end

  def destroy
    lotesobservacion   = Lotesobservacion.find(params[:id])
    @lote  = lotesobservacion.lote
    @lotesobservacion  = Lotesobservacion.new
    lotesobservacion.destroy
    respond_to do |format|
      format.js { render :action => "lotesobservaciones" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @lotesobservaciones = persona.lotesobservaciones.all
  end

  def atencion
    @lotesobservaciones = Lotesobservacion.find(params[:id])
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

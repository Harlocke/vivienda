class QuejasobservacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    queja   = Queja.find(params[:queja_id])
    @quejasobservaciones = queja.quejasobservaciones.all
  end

  def edit
    @quejasobservacion  = Quejasobservacion.find(params[:id], :include => "queja")
    @queja  = @quejasobservacion.queja
    respond_to do |format|
      format.js { render :action => "edit_quejasobservacion" }
    end
  end

  def create
    @queja  = Queja.find(params[:queja_id])
    @quejasobservacion = Quejasobservacion.new(params[:quejasobservacion])
    @quejasobservacion.user_id = is_admin
    if @quejasobservacion.valid?
      @queja.quejasobservaciones << @quejasobservacion
      @queja.save
      @quejasobservacion = Quejasobservacion.new
      flash[:quejasobservacion] = "Se guardo el registro con exito"
    else
      flash[:quejasobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "quejasobservaciones" }
    end
  end

  def update
    @quejasobservacion        = Quejasobservacion.new
    quejasobservacion         = Quejasobservacion.find(params[:id])
    @queja        = quejasobservacion.queja
    ok = quejasobservacion.update_attributes(params[:quejasobservacion])
    flash[:quejasobservacion] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "quejasobservaciones" }
    end
  end

  def destroy
    quejasobservacion   = Quejasobservacion.find(params[:id])
    @queja  = quejasobservacion.queja
    @quejasobservacion  = Quejasobservacion.new
    quejasobservacion.destroy
    respond_to do |format|
      format.js { render :action => "quejasobservaciones" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @quejasobservaciones = persona.quejasobservaciones.all
  end

  def atencion
    @quejasobservaciones = Quejasobservacion.find(params[:id])
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

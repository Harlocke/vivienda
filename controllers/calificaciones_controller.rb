class CalificacionesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @calificaciones = persona.calificaciones.all
  end

 def edit
    @calificacion  = Calificacion.find(params[:id], :include => "persona")
    @persona  = @calificacion.persona
    respond_to do |format|
      format.js { render :action => "edit_calificacion" }
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @calificacion = Calificacion.new(params[:calificacion])
    if @calificacion.valid?
      @persona.calificaciones << @calificacion
      @persona.save
      @calificacion = Calificacion.new
      flash[:notice] = "Creado con exito"
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "calificaciones" }
    end
  end

  def update
    @calificacion        = Calificacion.new
    calificacion         = Calificacion.find(params[:id])
    @persona        = calificacion.persona
    ok = calificacion.update_attributes(params[:calificacion])
    flash[:calificacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "calificaciones" }
    end
  end

  def destroy
    calificacion   = Calificacion.find(params[:id])
    @persona    = calificacion.persona
    @calificacion  = Calificacion.new
    calificacion.destroy
    flash[:notice] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "calificaciones" }
    end
  end
end

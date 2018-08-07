class PersonasclasificacionesController < ApplicationController
  before_filter :require_user

  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @personasclasificaciones = persona.personasclasificaciones.all
    @clasificaciones = Clasificacion.all
  end

 def edit
    @personasclasificacion  = Personasclasificacion.find(params[:id], :include => "persona")
    @persona  = @personasclasificacion.persona
    @clasificaciones = Clasificacion.all
    respond_to do |format|
      format.js { render :action => "edit_personasclasificacion" }
    end
  end

  def visualizar
    @personasclasificacion  = Personasclasificacion.find(params[:id])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @personasclasificacion = Personasclasificacion.new(params[:personasclasificacion])
    if @personasclasificacion.valid?
      @persona.personasclasificaciones << @personasclasificacion
      @persona.save
      @personasclasificacion = Personasclasificacion.new
      @clasificaciones = Clasificacion.all
      flash[:personasclasificacion] = "Creado con exito"
    else
      flash[:personasclasificacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personasclasificaciones" }
    end
  end

  def update
    @personasclasificacion        = Personasclasificacion.new
    personasclasificacion         = Personasclasificacion.find(params[:id])
    @persona        = personasclasificacion.persona
    ok = personasclasificacion.update_attributes(params[:personasclasificacion])
    flash[:personasclasificacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "personasclasificaciones" }
    end
  end

  def destroy
    personasclasificacion   = Personasclasificacion.find(params[:id])
    @persona  = personasclasificacion.persona
    @personasclasificacion  = Personasclasificacion.new
    personasclasificacion.destroy
    flash[:personasclasificacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personasclasificaciones" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end

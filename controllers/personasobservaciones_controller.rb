# encoding: utf-8
class PersonasobservacionesController < ApplicationController

  before_filter :require_user

  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    #@personasobservaciones = persona.personasobservaciones.all
    @personasobservaciones = persona.personasobservaciones.find(:all, :conditions => ['persona_id = ?', params[:persona_id]], :order => 'created_at')
  end

  def edit
    @personasobservacion  = Personasobservacion.find(params[:id], :include => "persona")
    @persona  = @personasobservacion.persona
    respond_to do |format|
      format.js { render :action => "edit_personasobservacion" }
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @personasobservacion = Personasobservacion.new(params[:personasobservacion])
    @personasobservacion.user_id = is_admin
    if @personasobservacion.valid?
      @persona.personasobservaciones << @personasobservacion
      @persona.save
      @personasobservacion = Personasobservacion.new
      flash[:personasobservacion] = "Creado con exito"
    else
      flash[:personasobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personasobservaciones" }
    end
  end
  
  def update
    @personasobservacion        = Personasobservacion.new
    personasobservacion         = Personasobservacion.find(params[:id])
    @persona        = personasobservacion.persona
    ok = personasobservacion.update_attributes(params[:personasobservacion])
    flash[:personasobservacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "personasobservaciones" }
    end
  end

  def destroy
    personasobservacion   = Personasobservacion.find(params[:id])
    @persona  = personasobservacion.persona
    @personasobservacion  = Personasobservacion.new
    personasobservacion.destroy
    flash[:personasobservacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personasobservaciones" }
    end
  end

  def atencion
    @personasobservaciones = Personasobservacion.find(params[:id])
  end

  def atencionpdf
    @personasobservaciones = Personasobservacion.find(params[:id])
    respond_to do |format|
      format.pdf  { render :layout => false }
    end
  end

  private
  def determine_layout
    if ['atencion','atencionpdf'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

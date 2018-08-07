class PersonasarrendamientosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @personasarrendamientos = persona.personasarrendamientos.all
  end

  def edit
    @personasarrendamiento  = Personasarrendamiento.find(params[:id], :include => "persona")
    @persona  = @personasarrendamiento.persona
    respond_to do |format|
      format.js { render :action => "edit_personasarrendamiento" }
    end
  end

  def buscar
    respond_to do |format|
      format.html
      format.xls if params[:format] == 'xls'
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @personasarrendamiento = Personasarrendamiento.new(params[:personasarrendamiento])
    @personasarrendamiento.user_id = is_admin
    if @personasarrendamiento.valid?
      @persona.personasarrendamientos << @personasarrendamiento
      @persona.save
      @personasarrendamiento = Personasarrendamiento.new
      flash[:personasarrendamiento] = "Registro almacenado con Exito"
    else
      flash[:personasarrendamiento] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personasarrendamientos" }
    end
  end

  def update
    @personasarrendamiento        = Personasarrendamiento.new
    personasarrendamiento         = Personasarrendamiento.find(params[:id])
    personasarrendamiento.user_actualiza = is_admin
    @persona        = personasarrendamiento.persona
    ok = personasarrendamiento.update_attributes(params[:personasarrendamiento])
    flash[:personasarrendamiento] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "personasarrendamientos" }
    end
  end

  def destroy
    personasarrendamiento   = Personasarrendamiento.find(params[:id])
    @persona  = personasarrendamiento.persona
    @personasarrendamiento  = Personasarrendamiento.new
    personasarrendamiento.destroy
    respond_to do |format|
      format.js { render :action => "personasarrendamientos" }
    end
  end

  def datos
    @personasarrendamiento   = Personasarrendamiento.find(params[:id])
    @arrendamientoscontrato = Arrendamientoscontrato.new
  end

  private
  def determine_layout
    if ['actaaprobacionobra'].include?(action_name)
      "atencion"
    elsif['informeoperador','informefinanciero','informeactualizacion','informepersonal','informecomuna','informeconcepto','informeseguimiento'].include?(action_name)
      "excel"
    else
      "application"
    end
  end

end
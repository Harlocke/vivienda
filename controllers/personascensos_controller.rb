class PersonascensosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @personascensos = persona.personascensos.all
  end

  def visualizar
    @personascenso  = Personascenso.find(params[:id])
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="informecensopuente93-94_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @personascensos = Personascenso.all
  end

  def edit
    @personascenso  = Personascenso.find(params[:id], :include => "persona")
    @persona  = @personascenso.persona
    respond_to do |format|
      format.js { render :action => "edit_personascenso" }
    end
  end

  def visualizar
    @personascenso  = Personascenso.find(params[:id])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @personascenso = Personascenso.new(params[:personascenso])
    if @personascenso.valid?
      @persona.personascensos << @personascenso
      @persona.save
      @personascenso = Personascenso.new
      flash[:personascenso] = "Creado con exito"
    else
      flash[:personascenso] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personascensos" }
    end
  end

  def update
    @personascenso        = Personascenso.new
    personascenso         = Personascenso.find(params[:id])
    @persona        = personascenso.persona
    ok = personascenso.update_attributes(params[:personascenso])
    flash[:personascenso] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "personascensos" }
    end
  end

  def destroy
    personascenso   = Personascenso.find(params[:id])
    @persona  = personascenso.persona
    @personascenso  = Personascenso.new
    personascenso.destroy
    flash[:personascenso] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personascensos" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
    end
  end
end

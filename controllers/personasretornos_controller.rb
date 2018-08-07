class PersonasretornosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @personasretornos = persona.personasretornos.all
  end

  def visualizar
    @personasretorno  = Personasretorno.find(params[:id])
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="informeplanretorno_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @personasretornos = Personasretorno.all
  end

  def edit
    @personasretorno  = Personasretorno.find(params[:id], :include => "persona")
    @persona  = @personasretorno.persona
    respond_to do |format|
      format.js { render :action => "edit_personasretorno" }
    end
  end

  def visualizar
    @personasretorno  = Personasretorno.find(params[:id])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @personasretorno = Personasretorno.new(params[:personasretorno])
    if @personasretorno.valid?
      @persona.personasretornos << @personasretorno
      @persona.save
      @personasretorno = Personasretorno.new
      flash[:personasretorno] = "Creado con exito"
    else
      flash[:personasretorno] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personasretornos" }
    end
  end

  def update
    @personasretorno        = Personasretorno.new
    personasretorno         = Personasretorno.find(params[:id])
    @persona        = personasretorno.persona
    ok = personasretorno.update_attributes(params[:personasretorno])
    flash[:personasretorno] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "personasretornos" }
    end
  end

  def destroy
    personasretorno   = Personasretorno.find(params[:id])
    @persona  = personasretorno.persona
    @personasretorno  = Personasretorno.new
    personasretorno.destroy
    flash[:personasretorno] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personasretornos" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
    end
  end
end

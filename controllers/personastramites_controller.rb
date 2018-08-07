class PersonastramitesController < ApplicationController
before_filter :require_user

  def index
    persona   = Persona.find(params[:persona_id])
    @personastramites = persona.personastramites.all
  end

  def edit
    @personastramite  = Personastramite.find(params[:id], :include => "persona")
    @persona  = @personastramite.persona
    respond_to do |format|
      format.js { render :action => "edit_personastramite" }
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
    @personastramite = Personastramite.new(params[:personastramite])
    @personastramite.user_id = is_admin
    if @personastramite.valid?
      @persona.personastramites << @personastramite
      @persona.save
      @personastramite = Personastramite.new
      flash[:personastramite] = "Registro almacenado con Exito"
    else
      flash[:personastramite] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personastramites" }
    end
  end

  def update
    @personastramite        = Personastramite.new
    personastramite         = Personastramite.find(params[:id])
    personastramite.useract_id = is_admin
    @persona        = personastramite.persona
    ok = personastramite.update_attributes(params[:personastramite])
    flash[:personastramite] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "personastramites" }
    end
  end

  def destroy
    personastramite   = Personastramite.find(params[:id])
    @persona  = personastramite.persona
    @personastramite  = Personastramite.new
    personastramite.destroy
    respond_to do |format|
      format.js { render :action => "personastramites" }
    end
  end
end
class PersonaslistasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @personaslistas = persona.personaslistas.all
  end

 def edit
    @personaslista  = Personaslista.find(params[:id], :include => "persona")
    @persona  = @personaslista.persona
    respond_to do |format|
      format.js { render :action => "edit_personaslista" }
    end
  end

 def informe
    @persona  = Persona.find(params[:id])
    if params[:format] == 'xls'
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Presupuestos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
         format.xls
      end
    else
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @personaslista = Personaslista.new(params[:personaslista])
    if @personaslista.valid?
      @persona.personaslistas << @personaslista
      @persona.save
      @personaslista = Personaslista.new
      flash[:personaslista] = "Creado con exito"
    else
      flash[:personaslista] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personaslistas" }
    end
  end

  def update
    @personaslista        = Personaslista.new
    personaslista         = Personaslista.find(params[:id])
    @persona        = personaslista.persona
     params[:personaslista][:user_actualiza] = is_admin
    ok = personaslista.update_attributes(params[:personaslista])
    flash[:personaslista] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "personaslistas" }
    end
  end

  def destroy
    personaslista   = Personaslista.find(params[:id])
    @persona  = personaslista.persona
    @personaslista  = Personaslista.new
    personaslista.destroy
    flash[:personaslista] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personaslistas" }
    end
  end

  def atencion
    @personaslistas = Personaslista.find(params[:id])
  end

  private
  def determine_layout
    if ['informe'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

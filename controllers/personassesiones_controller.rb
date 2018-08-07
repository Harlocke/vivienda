class PersonassesionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @personassesiones = persona.personassesiones.all
  end

 def edit
    @personassesion  = Personassesion.find(params[:id], :include => "persona")
    @persona  = @personassesion.persona
    respond_to do |format|
      format.js { render :action => "edit_personassesion" }
    end
  end

  def informesesion
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Autorizaciones_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @personassesiones = Personassesion.search(params[:ubicacion][:fchinicial],
                                              params[:ubicacion][:fchfinal],
                                              params[:ubicacion][:motivo],
                                              params[:ubicacion][:tipo],
                                              params[:ubicacion][:respuesta])
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @personassesion = Personassesion.new(params[:personassesion])
    @personassesion.user_id = is_admin
    if @personassesion.valid?
      @persona.personassesiones << @personassesion
      @persona.save
      @personassesion = Personassesion.new
      flash[:personassesion] = "Creado con exito"
    else
      flash[:personassesion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personassesiones" }
    end
  end

  def update
    @personassesion        = Personassesion.new
    personassesion         = Personassesion.find(params[:id])
    @persona        = personassesion.persona
    ok = personassesion.update_attributes(params[:personassesion])
    flash[:personassesion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "personassesiones" }
    end
  end

  def destroy
    personassesion   = Personassesion.find(params[:id])
    @persona  = personassesion.persona
    @personassesion  = Personassesion.new
    personassesion.destroy
    flash[:personassesion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personassesiones" }
    end
  end

  private
  def determine_layout
    if ['informesesion'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end
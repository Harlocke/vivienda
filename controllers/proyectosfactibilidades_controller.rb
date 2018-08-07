class ProyectosfactibilidadesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    proyecto   = Proyecto.find(params[:proyecto_id])
    @proyectosfactibilidades = proyecto.proyectosfactibilidades.all
  end

  def visualizar
    @proyectosfactibilidad = Proyectosfactibilidad.find(params[:id])
  end


  def edit
    @proyectosfactibilidad  = Proyectosfactibilidad.find(params[:id], :include => "proyecto")
    @proyecto  = @proyectosfactibilidad.proyecto
    respond_to do |format|
      format.js { render :action => "edit_proyectosfactibilidad" }
    end
  end

 def create
    @proyecto  = Proyecto.find(params[:proyecto_id])
    @proyectosfactibilidad = Proyectosfactibilidad.new(params[:proyectosfactibilidad])
  @proyectosfactibilidad.user_id = is_admin
    @proyectosfactibilidad.proyecto_id = @proyecto.id
    if @proyectosfactibilidad.valid?
      @proyecto.proyectosfactibilidades << @proyectosfactibilidad
      @proyecto.save
      @proyectosfactibilidad = Proyectosfactibilidad.new
      flash[:proyectosfactibilidad] = "Creado con exito"
    else
      flash[:proyectosfactibilidad] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "proyectosfactibilidades" }
    end
  end

  def update
    @proyectosfactibilidad        = Proyectosfactibilidad.new
    proyectosfactibilidad         = Proyectosfactibilidad.find(params[:id])
    @proyecto        = proyectosfactibilidad.proyecto
    ok = proyectosfactibilidad.update_attributes(params[:proyectosfactibilidad])
    if ok == true
      flash[:proyectosfactibilidad] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "proyectosfactibilidades" }
      end
    else
      flash[:proyectosfactibilidad] = "Se produjo un error al guardar el registro"
      render :update do |page|
        page.alert "ATENCIÓN: El Registro presenta inconsistencias y no se permite Actualizar. Verifique la edad y los campos obligatorios"
      end
    end
  end

  def destroy
    proyectosfactibilidad   = Proyectosfactibilidad.find(params[:id])
    @proyecto  = proyectosfactibilidad.proyecto
    @proyectosfactibilidad  = Proyectosfactibilidad.new
    proyectosfactibilidad.destroy
    flash[:proyectosfactibilidad] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "proyectosfactibilidades" }
    end
  end

  def update2
    @proyectosfactibilidad = Proyectosfactibilidad.find(params[:id])
    if @proyectosfactibilidad.update_attributes(params[:proyectosfactibilidad])
      flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit2_proyectosfactibilidad_path(@proyectosfactibilidad)
    else
      #flash[:notice] = "Error. Debe completar todos los datos obligatorios"
      render :action => "edit2"
    end
#    rescue
#      redirect_to edit2_persona_path(@persona)
  end

  private
  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "informes"
    else
      "application"
    end
  end
end
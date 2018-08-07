class ProyectoscopcomitesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    proyectoscopropiedad   = Proyectoscopropiedad.find(params[:proyectoscopropiedad_id])
    @proyectoscopcomites = proyectoscopropiedad.proyectoscopcomites.all
  end

  def visualizar
    @proyectoscopcomite = Proyectoscopcomite.find(params[:id])
  end


  def edit
    @proyectoscopcomite  = Proyectoscopcomite.find(params[:id], :include => "proyectoscopropiedad")
    @proyectoscopropiedad  = @proyectoscopcomite.proyectoscopropiedad
    respond_to do |format|
      format.js { render :action => "edit_proyectoscopcomite" }
    end
  end

 def create
    @proyectoscopropiedad  = Proyectoscopropiedad.find(params[:proyectoscopropiedad_id])
    @proyectoscopcomite = Proyectoscopcomite.new(params[:proyectoscopcomite])
    @proyectoscopcomite.proyectoscopropiedad_id = @proyectoscopropiedad.id
    if @proyectoscopcomite.valid?
      @proyectoscopropiedad.proyectoscopcomites << @proyectoscopcomite
      @proyectoscopropiedad.save
      @proyectoscopcomite = Proyectoscopcomite.new
      flash[:proyectoscopcomite] = "Creado con exito"
    else
      flash[:proyectoscopcomite] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "proyectoscopcomites" }
    end
  end

  def update
    @proyectoscopcomite        = Proyectoscopcomite.new
    proyectoscopcomite         = Proyectoscopcomite.find(params[:id])
    @proyectoscopropiedad        = proyectoscopcomite.proyectoscopropiedad
    ok = proyectoscopcomite.update_attributes(params[:proyectoscopcomite])
    if ok == true
      flash[:proyectoscopcomite] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "proyectoscopcomites" }
      end
    else
      flash[:proyectoscopcomite] = "Se produjo un error al guardar el registro"
      render :update do |page|
        page.alert "ATENCIÓN: El Registro presenta inconsistencias y no se permite Actualizar. Verifique la edad y los campos obligatorios"
      end
    end
  end

  def destroy
    proyectoscopcomite   = Proyectoscopcomite.find(params[:id])
    @proyectoscopropiedad  = proyectoscopcomite.proyectoscopropiedad
    @proyectoscopcomite  = Proyectoscopcomite.new
    proyectoscopcomite.destroy
    flash[:proyectoscopcomite] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "proyectoscopcomites" }
    end
  end

  def update2
    @proyectoscopcomite = Proyectoscopcomite.find(params[:id])
    if @proyectoscopcomite.update_attributes(params[:proyectoscopcomite])
      flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit2_proyectoscopcomite_path(@proyectoscopcomite)
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
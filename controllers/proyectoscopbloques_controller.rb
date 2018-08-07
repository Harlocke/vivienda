class ProyectoscopbloquesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    proyectoscopropiedad   = Proyectoscopropiedad.find(params[:proyectoscopropiedad_id])
    @proyectoscopbloques = proyectoscopropiedad.proyectoscopbloques.all
  end

  def visualizar
    @proyectoscopbloque = Proyectoscopbloque.find(params[:id])
  end


  def edit
    @proyectoscopbloque  = Proyectoscopbloque.find(params[:id], :include => "proyectoscopropiedad")
    @proyectoscopropiedad  = @proyectoscopbloque.proyectoscopropiedad
    respond_to do |format|
      format.js { render :action => "edit_proyectoscopbloque" }
    end
  end

 def create
    @proyectoscopropiedad  = Proyectoscopropiedad.find(params[:proyectoscopropiedad_id])
    @proyectoscopbloque = Proyectoscopbloque.new(params[:proyectoscopbloque])
    @proyectoscopbloque.proyectoscopropiedad_id = @proyectoscopropiedad.id
    @proyectoscopbloque.proyecto_id = @proyectoscopropiedad.proyecto.id
    if @proyectoscopbloque.valid?
      @proyectoscopropiedad.proyectoscopbloques << @proyectoscopbloque
      @proyectoscopropiedad.save
      @proyectoscopbloque = Proyectoscopbloque.new
      flash[:proyectoscopbloque] = "Creado con exito"
    else
      flash[:proyectoscopbloque] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "proyectoscopbloques" }
    end
  end

  def update
    @proyectoscopbloque        = Proyectoscopbloque.new
    proyectoscopbloque         = Proyectoscopbloque.find(params[:id])
    @proyectoscopropiedad        = proyectoscopbloque.proyectoscopropiedad
    ok = proyectoscopbloque.update_attributes(params[:proyectoscopbloque])
    if ok == true
      flash[:proyectoscopbloque] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "proyectoscopbloques" }
      end
    else
      flash[:proyectoscopbloque] = "Se produjo un error al guardar el registro"
      render :update do |page|
        page.alert "ATENCIÓN: El Registro presenta inconsistencias y no se permite Actualizar. Verifique la edad y los campos obligatorios"
      end
    end
  end

  def destroy
    proyectoscopbloque   = Proyectoscopbloque.find(params[:id])
    @proyectoscopropiedad  = proyectoscopbloque.proyectoscopropiedad
    @proyectoscopbloque  = Proyectoscopbloque.new
    proyectoscopbloque.destroy
    flash[:proyectoscopbloque] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "proyectoscopbloques" }
    end
  end

  def update2
    @proyectoscopbloque = Proyectoscopbloque.find(params[:id])
    if @proyectoscopbloque.update_attributes(params[:proyectoscopbloque])
      flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit2_proyectoscopbloque_path(@proyectoscopbloque)
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
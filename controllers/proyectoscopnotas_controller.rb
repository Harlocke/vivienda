class ProyectoscopnotasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    proyectoscopropiedad   = Proyectoscopropiedad.find(params[:proyectoscopropiedad_id])
    @proyectoscopnotas = proyectoscopropiedad.proyectoscopnotas.all
  end

  def visualizar
    @proyectoscopnota = Proyectoscopnota.find(params[:id])
  end


  def edit
    @proyectoscopnota  = Proyectoscopnota.find(params[:id], :include => "proyectoscopropiedad")
    @proyectoscopropiedad  = @proyectoscopnota.proyectoscopropiedad
    respond_to do |format|
      format.js { render :action => "edit_proyectoscopnota" }
    end
  end

 def create
    @proyectoscopropiedad  = Proyectoscopropiedad.find(params[:proyectoscopropiedad_id])
    @proyectoscopnota = Proyectoscopnota.new(params[:proyectoscopnota])
    @proyectoscopnota.user_id = is_admin
    @proyectoscopnota.proyectoscopropiedad_id = @proyectoscopropiedad.id
    if @proyectoscopnota.valid?
      @proyectoscopropiedad.proyectoscopnotas << @proyectoscopnota
      @proyectoscopropiedad.save
      @proyectoscopnota = Proyectoscopnota.new
      flash[:proyectoscopnota] = "Creado con exito"
    else
      flash[:proyectoscopnota] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "proyectoscopnotas" }
    end
  end

  def update
    @proyectoscopnota        = Proyectoscopnota.new
    proyectoscopnota         = Proyectoscopnota.find(params[:id])
    params[:proyectoscopnota][:user_actualiza] = is_admin
    @proyectoscopropiedad        = proyectoscopnota.proyectoscopropiedad
    ok = proyectoscopnota.update_attributes(params[:proyectoscopnota])
    if ok == true
      flash[:proyectoscopnota] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "proyectoscopnotas" }
      end
    else
      flash[:proyectoscopnota] = "Se produjo un error al guardar el registro"
      render :update do |page|
        page.alert "ATENCIÓN: El Registro presenta inconsistencias y no se permite Actualizar. Verifique la edad y los campos obligatorios"
      end
    end
  end

  def destroy
    proyectoscopnota   = Proyectoscopnota.find(params[:id])
    @proyectoscopropiedad  = proyectoscopnota.proyectoscopropiedad
    @proyectoscopnota  = Proyectoscopnota.new
    proyectoscopnota.destroy
    flash[:proyectoscopnota] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "proyectoscopnotas" }
    end
  end

  def update2
    @proyectoscopnota = Proyectoscopnota.find(params[:id])
    if @proyectoscopnota.update_attributes(params[:proyectoscopnota])
      flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit2_proyectoscopnota_path(@proyectoscopnota)
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
class AyudasorientacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudasorientaciones = ayuda.ayudasorientaciones.all
  end

 def edit
    @ayudasorientacion  = Ayudasorientacion.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudasorientacion.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudasorientacion" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudasorientacion = Ayudasorientacion.new(params[:ayudasorientacion])
    @ayudasorientacion.user_id = is_admin
    if @ayudasorientacion.valid?
      @ayuda.ayudasorientaciones << @ayudasorientacion
      @ayuda.save
      @ayudasorientacion = Ayudasorientacion.new
      flash[:ayudasorientacion] = "Creado con exito"
    else
      flash[:ayudasorientacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudasorientaciones" }
    end
  end

  def update
    @ayudasorientacion        = Ayudasorientacion.new
    ayudasorientacion         = Ayudasorientacion.find(params[:id])
    #ayudasorientacion.user_id = is_admin
    @ayuda        = ayudasorientacion.ayuda
    ok = ayudasorientacion.update_attributes(params[:ayudasorientacion])
    flash[:ayudasorientacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudasorientaciones" }
    end
  end

  def destroy
    ayudasorientacion   = Ayudasorientacion.find(params[:id])
    @ayuda  = ayudasorientacion.ayuda
    @ayudasorientacion  = Ayudasorientacion.new
    ayudasorientacion.destroy
    flash[:ayudasorientacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudasorientaciones" }
    end
  end
end
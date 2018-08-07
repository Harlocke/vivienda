class AyudasobservacionesController < ApplicationController
  before_filter :require_user

  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    #@ayudasobservaciones = ayuda.ayudasobservaciones.all
    @ayudasobservaciones = ayuda.ayudasobservaciones.find(:all, :conditions => ['ayuda_id = ?', params[:ayuda_id]], :order => 'created_at')
  end

  def edit
    @ayudasobservacion  = Ayudasobservacion.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudasobservacion.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudasobservacion" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudasobservacion = Ayudasobservacion.new(params[:ayudasobservacion])
    @ayudasobservacion.user_id = is_admin
    if @ayudasobservacion.valid?
      @ayuda.ayudasobservaciones << @ayudasobservacion
      @ayuda.save
      @ayudasobservacion = Ayudasobservacion.new
      flash[:ayudasobservacion] = "Creado con exito"
    else
      flash[:ayudasobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudasobservaciones" }
    end
  end

  def update
    @ayudasobservacion        = Ayudasobservacion.new
    ayudasobservacion         = Ayudasobservacion.find(params[:id])
    @ayuda        = ayudasobservacion.ayuda
    ok = ayudasobservacion.update_attributes(params[:ayudasobservacion])
    flash[:ayudasobservacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudasobservaciones" }
    end
  end

  def destroy
    ayudasobservacion   = Ayudasobservacion.find(params[:id])
    @ayuda  = ayudasobservacion.ayuda
    @ayudasobservacion  = Ayudasobservacion.new
    ayudasobservacion.destroy
    flash[:ayudasobservacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudasobservaciones" }
    end
  end

  def atencion
    @ayudasobservaciones = Ayudasobservacion.find(params[:id])
  end

  private
  def determine_layout
    if ['atencion'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
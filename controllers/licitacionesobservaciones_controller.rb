class LicitacionesobservacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    licitacion   = Licitacion.find(params[:licitacion_id])
    #@licitacionesobservaciones = licitacion.licitacionesobservaciones.all
    @licitacionesobservaciones = licitacion.licitacionesobservaciones.find(:all, :conditions => ['licitacion_id = ?', params[:licitacion_id]], :order => 'created_at')
  end

  def edit
    @licitacionesobservacion  = Licitacionesobservacion.find(params[:id], :include => "licitacion")
    @licitacion  = @licitacionesobservacion.licitacion
    respond_to do |format|
      format.js { render :action => "edit_licitacionesobservacion" }
    end
  end

  def create
    @licitacion  = Licitacion.find(params[:licitacion_id])
    @licitacionesobservacion = Licitacionesobservacion.new(params[:licitacionesobservacion])
    @licitacionesobservacion.user_id = is_admin
    if @licitacionesobservacion.valid?
      @licitacion.licitacionesobservaciones << @licitacionesobservacion
      @licitacion.save
      @licitacionesobservacion = Licitacionesobservacion.new
      flash[:licitacionesobservacion] = "Creado con exito"
    else
      flash[:licitacionesobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "licitacionesobservaciones" }
    end
  end

  def update
    @licitacionesobservacion        = Licitacionesobservacion.new
    licitacionesobservacion         = Licitacionesobservacion.find(params[:id])
    @licitacion        = licitacionesobservacion.licitacion
    ok = licitacionesobservacion.update_attributes(params[:licitacionesobservacion])
    flash[:licitacionesobservacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "licitacionesobservaciones" }
    end
  end

  def destroy
    licitacionesobservacion   = Licitacionesobservacion.find(params[:id])
    @licitacion  = licitacionesobservacion.licitacion
    @licitacionesobservacion  = Licitacionesobservacion.new
    licitacionesobservacion.destroy
    flash[:licitacionesobservacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "licitacionesobservaciones" }
    end
  end

  def atencion
    @licitacionesobservaciones = Licitacionesobservacion.find(params[:id])
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

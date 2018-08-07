class SeguimientosobservacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    seguimiento   = Seguimiento.find(params[:seguimiento_id])
    #@seguimientosobservaciones = seguimiento.seguimientosobservaciones.all
    @seguimientosobservaciones = seguimiento.seguimientosobservaciones.find(:all, :conditions => ['seguimiento_id = ?', params[:seguimiento_id]], :order => 'created_at')
  end

  def edit
    @seguimientosobservacion  = Seguimientosobservacion.find(params[:id], :include => "seguimiento")
    @seguimiento  = @seguimientosobservacion.seguimiento
    respond_to do |format|
      format.js { render :action => "edit_seguimientosobservacion" }
    end
  end

  def create
    @seguimiento  = Seguimiento.find(params[:seguimiento_id])
    @seguimientosobservacion = Seguimientosobservacion.new(params[:seguimientosobservacion])
    @seguimientosobservacion.user_id = is_admin
    if @seguimientosobservacion.valid?
      @seguimiento.seguimientosobservaciones << @seguimientosobservacion
      @seguimiento.save
      @seguimientosobservacion = Seguimientosobservacion.new
      flash[:seguimientosobservacion] = "Creado con exito"
    else
      flash[:seguimientosobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "seguimientosobservaciones" }
    end
  end

  def update
    @seguimientosobservacion        = Seguimientosobservacion.new
    seguimientosobservacion         = Seguimientosobservacion.find(params[:id])
    @seguimiento        = seguimientosobservacion.seguimiento
    ok = seguimientosobservacion.update_attributes(params[:seguimientosobservacion])
    flash[:seguimientosobservacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "seguimientosobservaciones" }
    end
  end

  def destroy
    seguimientosobservacion   = Seguimientosobservacion.find(params[:id])
    @seguimiento  = seguimientosobservacion.seguimiento
    @seguimientosobservacion  = Seguimientosobservacion.new
    seguimientosobservacion.destroy
    flash[:seguimientosobservacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "seguimientosobservaciones" }
    end
  end

  def atencion
    @seguimientosobservaciones = Seguimientosobservacion.find(params[:id])
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

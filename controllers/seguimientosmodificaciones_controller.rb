class SeguimientosmodificacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    seguimiento   = Seguimiento.find(params[:seguimiento_id])
    #@seguimientosmodificaciones = seguimiento.seguimientosmodificaciones.all
    @seguimientosmodificaciones = seguimiento.seguimientosmodificaciones.find(:all, :conditions => ['seguimiento_id = ?', params[:seguimiento_id]], :order => 'created_at')
  end

  def edit
    @seguimientosmodificacion  = Seguimientosmodificacion.find(params[:id], :include => "seguimiento")
    @seguimiento  = @seguimientosmodificacion.seguimiento
    respond_to do |format|
      format.js { render :action => "edit_seguimientosmodificacion" }
    end
  end

  def create
    @seguimiento  = Seguimiento.find(params[:seguimiento_id])
    @seguimientosmodificacion = Seguimientosmodificacion.new(params[:seguimientosmodificacion])
    #@seguimientosmodificacion.user_id = is_admin
    if @seguimientosmodificacion.valid?
      @seguimiento.seguimientosmodificaciones << @seguimientosmodificacion
      @seguimiento.save
      @seguimientosmodificacion = Seguimientosmodificacion.new
      flash[:seguimientosmodificacion] = "Creado con exito"
    else
      flash[:seguimientosmodificacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "seguimientosmodificaciones" }
    end
  end

  def update
    @seguimientosmodificacion        = Seguimientosmodificacion.new
    seguimientosmodificacion         = Seguimientosmodificacion.find(params[:id])
    @seguimiento        = seguimientosmodificacion.seguimiento
    ok = seguimientosmodificacion.update_attributes(params[:seguimientosmodificacion])
    flash[:seguimientosmodificacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "seguimientosmodificaciones" }
    end
  end

  def destroy
    seguimientosmodificacion   = Seguimientosmodificacion.find(params[:id])
    @seguimiento  = seguimientosmodificacion.seguimiento
    @seguimientosmodificacion  = Seguimientosmodificacion.new
    seguimientosmodificacion.destroy
    flash[:seguimientosmodificacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "seguimientosmodificaciones" }
    end
  end

  def atencion
    @seguimientosmodificaciones = Seguimientosmodificacion.find(params[:id])
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

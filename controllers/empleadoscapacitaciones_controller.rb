class EmpleadoscapacitacionesController < ApplicationController

  before_filter :require_user
  def index
    empleado   = Empleado.find(params[:empleado_id])
    @empleadoscapacitaciones = empleado.empleadoscapacitaciones.all
  end

  def edit
    @empleadoscapacitacion  = Empleadoscapacitacion.find(params[:id], :include => "empleado")
    @empleado  = @empleadoscapacitacion.empleado
    respond_to do |format|
      format.js { render :action => "edit_empleadoscapacitacion" }
    end
  end

  def buscar
        respond_to do |format|
           format.html
           format.xls if params[:format] == 'xls'
        end
  end

  def create
    @empleado  = Empleado.find(params[:empleado_id])
    @empleadoscapacitacion = Empleadoscapacitacion.new(params[:empleadoscapacitacion])
    if @empleadoscapacitacion.valid?
      @empleado.empleadoscapacitaciones << @empleadoscapacitacion
      @empleado.save
      @empleadoscapacitacion = Empleadoscapacitacion.new
      flash[:empleadoscapacitacion] = "Registro almacenado con Exito"
    else
      flash[:empleadoscapacitacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "empleadoscapacitaciones" }
    end
  end

  def update
    @empleadoscapacitacion        = Empleadoscapacitacion.new
    empleadoscapacitacion         = Empleadoscapacitacion.find(params[:id])
    @empleado        = empleadoscapacitacion.empleado
    ok = empleadoscapacitacion.update_attributes(params[:empleadoscapacitacion])
    flash[:empleadoscapacitacion] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "empleadoscapacitaciones" }
    end
  end

  def destroy
    empleadoscapacitacion   = Empleadoscapacitacion.find(params[:id])
    @empleado  = empleadoscapacitacion.empleado
    @empleadoscapacitacion  = Empleadoscapacitacion.new
    empleadoscapacitacion.destroy
    respond_to do |format|
      format.js { render :action => "empleadoscapacitaciones" }
    end
  end
end

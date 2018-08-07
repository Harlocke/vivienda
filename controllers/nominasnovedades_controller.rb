class NominasnovedadesController < ApplicationController
before_filter :require_user
  def index
    empleado   = Empleado.find(params[:empleado_id])
    @nominasnovedades = empleado.nominasnovedades.all
  end

  def edit
    @nominasnovedad  = Nominasnovedad.find(params[:id], :include => "empleado")
    @empleado  = @nominasnovedad.empleado
    respond_to do |format|
      format.js { render :action => "edit_nominasnovedad" }
    end
  end

  def create
    @empleado  = Empleado.find(params[:empleado_id])
    @nominasnovedad = Nominasnovedad.new(params[:nominasnovedad])
    if @nominasnovedad.valid?
      @empleado.nominasnovedades << @nominasnovedad
      @empleado.save
      @nominasnovedad = Nominasnovedad.new
      flash[:novedad] = "Registro almacenado con Exito"
    else
      flash[:novedad] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "nominasnovedades" }
    end
  end

  def update
    @nominasnovedad        = Nominasnovedad.new
    nominasnovedad         = Nominasnovedad.find(params[:id])
    @empleado        = nominasnovedad.empleado
    ok = nominasnovedad.update_attributes(params[:nominasnovedad])
    flash[:novedad] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "nominasnovedades" }
    end
  end

  def destroy
    nominasnovedad   = Nominasnovedad.find(params[:id])
    @empleado  = nominasnovedad.empleado
    @nominasnovedad  = Nominasnovedad.new
    nominasnovedad.destroy
    respond_to do |format|
      format.js { render :action => "nominasnovedades" }
    end
  end

end

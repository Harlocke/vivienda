class ContratosvinculadosController < ApplicationController

  before_filter :require_user
  def index
    empleado   = Empleado.find(params[:empleado_id])
    @contratosvinculados = empleado.contratosvinculados.all
  end

  def edit
    @contratosvinculado  = Contratosvinculado.find(params[:id], :include => "empleado")
    @empleado  = @contratosvinculado.empleado
    respond_to do |format|
      format.js { render :action => "edit_contratosvinculado" }
    end
  end

  def create
    @empleado  = Empleado.find(params[:empleado_id])
    @contratosvinculado = Contratosvinculado.new(params[:contratosvinculado])
    if @contratosvinculado.valid?
      @empleado.contratosvinculados << @contratosvinculado
      @empleado.save
      @contratosvinculado = Contratosvinculado.new
      flash[:contratosvinculado] = "Registro almacenado con Exito"
    else
      flash[:contratosvinculado] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "contratosvinculados" }
    end
  end

  def update
    @contratosvinculado        = Contratosvinculado.new
    contratosvinculado         = Contratosvinculado.find(params[:id])
    @empleado        = contratosvinculado.empleado
    ok = contratosvinculado.update_attributes(params[:contratosvinculado])
    flash[:contratosvinculado] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "contratosvinculados" }
    end
  end

  def destroy
    contratosvinculado   = Contratosvinculado.find(params[:id])
    @empleado  = contratosvinculado.empleado
    @contratosvinculado  = Contratosvinculado.new
    contratosvinculado.destroy
    respond_to do |format|
      format.js { render :action => "contratosvinculados" }
    end
  end
end

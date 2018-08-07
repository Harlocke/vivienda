class ContratosretefuentesController < ApplicationController

  before_filter :require_user
  def index
    empleado   = Empleado.find(params[:empleado_id])
    @contratosretefuentes = empleado.contratosretefuentes.all
  end

  def edit
    @contratosretefuente  = Contratosretefuente.find(params[:id], :include => "empleado")
    @empleado  = @contratosretefuente.empleado
    respond_to do |format|
      format.js { render :action => "edit_contratosretefuente" }
    end
  end

  def create
    @empleado  = Empleado.find(params[:empleado_id])
    @contratosretefuente = Contratosretefuente.new(params[:contratosretefuente])
    if @contratosretefuente.valid?
      @empleado.contratosretefuentes << @contratosretefuente
      @empleado.save
      @contratosretefuente = Contratosretefuente.new
      flash[:contratosretefuente] = "Registro almacenado con Exito"
    else
      flash[:contratosretefuente] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "contratosretefuentes" }
    end
  end

  def update
    @contratosretefuente        = Contratosretefuente.new
    contratosretefuente         = Contratosretefuente.find(params[:id])
    @empleado        = contratosretefuente.empleado
    ok = contratosretefuente.update_attributes(params[:contratosretefuente])
    flash[:contratosretefuente] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "contratosretefuentes" }
    end
  end

  def destroy
    contratosretefuente   = Contratosretefuente.find(params[:id])
    @empleado  = contratosretefuente.empleado
    @contratosretefuente  = Contratosretefuente.new
    contratosretefuente.destroy
    respond_to do |format|
      format.js { render :action => "contratosretefuentes" }
    end
  end

end

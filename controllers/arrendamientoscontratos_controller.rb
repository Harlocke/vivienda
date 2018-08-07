class ArrendamientoscontratosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    personasarrendamiento   = Personasarrendamiento.find(params[:personasarrendamiento_id])
    @arrendamientoscontratos = personasarrendamiento.arrendamientoscontratos.all
  end

  def edit
    @arrendamientoscontrato  = Arrendamientoscontrato.find(params[:id], :include => "personasarrendamiento")
    @personasarrendamiento  = @arrendamientoscontrato.personasarrendamiento
    respond_to do |format|
      format.js { render :action => "edit_arrendamientoscontrato" }
    end
  end

  def buscar
    respond_to do |format|
      format.html
      format.xls if params[:format] == 'xls'
    end
  end

  def create
    @personasarrendamiento  = Personasarrendamiento.find(params[:personasarrendamiento_id])
    @arrendamientoscontrato = Arrendamientoscontrato.new(params[:arrendamientoscontrato])
    @arrendamientoscontrato.user_id = is_admin
    if @arrendamientoscontrato.valid?
      @personasarrendamiento.arrendamientoscontratos << @arrendamientoscontrato
      @personasarrendamiento.save
      @arrendamientoscontrato = Arrendamientoscontrato.new
      flash[:arrendamientoscontrato] = "Registro almacenado con Exito"
    else
      flash[:arrendamientoscontrato] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "arrendamientoscontratos" }
    end
  end

  def update
    @arrendamientoscontrato        = Arrendamientoscontrato.new
    arrendamientoscontrato         = Arrendamientoscontrato.find(params[:id])
    arrendamientoscontrato.user_actualiza = is_admin
    @personasarrendamiento        = arrendamientoscontrato.personasarrendamiento
    ok = arrendamientoscontrato.update_attributes(params[:arrendamientoscontrato])
    flash[:arrendamientoscontrato] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "arrendamientoscontratos" }
    end
  end

  def destroy
    arrendamientoscontrato   = Arrendamientoscontrato.find(params[:id])
    @personasarrendamiento  = arrendamientoscontrato.personasarrendamiento
    @arrendamientoscontrato  = Arrendamientoscontrato.new
    arrendamientoscontrato.destroy
    respond_to do |format|
      format.js { render :action => "arrendamientoscontratos" }
    end
  end

  private
  def determine_layout
    if ['actaaprobacionobra'].include?(action_name)
      "atencion"
    elsif['informeoperador','informefinanciero','informeactualizacion','informepersonasarrendamientol','informecomuna','informeconcepto','informeseguimiento'].include?(action_name)
      "excel"
    else
      "application"
    end
  end

end
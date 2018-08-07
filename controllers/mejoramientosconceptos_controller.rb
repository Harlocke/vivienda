class MejoramientosconceptosController < ApplicationController
  before_filter :require_user

  def index
    mejoramiento   = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientosconceptos = mejoramiento.mejoramientosconceptos.all
  end

  def edit
    @mejoramientosconcepto  = Mejoramientosconcepto.find(params[:id], :include => "mejoramiento")
    @mejoramiento  = @mejoramientosconcepto.mejoramiento
    respond_to do |format|
      format.js { render :action => "edit_mejoramientosconcepto" }
    end
  end

  def create
    @mejoramiento  = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientosconcepto = Mejoramientosconcepto.new(params[:mejoramientosconcepto])
    @mejoramientosconcepto.user_id = is_admin
    if @mejoramientosconcepto.valid?
      @mejoramiento.mejoramientosconceptos << @mejoramientosconcepto
      @mejoramiento.save
      is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientosconceptos','I')
      @mejoramientosconcepto = Mejoramientosconcepto.new
      flash[:mejoramientosconcepto] = "Registro almacenado con Exito"
    else
      flash[:mejoramientosconcepto] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "mejoramientosconceptos" }
    end
  end

  def update
    @mejoramientosconcepto        = Mejoramientosconcepto.new
    mejoramientosconcepto         = Mejoramientosconcepto.find(params[:id])
    params[:mejoramientosconcepto][:user_actualiza] = is_admin
    @mejoramiento        = mejoramientosconcepto.mejoramiento
    is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientosconceptos','A')
    ok = mejoramientosconcepto.update_attributes(params[:mejoramientosconcepto])
    flash[:mejoramientosconcepto] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "mejoramientosconceptos" }
    end
  end

  def destroy
    mejoramientosconcepto   = Mejoramientosconcepto.find(params[:id])
    @mejoramiento  = mejoramientosconcepto.mejoramiento
    @mejoramientosconcepto  = Mejoramientosconcepto.new
    mejoramientosconcepto.destroy
    respond_to do |format|
      format.js { render :action => "mejoramientosconceptos" }
    end
  end
end

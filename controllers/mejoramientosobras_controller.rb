class MejoramientosobrasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    mejoramiento   = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientosobras = mejoramiento.mejoramientosobras.all
  end

 def edit
    @mejoramientosobra  = Mejoramientosobra.find(params[:id], :include => "mejoramiento")
    @mejoramiento  = @mejoramientosobra.mejoramiento
    respond_to do |format|
      format.js { render :action => "edit_mejoramientosobra" }
    end
  end

  def create
    @mejoramiento  = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientosobra = Mejoramientosobra.new(params[:mejoramientosobra])
    @mejoramientosobra.user_id = is_admin
    if @mejoramientosobra.valid?
      @mejoramiento.mejoramientosobras << @mejoramientosobra
      @mejoramiento.save
      is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientosobras','I')
      @mejoramientosobra = Mejoramientosobra.new
      flash[:mejoramientosobra] = "Creado con exito"
    else
      flash[:mejoramientosobra] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "mejoramientosobras" }
    end
  end

  def update
    @mejoramientosobra        = Mejoramientosobra.new
    mejoramientosobra         = Mejoramientosobra.find(params[:id])
    #mejoramientosobra.user_id = is_admin
    params[:mejoramientosobra][:user_actualiza] = is_admin
    @mejoramiento        = mejoramientosobra.mejoramiento
    ok = mejoramientosobra.update_attributes(params[:mejoramientosobra])
    is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientosobras','A')
    flash[:mejoramientosobra] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "mejoramientosobras" }
    end
  end

  def destroy
    mejoramientosobra   = Mejoramientosobra.find(params[:id])
    @mejoramiento  = mejoramientosobra.mejoramiento
    @mejoramientosobra  = Mejoramientosobra.new
    mejoramientosobra.destroy
    flash[:mejoramientosobra] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "mejoramientosobras" }
    end
  end

  def atencion
    @mejoramientosobras = Mejoramientosobra.find(params[:id])
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

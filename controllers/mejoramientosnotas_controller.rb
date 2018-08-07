class MejoramientosnotasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    mejoramiento   = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientosnotas = mejoramiento.mejoramientosnotas.all
  end

 def edit
    @mejoramientosnota  = Mejoramientosnota.find(params[:id], :include => "mejoramiento")
    @mejoramiento  = @mejoramientosnota.mejoramiento
    respond_to do |format|
      format.js { render :action => "edit_mejoramientosnota" }
    end
  end

  def create
    @mejoramiento  = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientosnota = Mejoramientosnota.new(params[:mejoramientosnota])
    @mejoramientosnota.user_id = is_admin
    if @mejoramientosnota.valid?
      @mejoramiento.mejoramientosnotas << @mejoramientosnota
      @mejoramiento.save
      is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientosnotas','I')
      @mejoramientosnota = Mejoramientosnota.new
      flash[:mejoramientosnota] = "Creado con exito"
    else
      flash[:mejoramientosnota] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "mejoramientosnotas" }
    end
  end

  def update
    @mejoramientosnota        = Mejoramientosnota.new
    mejoramientosnota         = Mejoramientosnota.find(params[:id])
    #mejoramientosnota.user_id = is_admin
    @mejoramiento        = mejoramientosnota.mejoramiento
    ok = mejoramientosnota.update_attributes(params[:mejoramientosnota])
    flash[:mejoramientosnota] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "mejoramientosnotas" }
    end
  end

  def destroy
    mejoramientosnota   = Mejoramientosnota.find(params[:id])
    @mejoramiento  = mejoramientosnota.mejoramiento
    @mejoramientosnota  = Mejoramientosnota.new
    mejoramientosnota.destroy
    flash[:mejoramientosnota] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "mejoramientosnotas" }
    end
  end

  def atencion
    @mejoramientosnotas = Mejoramientosnota.find(params[:id])
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

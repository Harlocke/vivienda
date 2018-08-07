class SaneamientosnotasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    saneamiento   = Saneamiento.find(params[:saneamiento_id])
    @saneamientosnotas = saneamiento.saneamientosnotas.all
  end

  def edit
    @saneamientosnota  = Saneamientosnota.find(params[:id], :include => "saneamiento")
    @saneamiento  = @saneamientosnota.saneamiento
    respond_to do |format|
      format.js { render :action => "edit_saneamientosnota" }
    end
  end

  def create
    @saneamiento  = Saneamiento.find(params[:saneamiento_id])
    @saneamientosnota = Saneamientosnota.new(params[:saneamientosnota])
    @saneamientosnota.user_id = is_admin
    if @saneamientosnota.valid?
      @saneamiento.saneamientosnotas << @saneamientosnota
      @saneamiento.save
      is_trigger_tit(@saneamiento.id,is_admin,'saneamientosnota','I')
      @saneamientosnota = Saneamientosnota.new
      flash[:saneamientosnota] = "Se guardo el registro con exito"
    else
      flash[:saneamientosnota] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "saneamientosnotas" }
    end
  end

  def update
    @saneamientosnota        = Saneamientosnota.new
    saneamientosnota         = Saneamientosnota.find(params[:id])
    @saneamiento        = saneamientosnota.saneamiento
    ok = saneamientosnota.update_attributes(params[:saneamientosnota])
    flash[:saneamientosnota] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "saneamientosnotas" }
    end
  end

  def destroy
    saneamientosnota   = Saneamientosnota.find(params[:id])
    @saneamiento  = saneamientosnota.saneamiento
    @saneamientosnota  = Saneamientosnota.new
    saneamientosnota.destroy
    respond_to do |format|
      format.js { render :action => "saneamientosnotas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @saneamientosnotas = persona.saneamientosnotas.all
  end

  def atencion
    @saneamientosnotas = Saneamientosnota.find(params[:id])
  end

  private
  def determine_layout
    if ['atencion','prepara','envia','enviado'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

class ValorizacionesnotasController < ApplicationController
before_filter :require_user
  layout :determine_layout
  
  def index
    valorizacion   = Valorizacion.find(params[:valorizacion_id])
    @valorizacionesnotas = valorizacion.valorizacionesnotas.all
  end

  def edit
    @valorizacionesnota  = Valorizacionesnota.find(params[:id], :include => "valorizacion")
    @valorizacion  = @valorizacionesnota.valorizacion
    respond_to do |format|
      format.js { render :action => "edit_valorizacionesnota" }
    end
  end

  def create
    @valorizacion  = Valorizacion.find(params[:valorizacion_id])
    @valorizacionesnota = Valorizacionesnota.new(params[:valorizacionesnota])
    @valorizacionesnota.user_id = is_admin
    if @valorizacionesnota.valid?
      @valorizacion.valorizacionesnotas << @valorizacionesnota
      @valorizacion.save
      @valorizacionesnota = Valorizacionesnota.new
      flash[:valorizacionesnota] = "Se guardo el registro con exito"
    else
      flash[:valorizacionesnota] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "valorizacionesnotas" }
    end
  end

  def update
    @valorizacionesnota        = Valorizacionesnota.new
    valorizacionesnota         = Valorizacionesnota.find(params[:id])
    @valorizacion        = valorizacionesnota.valorizacion
    ok = valorizacionesnota.update_attributes(params[:valorizacionesnota])
    flash[:valorizacionesnota] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "valorizacionesnotas" }
    end
  end

  def destroy
    valorizacionesnota   = Valorizacionesnota.find(params[:id])
    @valorizacion  = valorizacionesnota.valorizacion
    @valorizacionesnota  = Valorizacionesnota.new
    valorizacionesnota.destroy
    respond_to do |format|
      format.js { render :action => "valorizacionesnotas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @valorizacionesnotas = persona.valorizacionesnotas.all
  end

  def atencion
    @valorizacionesnotas = Valorizacionesnota.find(params[:id])
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

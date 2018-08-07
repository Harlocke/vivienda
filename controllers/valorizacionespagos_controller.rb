class ValorizacionespagosController < ApplicationController

  before_filter :require_user
  layout :determine_layout
  
  def index
    valorizacion   = Valorizacion.find(params[:valorizacion_id])
    @valorizacionespagos = valorizacion.valorizacionespagos.all
  end

  def edit
    @valorizacionespago  = Valorizacionespago.find(params[:id], :include => "valorizacion")
    @valorizacion  = @valorizacionespago.valorizacion
    respond_to do |format|
      format.js { render :action => "edit_valorizacionespago" }
    end
  end

  def create
    @valorizacion  = Valorizacion.find(params[:valorizacion_id])
    @valorizacionespago = Valorizacionespago.new(params[:valorizacionespago])
    if @valorizacionespago.valid?
      @valorizacion.valorizacionespagos << @valorizacionespago
      @valorizacion.save
      @valorizacionespago = Valorizacionespago.new
      flash[:valorizacionespago] = "Registro almacenado con exito"
    else
      flash[:valorizacionespago] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "valorizacionespagos" }
    end
  end

  def update
    @valorizacionespago        = Valorizacionespago.new
    valorizacionespago         = Valorizacionespago.find(params[:id])
    @valorizacion        = valorizacionespago.valorizacion
    ok = valorizacionespago.update_attributes(params[:valorizacionespago])
    flash[:valorizacionespago] = ok ? "Pago Actualizado con Exito." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "valorizacionespagos" }
    end
  end

  def destroy
    valorizacionespago   = Valorizacionespago.find(params[:id])
    @valorizacion  = valorizacionespago.valorizacion
    @valorizacionespago  = Valorizacionespago.new
    valorizacionespago.destroy
    respond_to do |format|
      format.js { render :action => "valorizacionespagos" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @valorizacionespagos = persona.valorizacionespagos.all
  end

  def idea
    @valorizacionespago   = Valorizacionespago.find(params[:id])
    @descmes  = descmes(@valorizacionespago.fecha_solicitud.strftime("%m").to_i)
  end

  def isvimed
    @valorizacionespago   = Valorizacionespago.find(params[:id])
    @descmes  = descmes(@valorizacionespago.fecha_solicitud.strftime("%m").to_i)
  end

  private
  def determine_layout
    if ['idea','isvimed'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

class IguanaspagosController < ApplicationController

  before_filter :require_user
  layout :determine_layout
  
  def index
    iguana   = Iguana.find(params[:iguana_id])
    @iguanaspagos = iguana.iguanaspagos.all
  end

  def edit
    @iguanaspago  = Iguanaspago.find(params[:id], :include => "iguana")
    @iguana  = @iguanaspago.iguana
    respond_to do |format|
      format.js { render :action => "edit_iguanaspago" }
    end
  end

  def create
    @iguana  = Iguana.find(params[:iguana_id])
    @iguanaspago = Iguanaspago.new(params[:iguanaspago])
    if @iguanaspago.valid?
      @iguana.iguanaspagos << @iguanaspago
      @iguana.save
      is_trigger_iguana(@iguana.id,is_admin,'iguanaspago','I',@iguanaspago.id)
      @iguanaspago = Iguanaspago.new
      flash[:iguanaspago] = "Registro almacenado con exito"
    else
      flash[:iguanaspago] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "iguanaspagos" }
    end
  end

  def update
    @iguanaspago        = Iguanaspago.new
    iguanaspago         = Iguanaspago.find(params[:id])
    @iguana        = iguanaspago.iguana
    ok = iguanaspago.update_attributes(params[:iguanaspago])
    flash[:iguanaspago] = ok ? "Pago Actualizado con Exito." : "Se produjo un error al Asociar"
    if ok == true
      is_trigger_iguana(@iguana.id,is_admin,'iguanaspago','A',@iguanaspago.id)
    end            
    respond_to do |format|
      format.js { render :action => "iguanaspagos" }
    end
  end

  def destroy
    iguanaspago   = Iguanaspago.find(params[:id])
    @iguana  = iguanaspago.iguana
    @iguanaspago  = Iguanaspago.new
    iguanaspago.destroy
    respond_to do |format|
      format.js { render :action => "iguanaspagos" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @iguanaspagos = persona.iguanaspagos.all
  end

  def idea
    @iguanaspago   = Iguanaspago.find(params[:id])
    @descmes  = descmes(@iguanaspago.fecha_solicitud.strftime("%m").to_i)
  end

  def isvimed
    @iguanaspago   = Iguanaspago.find(params[:id])
    @descmes  = descmes(@iguanaspago.fecha_solicitud.strftime("%m").to_i)
  end

  def ver
    @iguanaspago = Iguanaspago.find(params[:id])
  end

   def isvimed2
    @iguanaspago   = Iguanaspago.find(params[:id])
    @descmes  = descmes(@iguanaspago.fecha_solicitud.strftime("%m").to_i)
  end

  private
  def determine_layout
    if ['idea','isvimed','isvimed2'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

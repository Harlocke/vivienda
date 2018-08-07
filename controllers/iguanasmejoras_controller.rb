class IguanasmejorasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    iguana   = Iguana.find(params[:iguana_id])
    @iguanasmejoras = iguana.iguanasmejoras.all
  end

  def edit
    @iguanasmejora  = Iguanasmejora.find(params[:id], :include => "iguana")
    @iguana  = @iguanasmejora.iguana
    respond_to do |format|
      format.js { render :action => "edit_iguanasmejora" }
    end
  end

  def create
    @iguana  = Iguana.find(params[:iguana_id])
    @iguanasmejora = Iguanasmejora.new(params[:iguanasmejora])
    @iguanasmejora.user_id = is_admin
    if @iguanasmejora.valid?
      @iguana.iguanasmejoras << @iguanasmejora
      @iguana.save
      is_trigger_iguana(@iguana.id,is_admin,'iguanasmejora','I',@iguanasmejora.id)
      @iguanasmejora = Iguanasmejora.new
      flash[:iguanasmejora] = "Registro almacenado con exito"
    else
      flash[:iguanasmejora] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "iguanasmejoras" }
    end
  end

  def update
    @iguanasmejora        = Iguanasmejora.new
    iguanasmejora         = Iguanasmejora.find(params[:id])
    @iguana        = iguanasmejora.iguana
    ok = iguanasmejora.update_attributes(params[:iguanasmejora])
    flash[:iguanasmejora] = ok ? "Pago Actualizado con Exito." : "Se produjo un error al Asociar"
    if ok == true
      is_trigger_iguana(@iguana.id,is_admin,'iguanasmejora','A',@iguanasmejora.id)
    end                
    respond_to do |format|
      format.js { render :action => "iguanasmejoras" }
    end
  end

  def destroy
    iguanasmejora   = Iguanasmejora.find(params[:id])
    @iguana  = iguanasmejora.iguana
    @iguanasmejora  = Iguanasmejora.new
    iguanasmejora.destroy
    respond_to do |format|
      format.js { render :action => "iguanasmejoras" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @iguanasmejoras = persona.iguanasmejoras.all
  end

  def idea
    @iguanasmejora   = Iguanasmejora.find(params[:id])
    @descmes  = descmes(@iguanasmejora.fecha_solicitud.strftime("%m").to_i)
  end

  def isvimed
    @iguanasmejora   = Iguanasmejora.find(params[:id])
    @descmes  = descmes(@iguanasmejora.fecha_solicitud.strftime("%m").to_i)
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

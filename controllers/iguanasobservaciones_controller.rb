class IguanasobservacionesController < ApplicationController
before_filter :require_user
  layout :determine_layout
  
  def index
    iguana   = Iguana.find(params[:iguana_id])
    @iguanasobservaciones = iguana.iguanasobservaciones.all
  end

  def edit
    @iguanasobservacion  = Iguanasobservacion.find(params[:id], :include => "iguana")
    @iguana  = @iguanasobservacion.iguana
    respond_to do |format|
      format.js { render :action => "edit_iguanasobservacion" }
    end
  end

  def create
    @iguana  = Iguana.find(params[:iguana_id])
    @iguanasobservacion = Iguanasobservacion.new(params[:iguanasobservacion])
    @iguanasobservacion.user_id = is_admin
    if @iguanasobservacion.valid?
      @iguana.iguanasobservaciones << @iguanasobservacion
      @iguana.save
      is_trigger_iguana(@iguana.id,is_admin,'iguanasobservacion','I',@iguanasobservacion.id)
      @iguanasobservacion = Iguanasobservacion.new
      flash[:iguanasobservacion] = "Se guardo el registro con exito"
    else
      flash[:iguanasobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "iguanasobservaciones" }
    end
  end

  def update
    @iguanasobservacion        = Iguanasobservacion.new
    iguanasobservacion         = Iguanasobservacion.find(params[:id])
    @iguana        = iguanasobservacion.iguana
    ok = iguanasobservacion.update_attributes(params[:iguanasobservacion])
    flash[:iguanasobservacion] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    if ok == true
      is_trigger_iguana(@iguana.id,is_admin,'iguanasobservacion','A',@iguanasobservacion.id)
    end     
    respond_to do |format|
      format.js { render :action => "iguanasobservaciones" }
    end
  end

  def destroy
    iguanasobservacion   = Iguanasobservacion.find(params[:id])
    @iguana  = iguanasobservacion.iguana
    @iguanasobservacion  = Iguanasobservacion.new
    iguanasobservacion.destroy
    respond_to do |format|
      format.js { render :action => "iguanasobservaciones" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @iguanasobservaciones = persona.iguanasobservaciones.all
  end

  def atencion
    @iguanasobservaciones = Iguanasobservacion.find(params[:id])
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

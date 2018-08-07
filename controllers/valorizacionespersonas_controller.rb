class ValorizacionespersonasController < ApplicationController

  before_filter :require_user
  def index
    valorizacion   = Valorizacion.find(params[:valorizacion_id])
    @valorizacionespersonas = valorizacion.valorizacionespersonas.all
  end

  def edit
    @valorizacionespersona  = Valorizacionespersona.find(params[:id], :include => "valorizacion")
    @valorizacion  = @valorizacionespersona.valorizacion
    respond_to do |format|
      format.js { render :action => "edit_valorizacionespersona" }
    end
  end

  def create
    @valorizacion  = Valorizacion.find(params[:valorizacion_id])
    @valorizacionespersona = Valorizacionespersona.new(params[:valorizacionespersona])
    #@valorizacionespersona.user_id = is_admin
    if Persona.exists?(["id = ?", @valorizacionespersona.persona_id]) == true
      if @valorizacionespersona.valid?
        @valorizacion.valorizacionespersonas << @valorizacionespersona
        @valorizacion.save
        @valorizacionespersona = Valorizacionespersona.new
      else
        flash[:valorizacionespersona] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "valorizacionespersonas" }
      end
    else
      flash[:valorizacionespersona] = "Debe seleccionar el usuario para Asociar"
      respond_to do |format|
        format.js { render :action => "valorizacionespersonas" }
      end
    end
  end

  def update
    @valorizacionespersona        = Valorizacionespersona.new
    valorizacionespersona         = Valorizacionespersona.find(params[:id])
    @valorizacion        = valorizacionespersona.valorizacion
    #params[:valorizacionespersona][:useract_id] = is_admin
    ok = valorizacionespersona.update_attributes(params[:valorizacionespersona])
    flash[:valorizacionespersona] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "valorizacionespersonas" }
    end
  end

  def destroy
    valorizacionespersona   = Valorizacionespersona.find(params[:id])
    @valorizacion  = valorizacionespersona.valorizacion
    @valorizacionespersona  = Valorizacionespersona.new
    valorizacionespersona.destroy
    respond_to do |format|
      format.js { render :action => "valorizacionespersonas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @valorizacionespersonas = persona.valorizacionespersonas.all
  end
end

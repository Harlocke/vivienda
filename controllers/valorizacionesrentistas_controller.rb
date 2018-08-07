class ValorizacionesrentistasController < ApplicationController

  before_filter :require_user
  def index
    valorizacion   = Valorizacion.find(params[:valorizacion_id])
    @valorizacionesrentistas = valorizacion.valorizacionesrentistas.all
  end

  def edit
    @valorizacionesrentista  = Valorizacionesrentista.find(params[:id], :include => "valorizacion")
    @valorizacion  = @valorizacionesrentista.valorizacion
    respond_to do |format|
      format.js { render :action => "edit_valorizacionesrentista" }
    end
  end

  def create
    @valorizacion  = Valorizacion.find(params[:valorizacion_id])
    @valorizacionesrentista = Valorizacionesrentista.new(params[:valorizacionesrentista])
    if Persona.exists?(["id = ?", @valorizacionesrentista.persona_id]) == true
      if @valorizacionesrentista.valid?
        @valorizacion.valorizacionesrentistas << @valorizacionesrentista
        @valorizacion.save
        @valorizacionesrentista = Valorizacionesrentista.new
      else
        flash[:valorizacionesrentista] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "valorizacionesrentistas" }
      end
    else
      flash[:valorizacionesrentista] = "Debe seleccionar el usuario para Asociar"
      respond_to do |format|
        format.js { render :action => "valorizacionesrentistas" }
      end
    end
  end

  def update
    @valorizacionesrentista        = Valorizacionesrentista.new
    valorizacionesrentista         = Valorizacionesrentista.find(params[:id])
    @valorizacion        = valorizacionesrentista.valorizacion
    ok = valorizacionesrentista.update_attributes(params[:valorizacionesrentista])
    flash[:valorizacionesrentista] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "valorizacionesrentistas" }
    end
  end

  def destroy
    valorizacionesrentista   = Valorizacionesrentista.find(params[:id])
    @valorizacion  = valorizacionesrentista.valorizacion
    @valorizacionesrentista  = Valorizacionesrentista.new
    valorizacionesrentista.destroy
    respond_to do |format|
      format.js { render :action => "valorizacionesrentistas" }
    end
  end

  def show
    persona   = Persona.find(params[:rentista_id])
    @valorizacionesrentistas = persona.valorizacionesrentistas.all
  end
end

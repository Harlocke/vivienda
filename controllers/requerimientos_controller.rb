class RequerimientosController < ApplicationController

  before_filter :require_user

  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @requerimientos = persona.requerimientos.all
  end

  def edit
    @requerimiento  = Requerimiento.find(params[:id], :include => "persona")
    @persona        = @requerimiento.persona
    #@dependencias    = Dependencia.all
    respond_to do |format|
      format.js { render :action => "edit_requerimiento" }
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @requerimiento  = Requerimiento.new(params[:requerimiento])
    if @requerimiento.valid?
      @persona.requerimientos << @requerimiento
      @persona.save
      @requerimiento = Requerimiento.new
    else
      flash[:requerimiento] = "Se produjo un error al guardar el requerimiento"
    end
    respond_to do |format|
      format.js { render :action => "requerimientos" }
    end
  end

  def update
    @requerimiento  = Requerimiento.new
    requerimiento   = Requerimiento.find(params[:id])
    @persona        = requerimiento.persona
    ok = requerimiento.update_attributes(params[:requerimiento])
    flash[:requerimiento] = ok ? "Requerimiento modificada correctamente" : "Se produjo un error al guardar el requerimiento"
    respond_to do |format|
      format.js { render :action => "requerimientos" }
    end
  end

  def destroy
    requerimiento   = Requerimiento.find(params[:id])
    @persona  = requerimiento.persona
    @requerimiento  = Requerimiento.new
    @dependencia    = Dependencia.new
    requerimiento.destroy
    respond_to do |format|
      format.js { render :action => "requerimientos" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
    else
      "basico"
    end
  end
end
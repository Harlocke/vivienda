class AntcreditosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @antcreditos = persona.antcreditos.all
  end

  def edit
    @antcredito  = Antcredito.find(params[:id], :include => "persona")
    @persona  = @antcredito.persona
    respond_to do |format|
      format.js { render :action => "edit_antcredito" }
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @antcredito = Antcredito.new(params[:antcredito])
    if @antcredito.valid?
      @persona.antcreditos << @antcredito
      @persona.save
      @antcredito = Antcredito.new
      flash[:antcredito] = "Creado con exito"
    else
      flash[:antcredito] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "antcreditos" }
    end
  end

  def update
    @antcredito        = Antcredito.new
    antcredito         = Antcredito.find(params[:id])
    @persona        = antcredito.persona
    ok = antcredito.update_attributes(params[:antcredito])
    flash[:antcredito] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "antcreditos" }
    end
  end

  def destroy
    antcredito   = Antcredito.find(params[:id])
    @persona  = antcredito.persona
    @antcredito  = Antcredito.new
    antcredito.respaldo
    antcredito.destroy
    flash[:antcredito] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "antcreditos" }
    end
  end
end

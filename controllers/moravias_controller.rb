class MoraviasController < ApplicationController
  
  before_filter :require_user

  layout :determine_layout

 # before_filter :find_persona_moravia

  def index
    persona   = Persona.find(params[:persona_id])
    @moravias = persona.moravias.all
  end

  def edit
    @moravia  = Moravia.find(params[:id], :include => "persona")
    @persona  = @moravia.persona
    respond_to do |format|
      format.js { render :action => "edit_moravia" }
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @moravia  = Moravia.new(params[:moravia])
    if @moravia.valid?
      @persona.moravias << @moravia
      @persona.save
      @moravia = Moravia.new
    else
      flash[:moravia] = "Se produjo un error al guardar la línea de factura."
    end
    respond_to do |format|
      format.js { render :action => "moravias" }
    end
  end

  def update
    @moravia        = Moravia.new
    moravia         = Moravia.find(params[:id])
    @persona        = moravia.persona
    ok = moravia.update_attributes(params[:moravia])
    flash[:moravia] = ok ? "Línea de factura modificada correctamente" : "Se produjo un error al guardar la línea de factura"
    respond_to do |format|
      format.js { render :action => "moravias" }
    end
  end

  def destroy
    moravia   = Moravia.find(params[:id])
    @persona  = moravia.persona
    @moravia  = Moravia.new
    moravia.destroy
    respond_to do |format|
      format.js { render :action => "moravias" }
    end
  end

 
end

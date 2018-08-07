class CorresinternasobservacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    correspondenciasinterna   = Correspondenciasinterna.find(params[:correspondenciasinterna_id])
    @corresinternasobservaciones = correspondenciasinterna.corresinternasobservaciones.all
  end

 def edit
    @corresinternasobservacion  = Corresinternasobservacion.find(params[:id], :include => "correspondenciasinterna")
    @correspondenciasinterna  = @corresinternasobservacion.correspondenciasinterna
    respond_to do |format|
      format.js { render :action => "edit_corresinternasobservacion" }
    end
  end

 def visualizar
    @corresinternasobservacion  = Corresinternasobservacion.find(params[:id])
  end

  def create
    @correspondenciasinterna  = Correspondenciasinterna.find(params[:correspondenciasinterna_id])
    @corresinternasobservacion = Corresinternasobservacion.new(params[:corresinternasobservacion])
    if @corresinternasobservacion.valid?
      @correspondenciasinterna.corresinternasobservaciones << @corresinternasobservacion
      @correspondenciasinterna.save
      @corresinternasobservacion = Corresinternasobservacion.new
      flash[:corresinternasobservacion] = "Creado con exito"
    else
      flash[:corresinternasobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "corresinternasobservaciones" }
    end
  end

  def update
    @corresinternasobservacion   = Corresinternasobservacion.new
    corresinternasobservacion    = Corresinternasobservacion.find(params[:id])
    @correspondenciasinterna        = corresinternasobservacion.correspondenciasinterna
    ok = corresinternasobservacion.update_attributes(params[:corresinternasobservacion])
    flash[:corresinternasobservacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "corresinternasobservaciones" }
    end
  end

  def destroy
    corresinternasobservacion   = Corresinternasobservacion.find(params[:id])
    @correspondenciasinterna  = corresinternasobservacion.correspondenciasinterna
    @corresinternasobservacion  = Corresinternasobservacion.new
    corresinternasobservacion.destroy
    flash[:corresinternasobservacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "corresinternasobservaciones" }
    end
  end

  private
  def determine_layout
    if ['create'].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end
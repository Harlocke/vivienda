class ObservaviviendasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    vivienda   = Vivienda.find(params[:vivienda_id])
    #@observaviviendas = vivienda.observaviviendas.all
    @observaviviendas = vivienda.observaviviendas.find(:all, :conditions => ['vivienda_id = ?', params[:vivienda_id]], :order => 'created_at')
  end

  def edit
    @observavivienda  = Observavivienda.find(params[:id], :include => "vivienda")
    @vivienda  = @observavivienda.vivienda
    respond_to do |format|
      format.js { render :action => "edit_observavivienda" }
    end
  end

  def create
    @vivienda  = Vivienda.find(params[:vivienda_id])
    @observavivienda = Observavivienda.new(params[:observavivienda])
    @observavivienda.user_id = is_admin
    if @observavivienda.valid?
      @vivienda.observaviviendas << @observavivienda
      @vivienda.save
      @observavivienda = Observavivienda.new
      flash[:observavivienda] = "Creado con exito"
    else
      flash[:observavivienda] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "observaviviendas" }
    end
  end

  def update
    @observavivienda        = Observavivienda.new
    observavivienda         = Observavivienda.find(params[:id])
    @vivienda        = observavivienda.vivienda
    ok = observavivienda.update_attributes(params[:observavivienda])
    flash[:observavivienda] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "observaviviendas" }
    end
  end

  def destroy
    observavivienda   = Observavivienda.find(params[:id])
    @vivienda  = observavivienda.vivienda
    @observavivienda  = Observavivienda.new
    observavivienda.destroy
    flash[:observavivienda] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "observaviviendas" }
    end
  end

  def atencion
    @observaviviendas = Observavivienda.find(params[:id])
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

class CalidadnormogramasprocesosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    calidadnormograma   = Calidadnormograma.find(params[:calidadnormograma_id])
    @calidadnormogramasprocesos = calidadnormograma.calidadnormogramasprocesos.all
  end

  def edit
    @calidadnormogramasproceso  = Calidadnormogramasproceso.find(params[:id], :include => "calidadnormograma")
    @calidadnormograma  = @calidadnormogramasproceso.calidadnormograma
    respond_to do |format|
      format.js { render :action => "edit_calidadnormogramasproceso" }
    end
  end

   def visualizar
     @calidadnormogramasproceso  = Calidadnormogramasproceso.find(params[:id])
   end

  def create
    @calidadnormograma  = Calidadnormograma.find(params[:calidadnormograma_id])
    @calidadnormogramasproceso = Calidadnormogramasproceso.new(params[:calidadnormogramasproceso])
    @calidadnormogramasproceso.user_id = is_admin
    if @calidadnormogramasproceso.valid?
      @calidadnormograma.calidadnormogramasprocesos << @calidadnormogramasproceso
      @calidadnormograma.save
      @calidadnormogramasproceso = Calidadnormogramasproceso.new
      flash[:calidadnormogramasproceso] = "Creado con exito"
    else
      flash[:calidadnormogramasproceso] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "calidadnormogramasprocesos" }
    end
  end

  def update
    @calidadnormogramasproceso        = Calidadnormogramasproceso.new
    calidadnormogramasproceso         = Calidadnormogramasproceso.find(params[:id])
    calidadnormogramasproceso.user_actualiza = is_admin
    @calidadnormograma        = calidadnormogramasproceso.calidadnormograma
    ok = calidadnormogramasproceso.update_attributes(params[:calidadnormogramasproceso])
    flash[:calidadnormogramasproceso] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "calidadnormogramasprocesos" }
    end
  end

  def destroy
    calidadnormogramasproceso   = Calidadnormogramasproceso.find(params[:id])
    @calidadnormograma  = calidadnormogramasproceso.calidadnormograma
    @calidadnormogramasproceso  = Calidadnormogramasproceso.new
    calidadnormogramasproceso.destroy
    flash[:calidadnormogramasproceso] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "calidadnormogramasprocesos" }
    end
  end

  private
  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end


class CalidaddocumentosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    calidadproceso   = Calidadproceso.find(params[:calidadproceso_id])
    @calidaddocumentos = calidadproceso.calidaddocumentos.all
  end

  def edit
    @calidaddocumento  = Calidaddocumento.find(params[:id], :include => "calidadproceso")
    @calidadproceso  = @calidaddocumento.calidadproceso
    respond_to do |format|
      format.js { render :action => "edit_calidaddocumento" }
    end
  end

   def visualizar
     @calidaddocumento  = Calidaddocumento.find(params[:id])
   end

  def create
    @calidadproceso  = Calidadproceso.find(params[:calidadproceso_id])
    @calidaddocumento = Calidaddocumento.new(params[:calidaddocumento])
    @calidaddocumento.user_id = is_admin
    if @calidaddocumento.valid?
      @calidadproceso.calidaddocumentos << @calidaddocumento
      @calidadproceso.save
      @calidaddocumento = Calidaddocumento.new
      flash[:calidaddocumento] = "Creado con exito"
    else
      flash[:calidaddocumento] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "calidaddocumentos" }
    end
  end

  def update
    @calidaddocumento        = Calidaddocumento.new
    calidaddocumento         = Calidaddocumento.find(params[:id])
    params[:calidaddocumento][:user_actualiza] = is_admin
    @calidadproceso        = calidaddocumento.calidadproceso
    ok = calidaddocumento.update_attributes(params[:calidaddocumento])
    flash[:calidaddocumento] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "calidaddocumentos" }
    end
  end

  def destroy
    calidaddocumento   = Calidaddocumento.find(params[:id])
    @calidadproceso  = calidaddocumento.calidadproceso
    @calidaddocumento  = Calidaddocumento.new
    calidaddocumento.destroy
    flash[:calidaddocumento] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "calidaddocumentos" }
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


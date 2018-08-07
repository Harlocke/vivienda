class ImpresorasreportesController < ApplicationController
before_filter :require_user

layout :determine_layout

  def index
    impresora   = Impresora.find(params[:impresora_id])
    @impresorasreportes = impresora.impresorasreportes.all
  end

  def edit
    @impresorasreporte  = Impresorasreporte.find(params[:id], :include => "impresora")
    @impresora  = @impresorasreporte.impresora
    respond_to do |format|
      format.js { render :action => "edit_impresorasreporte" }
    end
  end

  def acta
    @impresorasreporte = Impresorasreporte.find(params[:id])
    respond_to do |format|
      format.pdf {render :layout => false }
    end
  end

  def create
    @impresora  = Impresora.find(params[:impresora_id])
    @impresorasreporte = Impresorasreporte.new(params[:impresorasreporte])
    @impresorasreporte.user_id = is_admin
       if @impresorasreporte.valid?
          @impresora.impresorasreportes << @impresorasreporte
          @impresora.save
          @impresorasreporte = Impresorasreporte.new
          flash[:impresorasreporte] = "Creado con exito"
        else
          flash[:impresorasreporte] = "Se produjo un error al guardar el registro"
        end
    respond_to do |format|
       format.js { render :action => "impresorasreportes" }
    end
  end

  def update
    @impresorasreporte        = Impresorasreporte.new
    impresorasreporte         = Impresorasreporte.find(params[:id])
    @impresora        = impresorasreporte.impresora
    ok = impresorasreporte.update_attributes(params[:impresorasreporte])
    flash[:impresorasreporte] = ok ? "Actualizado con Exito " : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "impresorasreportes" }
    end
  end

  def destroy
    impresorasreporte   = Impresorasreporte.find(params[:id])
    @impresora  = impresorasreporte.impresora
    @impresorasreporte  = Impresorasreporte.new
    impresorasreporte.destroy
    flash[:impresorasreporte] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "impresorasreportes" }
    end
  end

  private
   def determine_layout
    if ['acta'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

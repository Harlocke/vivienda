class ViviendasusadaspagosController < ApplicationController

  before_filter :require_user

  def index
    viviendasusada   = Viviendasusada.find(params[:viviendasusada_id])
    @viviendasusadaspagos = viviendasusada.viviendasusadaspagos.all
  end

  def edit
    @viviendasusadaspago  = Viviendasusadaspago.find(params[:id], :include => "viviendasusada")
    @viviendasusada  = @viviendasusadaspago.viviendasusada
    respond_to do |format|
      format.js { render :action => "edit_viviendasusadaspago" }
    end
  end

  def create
    @viviendasusada  = Viviendasusada.find(params[:viviendasusada_id])
    @viviendasusadaspago = Viviendasusadaspago.new(params[:viviendasusadaspago])
    if @viviendasusadaspago.valid?
      @viviendasusada.viviendasusadaspagos << @viviendasusadaspago
      @viviendasusada.save
      @viviendasusadaspago = Viviendasusadaspago.new
      flash[:viviendasusadaspago] = "Creado con exito"
    else
      flash[:viviendasusadaspago] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "viviendasusadaspagos" }
    end
  end

  def update
    @viviendasusadaspago        = Viviendasusadaspago.new
    viviendasusadaspago         = Viviendasusadaspago.find(params[:id])
    @viviendasusada        = viviendasusadaspago.viviendasusada
    ok = viviendasusadaspago.update_attributes(params[:viviendasusadaspago])
    flash[:viviendasusadaspago] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "viviendasusadaspagos" }
    end
  end

  def destroy
    viviendasusadaspago   = Viviendasusadaspago.find(params[:id])
    @viviendasusada  = viviendasusadaspago.viviendasusada
    @viviendasusadaspago  = Viviendasusadaspago.new
    viviendasusadaspago.destroy
    flash[:viviendasusadaspago] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "viviendasusadaspagos" }
    end
  end

end

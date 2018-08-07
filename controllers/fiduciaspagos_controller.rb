class FiduciaspagosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    fiducia = Fiducia.find(params[:fiducia_id])
    @fiduciaspagos = fiducia.fiduciaspagos.all 
  end

  def edit
    @fiduciaspago  = Fiduciaspago.find(params[:id], :include => "fiducia")
    @fiducia  = @fiduciaspago.fiducia
    respond_to do |format|
      format.js { render :action => "edit_fiduciaspago" }
    end
  end

  def create
    @fiducia  = Fiducia.find(params[:fiducia_id])
    @fiduciaspago = Fiduciaspago.new(params[:fiduciaspago])
    @fiduciaspago.user_id = is_admin
       if @fiduciaspago.valid?
          @fiducia.fiduciaspagos << @fiduciaspago
          @fiducia.save
          @fiduciaspago = Fiduciaspago.new
          flash[:fiduciaspago] = "Creado con exito"
        else
          flash[:fiduciaspago] = "Se produjo un error al guardar el registro"
        end
    respond_to do |format|
       format.js { render :action => "fiduciaspagos" }
    end
  end

  def update
    @fiduciaspago        = Fiduciaspago.new
    fiduciaspago         = Fiduciaspago.find(params[:id])
    @fiducia        = fiduciaspago.fiducia
    ok = fiduciaspago.update_attributes(params[:fiduciaspago])
    flash[:fiduciaspago] = ok ? "Actualizado con Exito " : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "fiduciaspagos" }
    end
  end

  def destroy
    fiduciaspago   = Fiduciaspago.find(params[:id])
    @fiducia  = fiduciaspago.fiducia
    @fiduciaspago  = Fiduciaspago.new
    fiduciaspago.destroy
    flash[:fiduciaspago] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "fiduciaspagos" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end

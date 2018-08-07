class AyudaspagosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudaspagos = ayuda.ayudaspagos.all
  end

 def edit
    @ayudaspago  = Ayudaspago.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudaspago.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudaspago" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudaspago = Ayudaspago.new(params[:ayudaspago])
    @ayudaspago.user_id = is_admin
    if @ayudaspago.valid?
      @ayuda.ayudaspagos << @ayudaspago
      @ayuda.save
      @ayudaspago = Ayudaspago.new
      flash[:ayudaspago] = "Creado con exito"
    else
      flash[:ayudaspago] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudaspagos" }
    end
  end

  def update
    @ayudaspago        = Ayudaspago.new
    ayudaspago         = Ayudaspago.find(params[:id])
    #ayudaspago.user_id = is_admin
    @ayuda        = ayudaspago.ayuda
    ok = ayudaspago.update_attributes(params[:ayudaspago])
    flash[:ayudaspago] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudaspagos" }
    end
  end

  def destroy
    ayudaspago   = Ayudaspago.find(params[:id])
    @ayuda  = ayudaspago.ayuda
    @ayudaspago  = Ayudaspago.new
    ayudaspago.destroy
    flash[:ayudaspago] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudaspagos" }
    end
  end
end

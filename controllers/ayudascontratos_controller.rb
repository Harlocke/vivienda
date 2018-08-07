class AyudascontratosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudascontratos = ayuda.ayudascontratos.all
  end

 def edit
    @ayudascontrato  = Ayudascontrato.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudascontrato.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudascontrato" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudascontrato = Ayudascontrato.new(params[:ayudascontrato])
    @ayudascontrato.user_id = is_admin
    if @ayudascontrato.valid?
      @ayuda.ayudascontratos << @ayudascontrato
      @ayuda.save
      @ayudascontrato = Ayudascontrato.new
      flash[:ayudascontrato] = "Creado con exito"
    else
      flash[:ayudascontrato] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudascontratos" }
    end
  end

  def update
    @ayudascontrato        = Ayudascontrato.new
    ayudascontrato         = Ayudascontrato.find(params[:id])
    ayudascontrato.user_actualiza = is_admin
    @ayuda        = ayudascontrato.ayuda
    ok = ayudascontrato.update_attributes(params[:ayudascontrato])
    flash[:ayudascontrato] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudascontratos" }
    end
  end

  def destroy
    ayudascontrato   = Ayudascontrato.find(params[:id])
    @ayuda  = ayudascontrato.ayuda
    @ayudascontrato  = Ayudascontrato.new
    ayudascontrato.destroy
    flash[:ayudascontrato] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudascontratos" }
    end
  end
end

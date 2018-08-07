class AyudasadicionalesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudasadicionales = ayuda.ayudasadicionales.all
  end

 def edit
    @ayudasadicional  = Ayudasadicional.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudasadicional.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudasadicional" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudasadicional = Ayudasadicional.new(params[:ayudasadicional])
    @ayudasadicional.user_id = is_admin
    if @ayudasadicional.valid?
      @ayuda.ayudasadicionales << @ayudasadicional
      @ayuda.save
      @ayudasadicional = Ayudasadicional.new
      flash[:ayudasadicional] = "Creado con exito"
    else
      flash[:ayudasadicional] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudasadicionales" }
    end
  end

  def update
    @ayudasadicional        = Ayudasadicional.new
    ayudasadicional         = Ayudasadicional.find(params[:id])
    #ayudasadicional.user_id = is_admin
    @ayuda        = ayudasadicional.ayuda
    ok = ayudasadicional.update_attributes(params[:ayudasadicional])
    flash[:ayudasadicional] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudasadicionales" }
    end
  end

  def destroy
    ayudasadicional   = Ayudasadicional.find(params[:id])
    @ayuda  = ayudasadicional.ayuda
    @ayudasadicional  = Ayudasadicional.new
    ayudasadicional.destroy
    flash[:ayudasadicional] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudasadicionales" }
    end
  end
end
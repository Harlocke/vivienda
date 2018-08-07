class AyudasetapasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudasetapas = ayuda.ayudasetapas.all
  end

 def edit
    @ayudasetapa  = Ayudasetapa.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudasetapa.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudasetapa" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudasetapa = Ayudasetapa.new(params[:ayudasetapa])
    @ayudasetapa.user_id = is_admin
    if @ayudasetapa.valid?
      @ayuda.ayudasetapas << @ayudasetapa
      @ayuda.save
      @ayudasetapa = Ayudasetapa.new
      flash[:ayudasetapa] = "Creado con exito"
    else
      flash[:ayudasetapa] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudasetapas" }
    end
  end

  def update
    @ayudasetapa        = Ayudasetapa.new
    ayudasetapa         = Ayudasetapa.find(params[:id])
    #ayudasetapa.user_id = is_admin
    @ayuda        = ayudasetapa.ayuda
    ok = ayudasetapa.update_attributes(params[:ayudasetapa])
    flash[:ayudasetapa] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudasetapas" }
    end
  end

  def cumplimiento
    @ayudasetapa        = Ayudasetapa.new
    ayudasetapa         = Ayudasetapa.find(params[:id])
    ayudasetapa.fecha_cumplimiento = Time.now().strftime("%Y-%m-%d %H:%M:%S")
    @ayuda        = ayudasetapa.ayuda
    ok = ayudasetapa.update_attributes(params[:ayudasetapa])
    flash[:ayudasetapa] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudasetapas" }
    end
  end


  def destroy
    ayudasetapa   = Ayudasetapa.find(params[:id])
    @ayuda  = ayudasetapa.ayuda
    @ayudasetapa  = Ayudasetapa.new
    ayudasetapa.destroy
    flash[:ayudasetapa] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudasetapas" }
    end
  end
end

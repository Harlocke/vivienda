class AyudaseventosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudaseventos = ayuda.ayudaseventos.all
  end

 def edit
    @ayudasevento  = Ayudasevento.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudasevento.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudasevento" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudasevento = Ayudasevento.new(params[:ayudasevento])
    @ayudasevento.user_id = is_admin
    if @ayudasevento.valid?
      @ayuda.ayudaseventos << @ayudasevento
      @ayuda.save
      @ayudasevento = Ayudasevento.new
      flash[:ayudasevento] = "Creado con exito"
    else
      flash[:ayudasevento] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudaseventos" }
    end
  end

  def update
    @ayudasevento        = Ayudasevento.new
    ayudasevento         = Ayudasevento.find(params[:id])
    #ayudasevento.user_id = is_admin
    @ayuda        = ayudasevento.ayuda
    ok = ayudasevento.update_attributes(params[:ayudasevento])
    flash[:ayudasevento] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudaseventos" }
    end
  end

  def destroy
    ayudasevento   = Ayudasevento.find(params[:id])
    @ayuda  = ayudasevento.ayuda
    @ayudasevento  = Ayudasevento.new
    ayudasevento.destroy
    flash[:ayudasevento] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudaseventos" }
    end
  end
end
class AyudasviviendasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudasviviendas = ayuda.ayudasviviendas.all
  end

 def edit
    @ayudasvivienda  = Ayudasvivienda.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudasvivienda.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudasvivienda" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudasvivienda = Ayudasvivienda.new(params[:ayudasvivienda])
    @ayudasvivienda.user_id = is_admin
    if @ayudasvivienda.valid?
      @ayuda.ayudasviviendas << @ayudasvivienda
      @ayuda.save
      @ayudasvivienda = Ayudasvivienda.new
      flash[:ayudasvivienda] = "Creado con exito"
    else
      flash[:ayudasvivienda] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudasviviendas" }
    end
  end

  def update
    @ayudasvivienda        = Ayudasvivienda.new
    ayudasvivienda         = Ayudasvivienda.find(params[:id])
    #ayudasvivienda.user_id = is_admin
    @ayuda        = ayudasvivienda.ayuda
    ok = ayudasvivienda.update_attributes(params[:ayudasvivienda])
    flash[:ayudasvivienda] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudasviviendas" }
    end
  end

  def destroy
    ayudasvivienda   = Ayudasvivienda.find(params[:id])
    @ayuda  = ayudasvivienda.ayuda
    @ayudasvivienda  = Ayudasvivienda.new
    ayudasvivienda.destroy
    flash[:ayudasvivienda] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudasviviendas" }
    end
  end
end

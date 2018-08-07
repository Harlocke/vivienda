class AyudasnovedadesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudasnovedades = ayuda.ayudasnovedades.all
  end

 def edit
    @ayudasnovedad  = Ayudasnovedad.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudasnovedad.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudasnovedad" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudasnovedad = Ayudasnovedad.new(params[:ayudasnovedad])
    @ayudasnovedad.user_id = is_admin
    if @ayudasnovedad.valid?
      @ayuda.ayudasnovedades << @ayudasnovedad
      @ayuda.save
      @ayudasnovedad = Ayudasnovedad.new
      flash[:ayudasnovedad] = "Creado con exito"
    else
      flash[:ayudasnovedad] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudasnovedades" }
    end
  end

  def update
    @ayudasnovedad        = Ayudasnovedad.new
    ayudasnovedad         = Ayudasnovedad.find(params[:id])
    #ayudasnovedad.user_id = is_admin
    @ayuda        = ayudasnovedad.ayuda
    ok = ayudasnovedad.update_attributes(params[:ayudasnovedad])
    flash[:ayudasnovedad] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudasnovedades" }
    end
  end

  def destroy
    ayudasnovedad   = Ayudasnovedad.find(params[:id])
    @ayuda  = ayudasnovedad.ayuda
    @ayudasnovedad  = Ayudasnovedad.new
    ayudasnovedad.destroy
    flash[:ayudasnovedad] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudasnovedades" }
    end
  end
end

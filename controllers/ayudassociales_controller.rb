class AyudassocialesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudassociales = ayuda.ayudassociales.all
  end

 def edit
    @ayudassocial  = Ayudassocial.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudassocial.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudassocial" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudassocial = Ayudassocial.new(params[:ayudassocial])
    @ayudassocial.user_id = is_admin
    if @ayudassocial.valid?
      @ayuda.ayudassociales << @ayudassocial
      @ayuda.save
      @ayudassocial = Ayudassocial.new
      flash[:ayudassocial] = "Creado con exito"
    else
      flash[:ayudassocial] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudassociales" }
    end
  end

  def update
    @ayudassocial        = Ayudassocial.new
    ayudassocial         = Ayudassocial.find(params[:id])
    #ayudassocial.user_id = is_admin
    @ayuda        = ayudassocial.ayuda
    ok = ayudassocial.update_attributes(params[:ayudassocial])
    flash[:ayudassocial] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudassociales" }
    end
  end

  def destroy
    ayudassocial   = Ayudassocial.find(params[:id])
    @ayuda  = ayudassocial.ayuda
    @ayudassocial  = Ayudassocial.new
    ayudassocial.destroy
    flash[:ayudassocial] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudassociales" }
    end
  end
end
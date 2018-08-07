class AyudasdocumentosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudasdocumentos = ayuda.ayudasdocumentos.all
  end

 def edit
    @ayudasdocumento  = Ayudasdocumento.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudasdocumento.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudasdocumento" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudasdocumento = Ayudasdocumento.new(params[:ayudasdocumento])
    @ayudasdocumento.user_id = is_admin
    if @ayudasdocumento.valid?
      @ayuda.ayudasdocumentos << @ayudasdocumento
      @ayuda.save
      @ayudasdocumento = Ayudasdocumento.new
      flash[:ayudasdocumento] = "Creado con exito"
    else
      flash[:ayudasdocumento] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudasdocumentos" }
    end
  end

  def update
    @ayudasdocumento        = Ayudasdocumento.new
    ayudasdocumento         = Ayudasdocumento.find(params[:id])
    #ayudasdocumento.user_id = is_admin
    @ayuda        = ayudasdocumento.ayuda
    ok = ayudasdocumento.update_attributes(params[:ayudasdocumento])
    flash[:ayudasdocumento] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudasdocumentos" }
    end
  end

  def destroy
    ayudasdocumento   = Ayudasdocumento.find(params[:id])
    @ayuda  = ayudasdocumento.ayuda
    @ayudasdocumento  = Ayudasdocumento.new
    ayudasdocumento.destroy
    flash[:ayudasdocumento] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudasdocumentos" }
    end
  end
end

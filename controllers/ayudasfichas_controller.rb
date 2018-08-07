class AyudasfichasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudasfichas = ayuda.ayudasfichas.all
  end

 def edit
    @ayudasficha  = Ayudasficha.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudasficha.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudasficha" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudasficha = Ayudasficha.new(params[:ayudasficha])
    @ayudasficha.user_id = is_admin
    if @ayudasficha.valid?
      @ayuda.ayudasfichas << @ayudasficha
      @ayuda.save
      @ayudasficha = Ayudasficha.new
      flash[:ayudasficha] = "Creado con exito"
    else
      flash[:ayudasficha] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudasfichas" }
    end
  end

  def update
    @ayudasficha        = Ayudasficha.new
    ayudasficha         = Ayudasficha.find(params[:id])
    #ayudasficha.user_id = is_admin
    @ayuda        = ayudasficha.ayuda
    ok = ayudasficha.update_attributes(params[:ayudasficha])
    flash[:ayudasficha] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudasfichas" }
    end
  end

  def destroy
    ayudasficha   = Ayudasficha.find(params[:id])
    @ayuda  = ayudasficha.ayuda
    @ayudasficha  = Ayudasficha.new
    ayudasficha.destroy
    flash[:ayudasficha] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudasfichas" }
    end
  end
end

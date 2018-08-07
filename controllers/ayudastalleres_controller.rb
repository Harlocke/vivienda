class AyudastalleresController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    ayuda   = Ayuda.find(params[:ayuda_id])
    @ayudastalleres = ayuda.ayudastalleres.all
  end

 def edit
    @ayudastaller  = Ayudastaller.find(params[:id], :include => "ayuda")
    @ayuda  = @ayudastaller.ayuda
    respond_to do |format|
      format.js { render :action => "edit_ayudastaller" }
    end
  end

  def create
    @ayuda  = Ayuda.find(params[:ayuda_id])
    @ayudastaller = Ayudastaller.new(params[:ayudastaller])
    @ayudastaller.user_id = is_admin
    if @ayudastaller.valid?
      @ayuda.ayudastalleres << @ayudastaller
      @ayuda.save
      @ayudastaller = Ayudastaller.new
      flash[:ayudastaller] = "Creado con exito"
    else
      flash[:ayudastaller] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "ayudastalleres" }
    end
  end

  def update
    @ayudastaller        = Ayudastaller.new
    ayudastaller         = Ayudastaller.find(params[:id])
    #ayudastaller.user_id = is_admin
    @ayuda        = ayudastaller.ayuda
    ok = ayudastaller.update_attributes(params[:ayudastaller])
    flash[:ayudastaller] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "ayudastalleres" }
    end
  end

  def destroy
    ayudastaller   = Ayudastaller.find(params[:id])
    @ayuda  = ayudastaller.ayuda
    @ayudastaller  = Ayudastaller.new
    ayudastaller.destroy
    flash[:ayudastaller] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "ayudastalleres" }
    end
  end
end
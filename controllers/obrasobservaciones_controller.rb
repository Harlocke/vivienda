class ObrasobservacionesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    obraspublica   = Obraspublica.find(params[:obraspublica_id])
    @obrasobservaciones = obraspublica.obrasobservaciones.all
  end

 def edit
    @obrasobservacion  = Obrasobservacion.find(params[:id], :include => "obraspublica")
    @obraspublica  = @obrasobservacion.obraspublica
    respond_to do |format|
      format.js { render :action => "edit_obrasobservacion" }
    end
  end

  def create
    @obraspublica  = Obraspublica.find(params[:obraspublica_id])
    @obrasobservacion = Obrasobservacion.new(params[:obrasobservacion])
    @obrasobservacion.user_id = is_admin
    if @obrasobservacion.valid?
      @obraspublica.obrasobservaciones << @obrasobservacion
      @obraspublica.save
      @obrasobservacion = Obrasobservacion.new
      flash[:obrasobservacion] = "Creado con exito"
    else
      flash[:obrasobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "obrasobservaciones" }
    end
  end

  def update
    @obrasobservacion        = Obrasobservacion.new
    obrasobservacion         = Obrasobservacion.find(params[:id])
    #obrasobservacion.user_id = is_admin
    @obraspublica        = obrasobservacion.obraspublica
    ok = obrasobservacion.update_attributes(params[:obrasobservacion])
    flash[:obrasobservacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "obrasobservaciones" }
    end
  end

  def destroy
    obrasobservacion   = Obrasobservacion.find(params[:id])
    @obraspublica  = obrasobservacion.obraspublica
    @obrasobservacion  = Obrasobservacion.new
    obrasobservacion.destroy
    flash[:obrasobservacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "obrasobservaciones" }
    end
  end

  def atencion
    @obrasobservaciones = Obrasobservacion.find(params[:id])
  end

  private
  def determine_layout
    if ['atencion'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

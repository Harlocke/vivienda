class ObrasdisponibilidadesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    obraspublica   = Obraspublica.find(params[:obraspublica_id])
    @obrasdisponibilidades = obraspublica.obrasdisponibilidades.all
  end

 def edit
    @obrasdisponibilidad  = Obrasdisponibilidad.find(params[:id], :include => "obraspublica")
    @obraspublica  = @obrasdisponibilidad.obraspublica
    respond_to do |format|
      format.js { render :action => "edit_obrasdisponibilidad" }
    end
  end

  def create
    @obraspublica  = Obraspublica.find(params[:obraspublica_id])
    @obrasdisponibilidad = Obrasdisponibilidad.new(params[:obrasdisponibilidad])
    @obrasdisponibilidad.user_id = is_admin
    if @obrasdisponibilidad.valid?
      @obraspublica.obrasdisponibilidades << @obrasdisponibilidad
      @obraspublica.save
      @obrasdisponibilidad = Obrasdisponibilidad.new
      flash[:obrasdisponibilidad] = "Creado con exito"
    else
      flash[:obrasdisponibilidad] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "obrasdisponibilidades" }
    end
  end

  def update
    @obrasdisponibilidad        = Obrasdisponibilidad.new
    obrasdisponibilidad         = Obrasdisponibilidad.find(params[:id])
    #obrasdisponibilidad.user_id = is_admin
    @obraspublica        = obrasdisponibilidad.obraspublica
    ok = obrasdisponibilidad.update_attributes(params[:obrasdisponibilidad])
    flash[:obrasdisponibilidad] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "obrasdisponibilidades" }
    end
  end

  def destroy
    obrasdisponibilidad   = Obrasdisponibilidad.find(params[:id])
    @obraspublica  = obrasdisponibilidad.obraspublica
    @obrasdisponibilidad  = Obrasdisponibilidad.new
    obrasdisponibilidad.destroy
    flash[:obrasdisponibilidad] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "obrasdisponibilidades" }
    end
  end
end

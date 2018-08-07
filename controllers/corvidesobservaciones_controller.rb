class CorvidesobservacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    corvide   = Corvide.find(params[:corvide_id])
    @corvidesobservaciones = corvide.corvidesobservaciones.all
  end

 def edit
    @corvidesobservacion  = Corvidesobservacion.find(params[:id], :include => "corvide")
    @corvide  = @corvidesobservacion.corvide
    respond_to do |format|
      format.js { render :action => "edit_corvidesobservacion" }
    end
  end

  def create
    @corvide  = Corvide.find(params[:corvide_id])
    @corvidesobservacion = Corvidesobservacion.new(params[:corvidesobservacion])
    @corvidesobservacion.user_id = is_admin
    if @corvidesobservacion.valid?
      @corvide.corvidesobservaciones << @corvidesobservacion
      @corvide.save
      @corvidesobservacion = Corvidesobservacion.new
      flash[:corvidesobservacion] = "Creado con exito"
    else
      flash[:corvidesobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "corvidesobservaciones" }
    end
  end

  def update
    @corvidesobservacion        = Corvidesobservacion.new
    corvidesobservacion         = Corvidesobservacion.find(params[:id])
    @corvide        = corvidesobservacion.corvide
    ok = corvidesobservacion.update_attributes(params[:corvidesobservacion])
    if ok == true
      flash[:benevivienda] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "corvidesobservaciones" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    corvidesobservacion   = Corvidesobservacion.find(params[:id])
    @corvide  = corvidesobservacion.corvide
    @corvidesobservacion  = Corvidesobservacion.new
    corvidesobservacion.destroy
    flash[:corvidesobservacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "corvidesobservaciones" }
    end
  end
end
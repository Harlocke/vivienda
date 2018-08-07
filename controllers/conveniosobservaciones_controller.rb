class ConveniosobservacionesController < ApplicationController
  before_filter :require_user

  def index
    convenio   = Convenio.find(params[:convenio_id])
    @conveniosobservaciones = convenio.conveniosobservaciones.all
  end

  def edit
    @conveniosobservacion  = Conveniosobservacion.find(params[:id], :include => "convenio")
    @convenio  = @conveniosobservacion.convenio
    respond_to do |format|
      format.js { render :action => "edit_conveniosobservacion" }
    end
  end

  def buscar
        respond_to do |format|
           format.html
           format.xls if params[:format] == 'xls'
        end
  end

  def create
    @convenio  = Convenio.find(params[:convenio_id])
    @conveniosobservacion = Conveniosobservacion.new(params[:conveniosobservacion])
    @conveniosobservacion.user_id = is_admin
    if @conveniosobservacion.valid?
      @convenio.conveniosobservaciones << @conveniosobservacion
      @convenio.save
      @conveniosobservacion = Conveniosobservacion.new
      flash[:conveniosobservacion] = "Registro almacenado con Exito"
    else
      flash[:conveniosobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "conveniosobservaciones" }
    end
  end

  def update
    @conveniosobservacion        = Conveniosobservacion.new
    conveniosobservacion         = Conveniosobservacion.find(params[:id])
    @convenio        = conveniosobservacion.convenio
    ok = conveniosobservacion.update_attributes(params[:conveniosobservacion])
    flash[:conveniosobservacion] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "conveniosobservaciones" }
    end
  end

  def destroy
    conveniosobservacion   = Conveniosobservacion.find(params[:id])
    @convenio  = conveniosobservacion.convenio
    @conveniosobservacion  = Conveniosobservacion.new
    conveniosobservacion.destroy
    respond_to do |format|
      format.js { render :action => "conveniosobservaciones" }
    end
  end
end

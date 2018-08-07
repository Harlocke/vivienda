class LegalizacionesmatriculasController < ApplicationController
  before_filter :require_user

  def index
    legalizacion   = Legalizacion.find(params[:legalizacion_id])
    @legalizacionesmatriculas = legalizacion.legalizacionesmatriculas.all
  end

  def edit
    @legalizacionesmatricula  = Legalizacionesmatricula.find(params[:id], :include => "legalizacion")
    @legalizacion  = @legalizacionesmatricula.legalizacion
    respond_to do |format|
      format.js { render :action => "edit_legalizacionesmatricula" }
    end
  end

  def buscar
        respond_to do |format|
           format.html
           format.xls if params[:format] == 'xls'
        end
  end

  def create
    @legalizacion  = Legalizacion.find(params[:legalizacion_id])
    @legalizacionesmatricula = Legalizacionesmatricula.new(params[:legalizacionesmatricula])
    @legalizacionesmatricula.user_id = is_admin
    if @legalizacionesmatricula.valid?
      @legalizacion.legalizacionesmatriculas << @legalizacionesmatricula
      @legalizacion.save
      @legalizacionesmatricula = Legalizacionesmatricula.new
      flash[:legalizacionesmatricula] = "Registro almacenado con Exito"
    else
      flash[:legalizacionesmatricula] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "legalizacionesmatriculas" }
    end
  end

  def update
    @legalizacionesmatricula        = Legalizacionesmatricula.new
    legalizacionesmatricula         = Legalizacionesmatricula.find(params[:id])
    @legalizacion        = legalizacionesmatricula.legalizacion
    ok = legalizacionesmatricula.update_attributes(params[:legalizacionesmatricula])
    flash[:legalizacionesmatricula] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "legalizacionesmatriculas" }
    end
  end

  def destroy
    legalizacionesmatricula   = Legalizacionesmatricula.find(params[:id])
    @legalizacion  = legalizacionesmatricula.legalizacion
    @legalizacionesmatricula  = Legalizacionesmatricula.new
    legalizacionesmatricula.destroy
    respond_to do |format|
      format.js { render :action => "legalizacionesmatriculas" }
    end
  end
end
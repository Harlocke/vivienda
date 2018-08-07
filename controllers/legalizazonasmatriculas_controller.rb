class LegalizazonasmatriculasController < ApplicationController
  before_filter :require_user

  def index
    legalizacion   = Legalizacion.find(params[:legalizacion_id])
    @legalizazonasmatriculas = legalizacion.legalizazonasmatriculas.all
  end

  def edit
    @legalizazonasmatricula  = Legalizazonasmatricula.find(params[:id], :include => "legalizacion")
    @legalizacion  = @legalizazonasmatricula.legalizacion
    respond_to do |format|
      format.js { render :action => "edit_legalizazonasmatricula" }
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
    @legalizazonasmatricula = Legalizazonasmatricula.new(params[:legalizazonasmatricula])
    @legalizazonasmatricula.user_id = is_admin
    if @legalizazonasmatricula.valid?
      @legalizacion.legalizazonasmatriculas << @legalizazonasmatricula
      @legalizacion.save
      @legalizazonasmatricula = Legalizazonasmatricula.new
      flash[:legalizazonasmatricula] = "Registro almacenado con Exito"
    else
      flash[:legalizazonasmatricula] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "legalizazonasmatriculas" }
    end
  end

  def update
    @legalizazonasmatricula        = Legalizazonasmatricula.new
    legalizazonasmatricula         = Legalizazonasmatricula.find(params[:id])
    @legalizacion        = legalizazonasmatricula.legalizacion
    ok = legalizazonasmatricula.update_attributes(params[:legalizazonasmatricula])
    flash[:legalizazonasmatricula] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "legalizazonasmatriculas" }
    end
  end

  def destroy
    legalizazonasmatricula   = Legalizazonasmatricula.find(params[:id])
    @legalizacion  = legalizazonasmatricula.legalizacion
    @legalizazonasmatricula  = Legalizazonasmatricula.new
    legalizazonasmatricula.destroy
    respond_to do |format|
      format.js { render :action => "legalizazonasmatriculas" }
    end
  end
end
class LegalizacionesproyectosController < ApplicationController
  before_filter :require_user

  def index
    legalizacion   = Legalizacion.find(params[:legalizacion_id])
    @legalizacionesproyectos = legalizacion.legalizacionesproyectos.all
  end

  def edit
    @legalizacionesproyecto  = Legalizacionesproyecto.find(params[:id], :include => "legalizacion")
    @legalizacion  = @legalizacionesproyecto.legalizacion
    respond_to do |format|
      format.js { render :action => "edit_legalizacionesproyecto" }
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
    @legalizacionesproyecto = Legalizacionesproyecto.new(params[:legalizacionesproyecto])
    @legalizacionesproyecto.user_id = is_admin
    if @legalizacionesproyecto.valid?
      @legalizacion.legalizacionesproyectos << @legalizacionesproyecto
      @legalizacion.save
      @legalizacionesproyecto = Legalizacionesproyecto.new
      flash[:legalizacionesproyecto] = "Registro almacenado con Exito"
    else
      flash[:legalizacionesproyecto] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "legalizacionesproyectos" }
    end
  end

  def update
    @legalizacionesproyecto        = Legalizacionesproyecto.new
    legalizacionesproyecto         = Legalizacionesproyecto.find(params[:id])
    @legalizacion        = legalizacionesproyecto.legalizacion
    ok = legalizacionesproyecto.update_attributes(params[:legalizacionesproyecto])
    flash[:legalizacionesproyecto] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "legalizacionesproyectos" }
    end
  end

  def destroy
    legalizacionesproyecto   = Legalizacionesproyecto.find(params[:id])
    @legalizacion  = legalizacionesproyecto.legalizacion
    @legalizacionesproyecto  = Legalizacionesproyecto.new
    legalizacionesproyecto.destroy
    respond_to do |format|
      format.js { render :action => "legalizacionesproyectos" }
    end
  end
end
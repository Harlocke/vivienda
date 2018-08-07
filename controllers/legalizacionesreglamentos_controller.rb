class LegalizacionesreglamentosController < ApplicationController
  before_filter :require_user

  def index
    legalizacion   = Legalizacion.find(params[:legalizacion_id])
    @legalizacionesreglamentos = legalizacion.legalizacionesreglamentos.all
  end

  def edit
    @legalizacionesreglamento  = Legalizacionesreglamento.find(params[:id], :include => "legalizacion")
    @legalizacion  = @legalizacionesreglamento.legalizacion
    respond_to do |format|
      format.js { render :action => "edit_legalizacionesreglamento" }
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
    @legalizacionesreglamento = Legalizacionesreglamento.new(params[:legalizacionesreglamento])
    @legalizacionesreglamento.user_id = is_admin
    if @legalizacionesreglamento.valid?
      @legalizacion.legalizacionesreglamentos << @legalizacionesreglamento
      @legalizacion.save
      @legalizacionesreglamento = Legalizacionesreglamento.new
      flash[:legalizacionesreglamento] = "Registro almacenado con Exito"
    else
      flash[:legalizacionesreglamento] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "legalizacionesreglamentos" }
    end
  end

  def update
    @legalizacionesreglamento        = Legalizacionesreglamento.new
    legalizacionesreglamento         = Legalizacionesreglamento.find(params[:id])
    @legalizacion        = legalizacionesreglamento.legalizacion
    ok = legalizacionesreglamento.update_attributes(params[:legalizacionesreglamento])
    flash[:legalizacionesreglamento] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "legalizacionesreglamentos" }
    end
  end

  def destroy
    legalizacionesreglamento   = Legalizacionesreglamento.find(params[:id])
    @legalizacion  = legalizacionesreglamento.legalizacion
    @legalizacionesreglamento  = Legalizacionesreglamento.new
    legalizacionesreglamento.destroy
    respond_to do |format|
      format.js { render :action => "legalizacionesreglamentos" }
    end
  end
end
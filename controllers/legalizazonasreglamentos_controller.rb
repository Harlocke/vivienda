class LegalizazonasreglamentosController < ApplicationController
  before_filter :require_user

  def index
    legalizacion   = Legalizacion.find(params[:legalizacion_id])
    @legalizazonasreglamentos = legalizacion.legalizazonasreglamentos.all
  end

  def edit
    @legalizazonasreglamento  = Legalizazonasreglamento.find(params[:id], :include => "legalizacion")
    @legalizacion  = @legalizazonasreglamento.legalizacion
    respond_to do |format|
      format.js { render :action => "edit_legalizazonasreglamento" }
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
    @legalizazonasreglamento = Legalizazonasreglamento.new(params[:legalizazonasreglamento])
    @legalizazonasreglamento.user_id = is_admin
    if @legalizazonasreglamento.valid?
      @legalizacion.legalizazonasreglamentos << @legalizazonasreglamento
      @legalizacion.save
      @legalizazonasreglamento = Legalizazonasreglamento.new
      flash[:legalizazonasreglamento] = "Registro almacenado con Exito"
    else
      flash[:legalizazonasreglamento] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "legalizazonasreglamentos" }
    end
  end

  def update
    @legalizazonasreglamento        = Legalizazonasreglamento.new
    legalizazonasreglamento         = Legalizazonasreglamento.find(params[:id])
    @legalizacion        = legalizazonasreglamento.legalizacion
    ok = legalizazonasreglamento.update_attributes(params[:legalizazonasreglamento])
    flash[:legalizazonasreglamento] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "legalizazonasreglamentos" }
    end
  end

  def destroy
    legalizazonasreglamento   = Legalizazonasreglamento.find(params[:id])
    @legalizacion  = legalizazonasreglamento.legalizacion
    @legalizazonasreglamento  = Legalizazonasreglamento.new
    legalizazonasreglamento.destroy
    respond_to do |format|
      format.js { render :action => "legalizazonasreglamentos" }
    end
  end
end
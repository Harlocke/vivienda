class ConveniospagosController < ApplicationController
  before_filter :require_user

  def index
    convenio   = Convenio.find(params[:convenio_id])
    @conveniospagos = convenio.conveniospagos.all
  end

  def edit
    @conveniospago  = Conveniospago.find(params[:id], :include => "convenio")
    @convenio  = @conveniospago.convenio
    respond_to do |format|
      format.js { render :action => "edit_conveniospago" }
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
    @conveniospago = Conveniospago.new(params[:conveniospago])
    @conveniospago.user_id = is_admin
    if @conveniospago.valid?
      @convenio.conveniospagos << @conveniospago
      @convenio.save
      @conveniospago = Conveniospago.new
      flash[:conveniospago] = "Registro almacenado con Exito"
    else
      flash[:conveniospago] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "conveniospagos" }
    end
  end

  def update
    @conveniospago        = Conveniospago.new
    conveniospago         = Conveniospago.find(params[:id])
    @convenio        = conveniospago.convenio
    ok = conveniospago.update_attributes(params[:conveniospago])
    flash[:conveniospago] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "conveniospagos" }
    end
  end

  def destroy
    conveniospago   = Conveniospago.find(params[:id])
    @convenio  = conveniospago.convenio
    @conveniospago  = Conveniospago.new
    conveniospago.destroy
    respond_to do |format|
      format.js { render :action => "conveniospagos" }
    end
  end
end

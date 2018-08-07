class ConveniosformasController < ApplicationController
  before_filter :require_user

  def index
    convenio   = Convenio.find(params[:convenio_id])
    @conveniosformas = convenio.conveniosformas.all
  end

  def edit
    @conveniosforma  = Conveniosforma.find(params[:id], :include => "convenio")
    @convenio  = @conveniosforma.convenio
    respond_to do |format|
      format.js { render :action => "edit_conveniosforma" }
    end
  end

  def create
    @convenio  = Convenio.find(params[:convenio_id])
    @conveniosforma = Conveniosforma.new(params[:conveniosforma])
    @conveniosforma.user_id = is_admin
    if @conveniosforma.valid?
      @convenio.conveniosformas << @conveniosforma
      @convenio.save
      @conveniosforma = Conveniosforma.new
      flash[:conveniosforma] = "Registro almacenado con Exito"
    else
      flash[:conveniosforma] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "conveniosformas" }
    end
  end

  def update
    @conveniosforma        = Conveniosforma.new
    conveniosforma         = Conveniosforma.find(params[:id])
    params[:conveniosforma][:user_actualiza] = is_admin
    @convenio        = conveniosforma.convenio
    ok = conveniosforma.update_attributes(params[:conveniosforma])
    flash[:conveniosforma] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "conveniosformas" }
    end
  end

  def destroy
    conveniosforma   = Conveniosforma.find(params[:id])
    @convenio  = conveniosforma.convenio
    @conveniosforma  = Conveniosforma.new
    conveniosforma.destroy
    respond_to do |format|
      format.js { render :action => "conveniosformas" }
    end
  end
end

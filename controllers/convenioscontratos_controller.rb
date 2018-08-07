class ConvenioscontratosController < ApplicationController
  before_filter :require_user

  def index
    convenio   = Convenio.find(params[:convenio_id])
    @convenioscontratos = convenio.convenioscontratos.all
  end

  def edit
    @convenioscontrato  = Convenioscontrato.find(params[:id], :include => "convenio")
    @convenio  = @convenioscontrato.convenio
    respond_to do |format|
      format.js { render :action => "edit_convenioscontrato" }
    end
  end

  def create
    @convenio  = Convenio.find(params[:convenio_id])
    @convenioscontrato = Convenioscontrato.new(params[:convenioscontrato])
    if Contrato.exists?(["nro_contrato = '#{params[:convenioscontrato][:nro_contrato]}' and to_char(fecha_firma,'YYYY') = '#{params[:convenioscontrato][:anno]}'"]) == true
      @convenioscontrato.contrato_id = Contrato.find(:first, :conditions =>["nro_contrato = '#{params[:convenioscontrato][:nro_contrato]}' and to_char(fecha_firma,'YYYY') = '#{params[:convenioscontrato][:anno]}'"]).id rescue nil
      @convenioscontrato.user_id = is_admin
      if @convenioscontrato.valid?
        @convenio.convenioscontratos << @convenioscontrato
        @convenio.save
        @convenioscontrato = Convenioscontrato.new
        flash[:convenioscontrato] = "Registro almacenado con Exito"
        respond_to do |format|
          format.js { render :action => "convenioscontratos" }
        end
      else
        flash[:convenioscontrato] = "Se produjo un error al guardar el registro"
        respond_to do |format|
          format.js { render :action => "convenioscontratos" }
        end
      end
    else
      render :update do |page|
        page.alert "El Nro de contrato no es valido.. Verifique!!!"
      end
    end
  end

  def update
    @convenioscontrato = Convenioscontrato.new
    convenioscontrato = Convenioscontrato.find(params[:id])
    @convenio = convenioscontrato.convenio
    ok = convenioscontrato.update_attributes(params[:convenioscontrato])
    flash[:convenioscontrato] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "convenioscontratos" }
    end
  end

  def destroy
    convenioscontrato = Convenioscontrato.find(params[:id])
    @convenio = convenioscontrato.convenio
    @convenioscontrato  = Convenioscontrato.new
    convenioscontrato.destroy
    respond_to do |format|
      format.js { render :action => "convenioscontratos" }
    end
  end
end

class ConveniosetapasController < ApplicationController
  before_filter :require_user

  def index
    convenio   = Convenio.find(params[:convenio_id])
    @conveniosetapas = convenio.conveniosetapas.all
  end

  def edit
    @conveniosetapa  = Conveniosetapa.find(params[:id], :include => "convenio")
    @convenio  = @conveniosetapa.convenio
    respond_to do |format|
      format.js { render :action => "edit_conveniosetapa" }
    end
  end

  def create
    @convenio  = Convenio.find(params[:convenio_id])
    @conveniosetapa = Conveniosetapa.new(params[:conveniosetapa])
    if @conveniosetapa.valid?
      if Conveniosetapa.exists?(["convenio_id = #{params[:convenio_id]} and persona_id = #{params[:conveniosetapa][:persona_id]} and fechafin is null"]) == false
        @conveniosetapa.user_id = is_admin
        @convenio.conveniosetapas << @conveniosetapa
        @convenio.save
        @conveniosetapa = Conveniosetapa.new
        flash[:conveniosetapa] = "Registro almacenado con Exito"
        respond_to do |format|
          format.js { render :action => "conveniosetapas" }
        end
      else
        render :update do |page|
          page.alert "Este usuario ya tiene una etapa activa... Verifique!!!"
        end
      end
    else
      flash[:conveniosetapa] = "Se produjo un error al guardar el registro"
      respond_to do |format|
        format.js { render :action => "conveniosetapas" }
      end
    end
  end

  def update
    @conveniosetapa        = Conveniosetapa.new
    conveniosetapa         = Conveniosetapa.find(params[:id])
    @convenio        = conveniosetapa.convenio
    ok = conveniosetapa.update_attributes(params[:conveniosetapa])
    flash[:conveniosetapa] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "conveniosetapas" }
    end
  end

  def destroy
    conveniosetapa   = Conveniosetapa.find(params[:id])
    @convenio  = conveniosetapa.convenio
    @conveniosetapa  = Conveniosetapa.new
    conveniosetapa.destroy
    respond_to do |format|
      format.js { render :action => "conveniosetapas" }
    end
  end
end

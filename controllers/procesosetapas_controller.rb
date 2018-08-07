class ProcesosetapasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    procesosjuridico   = Procesosjuridico.find(params[:procesosjuridico_id])
    @procesosetapas = procesosjuridico.procesosetapas.all
  end

  def edit
    @procesosetapa  = Procesosetapa.find(params[:id], :include => "procesosjuridico")
    @procesosjuridico  = @procesosetapa.procesosjuridico
    respond_to do |format|
      format.js { render :action => "edit_procesosetapa" }
    end
  end

  def adicionar
    @procesosetapa  = Procesosetapa.find(params[:id])
    if @procesosetapa.update_attributes(params[:procesosetapa])
      flash[:procesosetapa] = "Actualizado con exito"
    end
  end

  def create
    @procesosjuridico  = Procesosjuridico.find(params[:procesosjuridico_id])
    @procesosetapa = Procesosetapa.new(params[:procesosetapa])
    existeproc = ""
    if @procesosetapa.etapasproceso_id.to_s == '10012' or @procesosetapa.etapasproceso_id.to_s == '10013'
      existeproc = Procesosetapa.exists?(["procesosjuridico_id = #{@procesosjuridico.id} and etapasproceso_id = #{@procesosetapa.etapasproceso_id} and firmeza_fallo = '2'"])
    end
    if existeproc == true
      render :update do |page|
        page.alert "ATENCIÓN: El proceso ya tiene este tipo de fallo en Ejecución.... Verifique!!!"
      end
    else
      if @procesosetapa.valid?
        @procesosjuridico.procesosetapas << @procesosetapa
        @procesosjuridico.save
        @procesosetapa = Procesosetapa.new
        flash[:procesosetapa] = "Creado con exito"+existeproc.to_s
      else
        flash[:procesosetapa] = "Se produjo un error al guardar el registro"+existeproc.to_s
      end
      respond_to do |format|
        format.js { render :action => "procesosetapas" }
      end
    end
  end

  def update
    @procesosetapa        = Procesosetapa.new
    procesosetapa         = Procesosetapa.find(params[:id])
    @procesosjuridico        = procesosetapa.procesosjuridico
    ok = procesosetapa.update_attributes(params[:procesosetapa])
    flash[:procesosetapa] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "procesosetapas" }
    end
  end

  def destroy
    procesosetapa   = Procesosetapa.find(params[:id])
    @procesosjuridico  = procesosetapa.procesosjuridico
    @procesosetapa  = Procesosetapa.new
    procesosetapa.destroy
    flash[:procesosetapa] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "procesosetapas" }
    end
  end

  def seguimiento
    @procesosetapa   = Procesosetapa.find(params[:id])
  end

  private
  def determine_layout
    if ['seguimiento','adicionar'].include?(action_name)
      "new2"
    else
      "application"
    end
  end
#  def show
#    persona   = Persona.find(params[:persona_id])
#    @procesosetapas = persona.procesosetapas.all
#  end
end

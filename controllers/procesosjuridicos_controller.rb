class ProcesosjuridicosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
  end

  def show
    @procesosjuridico = Procesosjuridico.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @procesosjuridico }
    end
  end

  def buscar
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end    
    @procesosjuridico  = Procesosjuridico.new
    @procesosjuridico.tiposproceso_id =  params[:ubicacion][:tiposproceso_id]
    @procesosjuridico.nro_radicado =  params[:nro_radicado]
    @procesosjuridico.anno_radicado =  params[:anno_radicado]
    @procesosjuridico.juzgado = params[:juzgado]
    @procesosjuridico.demandante = params[:demandante]
    @procesosjuridico.demandado = params[:demandado]
    @procesosjuridico.poblacionesespecial_id = params[:ubicacion][:poblacionesespecial_id]
    @procesosjuridico.observacion_proceso = params[:observacion_proceso]
    @procesosjuridico.pretension = params[:pretension]
    @procesosjuridico.etapa = params[:etapa]
    @procesosjuridico.subetapa = params[:subetapa]
    @procesosjuridico.cuantia = params[:cuantia]
    @procesosjuridico.estado = params[:estado]
    @procesosjuridicos = Procesosjuridico.search(@procesosjuridico, params[:ubicacion][:estadoproceso],params[:page],perpage)
    if @procesosjuridicos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to procesosjuridicos_path
    elsif params[:format] != 'xls'
      if @procesosjuridicos.count == 1
        redirect_to edit_procesosjuridico_path(@procesosjuridicos)
      else
        respond_to do |format|
          format.html
        end
      end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Procesosjudi_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def informeconsolidado
    @procesosjuridicos = Procesosjuridico.search(@procesosjuridico, params[:ubicacion][:estadoproceso])
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_ConsolidadoProc_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
  end

  def new
    @procesosjuridico = Procesosjuridico.new
    render :action => "procesosjuridico_form"
  end

  def edit
    @procesosjuridico = Procesosjuridico.find(params[:id])
    @procesosetapa  = Procesosetapa.new
    @procesospersona = Procesospersona.new
    respond_to do |format|
      format.html { render :action => "procesosjuridico_form" }
    end
  end

  def create
    @procesosjuridico = Procesosjuridico.new(params[:procesosjuridico])
    if @procesosjuridico.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_procesosjuridico_path(@procesosjuridico)
    else
      render :action => "procesosjuridico_form"
    end
  end

  def update
    @procesosjuridico = Procesosjuridico.find(params[:id])
    if @procesosjuridico.update_attributes(params[:procesosjuridico])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_procesosjuridico_path(@procesosjuridico)
    else
      @procesosetapa = Procesosetapa.new
      @procesospersona = Procesospersona.new
      render :action => "procesosjuridico_form"
    end
    rescue
      redirect_to edit_procesosjuridico_path(@procesosjuridico)
  end

  def destroy
    @procesosjuridico = Procesosjuridico.find(params[:id])
    @procesosjuridico.destroy
    respond_to do |format|
      format.html {
      flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to procesosjuridicos_path
        }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if['informeconsolidado'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

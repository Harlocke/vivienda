class DemandasController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    @demandas = Demanda.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @demandas }
    end
  end

  def show
    @demanda = Demanda.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @demanda }
    end
  end

  def buscar
    @demanda  = Demanda.new
    @demanda.id =  params[:id]
    @demanda.radicado =  params[:radicado]
    @demanda.tipoproceso = params[:ubicacion][:tipoproceso]
    @demanda.notificado = params[:ubicacion][:notificado]
    @demandas = Demanda.search(@demanda, params[:cobama])
    if @demandas.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to titulaciones_path
    elsif params[:format] != 'xls'
      if @demandas.count == 1
        redirect_to edit_demanda_path(@demandas)
      else
        respond_to do |format|
          format.html
        end
      end
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Demanda_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def new
    @demanda = Demanda.new
    @demandascobama = Demandascobama.new
    render :action => "demanda_form"
  end

  def edit
    @demanda = Demanda.find(params[:id])
    @demandascobama = Demandascobama.new
    respond_to do |format|
      format.html { render :action => "demanda_form" }
    end
  end

  def create
    @demanda = Demanda.new(params[:demanda])
    @demanda.user_id = is_admin
    @demanda.user_actualiza = is_admin
    if @demanda.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_demanda_path(@demanda)
    else
      @demandascobama = Demandascobama.new
      render :action => "demanda_form"
    end
  end

  def update
    @demanda = Demanda.find(params[:id])
    @demanda.user_actualiza = is_admin
    if @demanda.update_attributes(params[:demanda])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_demanda_path(@demanda)
    else
      @demandascobama = Demandascobama.new
      render :action => "demanda_form"
    end
    rescue
      redirect_to edit_demanda_path(@demanda)
  end

  def destroy
    @demanda = Demanda.find(params[:id])
    @demanda.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_demandas_path
        }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['informe','informeseguimiento'].include?(action_name)
      "excel"
    elsif['pertenencia','poder'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

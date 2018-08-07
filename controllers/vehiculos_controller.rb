class VehiculosController < ApplicationController
  layout :determine_layout
  before_filter :require_user
  require 'ruby_plsql'

  def index
    #@vehiculos = Vehiculo.find(:all, :order=>"dbms_random.value")
    @vehiculos = Vehiculo.find(:all,:conditions=>["estado = 'ACTIVO'"], :order=>"placa")
    if params[:fecha].to_s == ""
      if params[:fecha1].to_s == ""
        @fecha = Time.now
      else
        @vehiculosprogramacion = Vehiculosprogramacion.find(params[:fecha1].to_i)
        @fecha = @vehiculosprogramacion.fecha
        #@fecha = params[:fecha1].to_date
      end
    else
      @fecha = params[:fecha].to_date
    end    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vehiculos }
    end
  end

  def indexc
    @vehiculos = Vehiculo.find(:all, :order=>"placa")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vehiculos }
    end
  end

  def buscar
    if params[:ubicacion][:fecha].to_s == ""
      @fecha = Time.now
    else
      @fecha = params[:ubicacion][:fecha].to_date
    end
    #logger.error("valor.... "+params[:ubicacion][:fecha].to_s)
    redirect_to :controller=>"vehiculos", :action=>"index", :fecha=>@fecha.to_date
  end

  def horario
    @vehiculos = Vehiculo.find(:all,:conditions=>["estado = 'ACTIVO'"], :order=>"id")
    @fecha = params[:ubicacion][:fecha].to_date
    @calidadversion = Calidadversion.find(1)
  end

  def horarioind
    @vehiculo = Vehiculo.find(params[:id])
    @fecha = params[:fecha].to_date
    @calidadversion = Calidadversion.find(1)
  end

  def new
    @vehiculo = Vehiculo.new
    render :action => "vehiculo_form"
  end

  def edit
    @vehiculo = Vehiculo.find(params[:id])
    respond_to do |format|
      format.html { render :action => "vehiculo_form" }
    end
  end

  def visualizar
    @vehiculo = Vehiculo.find(params[:id])
  end

  def create
    @vehiculo = Vehiculo.new(params[:vehiculo])
    @vehiculo.user_solicitante = is_admin
    if @vehiculo.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_vehiculo_path(@vehiculo)
    else
      render :action => "vehiculo_form"
    end
  end

  def update
    @enviacorreo = 'N'
    @vehiculo = Vehiculo.find(params[:id])
    if @vehiculo.update_attributes(params[:vehiculo])
      flash[:notice] = "El registro ha sido actualizado con Exito2"
      redirect_to edit_vehiculo_path(@vehiculo)
    else
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      render :action => "vehiculo_form"
    end
#    rescue
#      flash[:notice] = "Existen inconsistencias. Verifique!!!"
#      redirect_to edit_vehiculo_path(@vehiculo)
  end

  def destroy
    @vehiculo = Vehiculo.find(params[:id])
    @vehiculo.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to vehiculos_path
      }
      format.xml  { head :ok }
    end
  end

  def informe
    fch1 = params[:ubicacion][:fchinicial].to_s
    fch2 = params[:ubicacion][:fchfinal].to_s
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Transporte_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informetransporte('#{fch1.to_date}','#{fch2.to_date}'); end;")
    @veh1s = Vehiculo.find_by_sql("select * from informevehiculo order by placa, fecha")
    @veh2s = Vehiculo.find_by_sql("select * from informevehiculoc order by placa")
  end

  def informesub
    fch1 = params[:ubicacion][:fchinicial].to_s
    fch2 = params[:ubicacion][:fchfinal].to_s
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Transporte_Sub'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informetransportesub('#{fch1.to_date}','#{fch2.to_date}'); end;")
    @veh1s = Vehiculo.find_by_sql("select sum(usadas) as cantidad_horas, dependencia, fecha from informevehiculosub group by dependencia, fecha")
  end
  
  private
  def determine_layout
    if ['horario','horarioind'].include?(action_name)
      "tirilla"
    elsif['informe'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

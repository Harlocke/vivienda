class VehiculosprogramacionesController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    @vehiculosprogramaciones = Vehiculosprogramacion.find(:all)    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vehiculosprogramaciones }
    end
  end

  def new
    @vehiculosprogramacion = Vehiculosprogramacion.new
    render :action => "vehiculosprogramacion_form"
  end

  def edit
    @vehiculosprogramacion = Vehiculosprogramacion.find(params[:id])
    respond_to do |format|
      format.html { render :action => "vehiculosprogramacion_form" }
    end
  end

  def visualizar
    @vehiculosprogramacion = Vehiculosprogramacion.find(params[:id])
  end

  def create
    @vehiculosprogramacion = Vehiculosprogramacion.new(params[:vehiculosprogramacion])
    @vehiculosprogramacion.user_solicitante = is_admin
    @vehiculosprogramacion.nombre_conductor = Vehiculo.find(@vehiculosprogramacion.vehiculo_id).nombre rescue nil
    if @vehiculosprogramacion.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_vehiculosprogramacion_path(@vehiculosprogramacion)
    else
      render :action => "vehiculosprogramacion_form"
    end
  end

  def update
    @enviacorreo = 'N'
    @vehiculosprogramacion = Vehiculosprogramacion.find(params[:id])
    if @vehiculosprogramacion.user_actualiza.to_s == ""
      @enviacorreo = 'S'
    end
    @var = params[:vehiculosprogramacion][:horafinal].to_i
    if @var.to_i != @vehiculosprogramacion.horafinal.to_i
      params[:vehiculosprogramacion][:horafinal_ant] = @vehiculosprogramacion.horafinal.to_i
    else
      params[:vehiculosprogramacion][:horafinal_ant] = 0
    end
    params[:vehiculosprogramacion][:user_actualiza] = is_admin
    params[:vehiculosprogramacion][:nombre_conductor] = Vehiculo.find(@vehiculosprogramacion.vehiculo_id).nombre rescue nil
    if @vehiculosprogramacion.update_attributes(params[:vehiculosprogramacion])
      flash[:notice] = "El registro ha sido actualizado con Exito2"
      if @enviacorreo.to_s == 'S'
        begin
          @user = User.find(@vehiculosprogramacion.user_id)
          @usersol = User.find(@vehiculosprogramacion.user_actualiza).email
          Notifier.deliver_soltransporte_message(@user,@vehiculosprogramacion,@usersol)
          rescue Exception => exc
            logger.error("SIFI Correo NO enviado a #{@user.email.to_s rescue nil}")
        end
        redirect_to :controller=>"vehiculos", :action=>"index", :fecha=>@vehiculosprogramacion.fecha.to_date
      else
        redirect_to edit_vehiculosprogramacion_path(@vehiculosprogramacion)
      end
    else
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      render :action => "vehiculosprogramacion_form"
    end
#    rescue
#      flash[:notice] = "Existen inconsistencias. Verifique!!!"
#      redirect_to edit_vehiculosprogramacion_path(@vehiculosprogramacion)
  end

  def borrar
    @vehiculosprogramacion = Vehiculosprogramacion.find(params[:id])
    ActiveRecord::Base.connection.execute("update vehiculosprogramaciones set user_id=null, horafinal=null, destino=null, nro_pasajeros = null
                                           where  id = #{@vehiculosprogramacion.id}")
    ActiveRecord::Base.connection.execute("update vehiculosprogramaciones set user_id=null, horafinal=null, destino=null, programainicial=null, nro_pasajeros = null
                                           where  programainicial = #{@vehiculosprogramacion.id}")
    flash[:notice] = "Reserva eliminada"
    redirect_to vehiculos_path
  end

  def destroy
    @vehiculosprogramacion = Vehiculosprogramacion.find(params[:id])
    @vehiculosprogramacion.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to vehiculosprogramaciones_path
      }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['informe','informeseguimiento','informestitulacion','prestamostotal'].include?(action_name)
      "excel"
    elsif['informepantalla'].include?(action_name)
      "atencion"
    elsif ['visualizar'].include?(action_name)
      "new2"
    else
      "application"
    end
  end
end
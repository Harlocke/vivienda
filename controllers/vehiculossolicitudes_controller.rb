class VehiculossolicitudesController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    @vehiculossolicitudes  = Vehiculossolicitud.find(:all, :conditions=>["estado = 'PENDIENTE'"], :order=>"fecha desc")
    @vehiculossolicitudesa = Vehiculossolicitud.find(:all, :conditions=>["estado = 'ACEPTADO'"], :order=>"fecha desc")
    @vehiculossolicitudesr = Vehiculossolicitud.find(:all, :conditions=>["estado = 'RECHAZADO'"], :order=>"fecha desc")
    @vehiculossolicitudesc = Vehiculossolicitud.find(:all, :conditions=>["estado = 'CANCELADO'"], :order=>"fecha desc")
  end

  def new
    @vehiculossolicitud = Vehiculossolicitud.new
    @vehs = Vehiculossolicitud.find(:all, :conditions=>["user_id = #{is_admin}"],:limit=>"10", :order=>"created_at desc")
    render :action => "vehiculossolicitud_form"
  end

  def edit
    @vehiculossolicitud = Vehiculossolicitud.find(params[:id])
    respond_to do |format|
      format.html { render :action => "vehiculossolicitud_form" }
    end
  end

  def visualizar
    @vehiculossolicitud = Vehiculossolicitud.find(params[:id])
  end

  def create
    @vehiculossolicitud = Vehiculossolicitud.new(params[:vehiculossolicitud])
    @vehiculossolicitud.user_id = is_admin
    @vehiculossolicitud.estado = 'PENDIENTE'
    if @vehiculossolicitud.save
      flash[:notice] = "Se ha registrado correctamente el requerimiento de Transporte."
      begin
        emailsenvio = Sifi.find(88).valor rescue nil
        Notifier.deliver_reqtransporte_message(@vehiculossolicitud,emailsenvio)
        sleep 8
        rescue Exception => exc
          logger.error("SIFI Correo NO enviado a #{@user.email.to_s rescue nil}")
      end
      redirect_to menus_path
    else
      render :action => "vehiculossolicitud_form"
    end
  end

  def update
    @vehiculossolicitud = Vehiculossolicitud.find(params[:id])
    params[:vehiculossolicitud][:user_actualiza] = is_admin
    if @vehiculossolicitud.update_attributes(params[:vehiculossolicitud])
      flash[:notice] = "El registro ha sido actualizado con Exito2"
      redirect_to vehiculossolicitudes_path
    else
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      render :action => "vehiculossolicitud_form"
    end
#    rescue
#      flash[:notice] = "Existen inconsistencias. Verifique!!!"
#      redirect_to edit_vehiculossolicitud_path(@vehiculossolicitud)
  end

  def destroy
    if params[:id2].to_s == '2'
      @vehiculossolicitud = Vehiculossolicitud.find(params[:id])
      @vehiculossolicitud.estado = 'ACEPTADO'
      @vehiculossolicitud.save
    elsif params[:id2].to_s == '3'
      @vehiculossolicitud = Vehiculossolicitud.find(params[:id])
      @vehiculossolicitud.estado = 'RECHAZADO'
      @vehiculossolicitud.save
      begin
        Notifier.deliver_canctransporte_message(@vehiculossolicitud,'RECHAZADO')
        sleep 8
        rescue Exception => exc
          logger.error("SIFI Correo de RECHAZADO NO enviado a #{@vehiculossolicitud.id.to_s rescue nil}")
      end
    elsif params[:id2].to_s == '4'
      @vehiculossolicitud = Vehiculossolicitud.find(params[:id])
      @vehiculossolicitud.estado = 'CANCELADO'
      @vehiculossolicitud.save
      begin
        Notifier.deliver_canctransporte_message(@vehiculossolicitud,'CANCELADO')
        sleep 8
        rescue Exception => exc
          logger.error("SIFI Correo de CANCELADO NO enviado a #{@vehiculossolicitud.id.to_s rescue nil}")
      end
    else
      @vehiculossolicitud = Vehiculossolicitud.find(params[:id])
      @vehiculossolicitud.destroy
      respond_to do |format|
        format.html {
          flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
          redirect_to vehiculossolicitudes_path
        }
        format.xml  { head :ok }
      end
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
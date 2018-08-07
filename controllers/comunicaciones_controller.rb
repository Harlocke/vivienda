class ComunicacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @comunicaciones = Comunicacion.find(:all, :order=>"created_at desc")
  end

  def ver
    @comunicacion = Comunicacion.find(params[:id])
  end

  def boletindia
    @comunicacion = Comunicacion.find(:first, :conditions=>["fecha = trunc(sysdate)"])
  end

  def new
    @comunicacion = Comunicacion.new
    render :action => "comunicacion_form"
  end

  def edit
    @comunicacion = Comunicacion.find(params[:id])
    respond_to do |format|
      format.html { render :action => "comunicacion_form" }
    end
  end

  def create
    @comunicacion = Comunicacion.new(params[:comunicacion])
    if @comunicacion.save
      flash[:notice] = "Creado con Exito."
      redirect_to edit_comunicacion_path(@comunicacion)
    else
      render :action => "comunicacion_form"
     end
  end

  def update
    @comunicacion = Comunicacion.find(params[:id])
    if @comunicacion.update_attributes(params[:comunicacion])
     flash[:notice] = "Actualizado con Exito."
      redirect_to edit_comunicacion_path(@comunicacion)
    else
      render :action => "comunicacion_form"
    end
    rescue
      redirect_to edit_comunicacion_path(@comunicacion)
  end

  def destroy
    @comunicacion = Comunicacion.find(params[:id])
    @comunicacion.destroy
    respond_to do |format|
      format.html { redirect_to(comunicaciones_url) }
      format.xml  { head :ok }
    end
  end

  def read
    com = Comunicacion.find(params[:id])
    @comunicacionesuser = Comunicacionesuser.new
    @comunicacionesuser.comunicacion_id = com.id
    @comunicacionesuser.user_id = is_admin
    @comunicacionesuser.save
    redirect_to menus_path
  end

  private
  def determine_layout
    if ['boletindia', 'ver'].include?(action_name)
      "boletin"
    elsif['informeconsolidado','informedetallado','informeconsolidado2'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end
class InteractobservacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @interactobservaciones = Interactobservacion.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @interactobservaciones }
    end
  end

  def new
    @interactobservacion = Interactobservacion.new
    @interactobservacion.interactividad_id = params[:i].to_i
    render :action => "interactobservacion_form"
  end

  def edit
    @interactobservacion = Interactobservacion.find(params[:id])
    respond_to do |format|
      format.html { render :action => "interactobservacion_form" }
    end
  end

  def create
    @interactobservacion = Interactobservacion.new(params[:interactobservacion])
    @interactobservacion.user_id = is_admin
    if @interactobservacion.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_interactobservacion_path(@interactobservacion)
    else
      render :action => "interactobservacion_form"
    end
  end

  def update
    @interactobservacion = Interactobservacion.find(params[:id])
    if @interactobservacion.update_attributes(params[:interactobservacion])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_interactobservacion_path(@interactobservacion)
    else
      render :action => "interactobservacion_form"
    end
    rescue
      redirect_to edit_interactobservacion_path(@interactobservacion)
  end

  def destroy
    @interactobservacion = Interactobservacion.find(params[:id])
    @interactobservacion.destroy
    render :update do |page|
      page.alert "SIFI - Observación eliminada"
    end
  end

  def verificar
    @interactobservaciones = Interactobservacion.find(:all, :conditions=>["interactividad_id in (select id from interactividades where estudiosactividad_id = #{params[:estudiosactividad_id]})"])
  end

  private
  def determine_layout
    if ['actaaprobacionobra'].include?(action_name)
      "atencion"
    elsif['informeoperador','informefinanciero','informeactualizacion','informepersonal','informecomuna','informeconcepto','informeseguimiento'].include?(action_name)
      "excel"
    elsif['verificar'].include?(action_name)
      "new2"
    else
      "application"
    end
  end
end

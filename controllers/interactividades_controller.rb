class InteractividadesController < ApplicationController
  before_filter :require_user
  layout :determine_layout


  def index
    @interactividades = Interactividad.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @interactividades }
    end
  end

  def new
    @interactividad = Interactividad.new
    render :action => "interactividad_form"
  end

  def edit
    @interactividad = Interactividad.find(params[:id])
    respond_to do |format|
      format.html { render :action => "interactividad_form" }
    end
  end

  def siguiente
    @interactividad = Interactividad.find_by_interventoria_id_and_consecutivo(params[:id], params[:consecutivo])
    redirect_to edit_interactividad_path(@interactividad)
  end

  def create
    @interactividad = Interactividad.new(params[:interactividad])
    if @interactividad.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_interactividad_path(@interactividad)
    else
      render :action => "interactividad_form"
    end
  end

  def update
    @interactividad = Interactividad.find(params[:id])
    if @interactividad.update_attributes(params[:interactividad])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_interactividad_path(@interactividad)
    else
      render :action => "interactividad_form"
    end
    rescue
      redirect_to edit_interactividad_path(@interactividad)
  end

  def destroy
    @interactividad = Interactividad.find(params[:id])
    @interactividad.destroy
    respond_to do |format|
      format.html { redirect_to(interactividades_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['actaaprobacionobra'].include?(action_name)
      "atencion"
    elsif['informeoperador','informefinanciero','informeactualizacion','informepersonal','informecomuna','informeconcepto','informeseguimiento'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

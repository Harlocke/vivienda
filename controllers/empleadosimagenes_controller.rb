class EmpleadosimagenesController < ApplicationController
  before_filter :require_user
#  layout :determine_layout
  before_filter :find_empleado_and_empleadosimagen, :except=>["aprobar","rechazar","download"]

  def index
    empleado   = Empleado.find(params[:empleado_id])
    @empleadosimagenes = empleado.empleadosimagenes.all
  end

  def new
    @empleadosimagen = Empleadosimagen.new
    @empleadosimagen.empleadostipo_id = params[:empleadostipo_id]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @empleadosimagen }
    end
  end

  def create
    @empleadosimagen = Empleadosimagen.new(params[:empleadosimagen])
    @empleadosimagen.empleado_id = @empleado.id
    @empleadosimagen.user_id = is_admin
    respond_to do |format|
      if @empleadosimagen.save
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to interventorias_path }
        #format.html { redirect_to edit_empleado_path(@empleado) }
        format.xml  { render :xml => @empleadosimagen, :status => :created, :location => @empleadosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empleadosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @empleadosimagen = Empleadosimagen.find(params[:id])
    respond_to do |format|
      if @empleadosimagen.update_attributes(params[:empleadosimagen])
        format.html { redirect_to empleado_empleadosimagenes_path(@empleado) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @empleadosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    empleadosimagen   = Empleadosimagen.find(params[:id])
    @empleado         = empleadosimagen.empleado
    @empleadosimagen  = Empleadosimagen.new
    empleadosimagen.destroy
    respond_to do |format|
      format.js { render :action => "empleadosimagenes" }
    end
  end
  
  def find_empleado_and_empleadosimagen
      @empleado = Empleado.find(params[:empleado_id])
      @empleadosimagen = Empleadosimagen.find(params[:id]) if params[:id]
  end

  def aprobar
    empleadosimagen   = Empleadosimagen.find(params[:id])
    empleadosimagen.estado = 'APROBADO'
    empleadosimagen.user_verifica = is_admin
    empleadosimagen.save
    redirect_to edit_empleado_path(:id=>empleadosimagen.empleado_id)
  end

  def download
    empleadosimagen   = Empleadosimagen.find(params[:id])
    data = open(empleadosimagen.empleado.url(:original, false)) 
    send_file empleadosimagen.empleado.url(:original, false), :type=>empleadosimagen.empleado_content_type, :disposition => "inline"
  end

  def rechazar
    empleadosimagen   = Empleadosimagen.find(params[:id])
    empleadosimagen.estado = 'RECHAZADO'
    empleadosimagen.user_verifica = is_admin
    empleadosimagen.save
    redirect_to edit_empleado_path(:id=>empleadosimagen.empleado_id)
  end

  private
  def determine_layout
    if ['rptdatos','rptdatosintegrantes'].include?(action_name)
      "informes"
    elsif ['indexc'].include?(action_name)
      "application"
    else
      "basico"
    end
  end
end
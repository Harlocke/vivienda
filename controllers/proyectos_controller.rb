class ProyectosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @proyectos = Proyecto.find(:all, :order => 'descripcion')
    @proyectosfichas = Proyectosficha.all
    @lotes = Lote.find(:all, :order=>"to_number(consecutivo_lote)")
  end

  def buscar
    @proyectosfichas = Proyectosficha.all
    respond_to do |format|
       format.xls
    end
  end

  def new
    @proyecto = Proyecto.new
    render :action => "proyecto_form"
  end

  def edit
    @proyecto = Proyecto.find(params[:id])
    @proyectoscopropiedad = Proyectoscopropiedad.new
    @proyectoscopdocumento = Proyectoscopdocumento.new
    @proyectosdocumento = Proyectosdocumento.new
    @proyectosfactibilidad = Proyectosfactibilidad.new
    respond_to do |format|
      format.html { render :action => "proyecto_form" }
    end
  end

  def ver
    @proyecto = Proyecto.find(params[:id])
  end

  def create
    @proyecto = Proyecto.new(params[:proyecto])
    if @proyecto.save
      flash[:notice] = "Creado con Exito."
      redirect_to edit_proyecto_path(@proyecto)
    else
      @proyectoscopropiedad = Proyectoscopropiedad.new
      @proyectoscopdocumento = Proyectoscopdocumento.new
      @proyectosdocumento = Proyectosdocumento.new
      @proyectosfactibilidad = Proyectosfactibilidad.new
      render :action => "proyecto_form"
     end
  end

  def update
    @proyecto = Proyecto.find(params[:id])
    if @proyecto.update_attributes(params[:proyecto])
     flash[:notice] = "Actualizado con Exito."
      redirect_to edit_proyecto_path(@proyecto)
    else
      @proyectoscopropiedad = Proyectoscopropiedad.new
      @proyectoscopdocumento = Proyectoscopdocumento.new
      @proyectosdocumento = Proyectosdocumento.new
      @proyectosfactibilidad = Proyectosfactibilidad.new
      render :action => "proyecto_form"
    end
    rescue
      redirect_to edit_proyecto_path(@proyecto)
  end

  def informedetallado
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_CopropiedadDetallado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @proyectos = Proyecto.find(:all, :order=>"id asc")
  end

  def destroy
    @proyecto = Proyecto.find(params[:id])
    @proyecto.destroy
    respond_to do |format|
      format.html { redirect_to(proyectos_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['visualizar','ver'].include?(action_name)
      "atencion"
    elsif['informeconsolidado','informedetallado','informeconsolidado2'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end
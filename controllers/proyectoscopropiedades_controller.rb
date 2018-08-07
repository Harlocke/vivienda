class ProyectoscopropiedadesController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    proyecto   = Cliente.find(params[:proyecto_id])
    @proyectoscopropiedades = proyecto.proyectoscopropiedades.all
  end

  def new
    proyectoid = params[:proyectoid]
    @proyectoscopropiedad = Proyectoscopropiedad.new
    @proyectoscopropiedad.proyecto_id = proyectoid
    render :action => "proyectoscopropiedad_form"
  end

  def edit
    @proyectoscopropiedad  = Proyectoscopropiedad.find(params[:id])
    @proyectoscopcomite = Proyectoscopcomite.new
    @proyectoscopbloque = Proyectoscopbloque.new
    @proyectoscopnota = Proyectoscopnota.new
    respond_to do |format|
      format.html { render :action => "proyectoscopropiedad_form" }
    end
  end

  def visualizar
    @proyectoscopropiedad = Proyectoscopropiedad.find(params[:id])
  end

  def ver
    @proyectoscopropiedad = Proyectoscopropiedad.find(params[:id])
  end

  def informedetallado
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_CopropiedadesDetallado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @proyectoscopropiedades = Proyectoscopropiedad.find(:all, :order=>"id asc")
  end

  def create
    @proyectoscopropiedad = Proyectoscopropiedad.new(params[:proyectoscopropiedad])
    @proyectoscopropiedad.user_id = is_admin
    if @proyectoscopropiedad.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_proyectoscopropiedad_path(@proyectoscopropiedad)
    else
      render :action => "proyectoscopropiedad_form"
    end
  end

  def update
    @proyectoscopropiedad = Proyectoscopropiedad.find(params[:id])
#    params[:proyectoscopropiedad][:user_actualiza] = is_admin
    if @proyectoscopropiedad.update_attributes(params[:proyectoscopropiedad])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_proyectoscopropiedad_path(@proyectoscopropiedad)
    else
      @proyectoscopcomite = Proyectoscopcomite.new
      @proyectoscopbloque = Proyectoscopbloque.new
      @proyectoscopnota = Proyectoscopnota.new
      render :action => "proyectoscopropiedad_form"
    end
    rescue
      redirect_to edit_proyectoscopropiedad_path(@proyectoscopropiedad)
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
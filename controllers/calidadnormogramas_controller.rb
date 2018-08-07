class CalidadnormogramasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @calidadnormogramas = Calidadnormograma.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calidadnormogramas }
    end
  end

  def new
    @calidadnormograma = Calidadnormograma.new
    @calidadnormogramasproceso  = Calidadnormogramasproceso.new
    @calidadnormogramasimagen  = Calidadnormogramasimagen.new
    render :action => "calidadnormograma_form"
  end

  def buscarx
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="informeasesorias_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @capacitaciones = Capacitacion.search(
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal],
                             params[:ubicacion][:user_id],
                             params[:ubicacion][:region_id])
    if @capacitaciones.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to calidadnormogramas_path
    end
  end

  def create
    @calidadnormograma = Calidadnormograma.new(params[:calidadnormograma])
    @calidadnormograma.user_id = is_admin
    @calidadnormograma.user_actualiza = is_admin
    if @calidadnormograma.save
      flash[:notice] = "Calidadnormograma Creado con Exito."
      redirect_to edit_calidadnormograma_path(@calidadnormograma)
    else
      flash[:warning] = "Problemas con la creacion del registro."
      render :action => "calidadnormograma_form"
     end
  end

  def show
    @calidadnormograma = Calidadnormograma.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calidadnormograma }
    end
  end

  def edit
    @calidadnormograma = Calidadnormograma.find(params[:id])
    @calidadnormogramasproceso = Calidadnormogramasproceso.new
    @calidadnormogramasimagen  = Calidadnormogramasimagen.new
    respond_to do |format|
      format.html { render :action => "calidadnormograma_form" }
    end
  end

  def update
    @calidadnormograma = Calidadnormograma.find(params[:id])
    @calidadnormograma.user_actualiza = is_admin
    if @calidadnormograma.update_attributes(params[:calidadnormograma])
      flash[:notice] = "Calidadnormograma actualizado correctamente."
      redirect_to edit_calidadnormograma_path(@calidadnormograma)
    else
      @calidadnormogramasproceso  = Calidadnormogramasproceso.new
      @calidadnormogramasimagen  = Calidadnormogramasimagen.new
      render :action => "calidadnormograma_form"
    end
    rescue
    redirect_to edit_calidadnormograma_path(@calidadnormograma)
  end

  private
  def determine_layout
    if ['buscarx'].include?(action_name)
      "informes"
    else
      "application"
    end
  end
end
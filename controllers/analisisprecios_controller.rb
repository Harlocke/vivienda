class AnalisispreciosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @analisisprecios = Analisisprecio.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @analisisprecios }
    end
  end

  def listar
    @analisisprecios = Analisisprecio.find(:all, :conditions => [" descripcion LIKE upper('%%#{params[:search]}%%')"], :limit=>10)
  end

  def buscar
    @analisisprecios  = Analisisprecio.buscar(params[:obra])
    @obra = params[:obra]
    if @analisisprecios.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_analisisprecios_path
    elsif @analisisprecios.count == 1
      redirect_to edit_analisisprecio_path(@analisisprecios)
    else
      respond_to do |format|
         format.html
      end
    end
  end

  def unificar
    @obra = params[:obra]
  end

  def show
    @analisisprecio = Analisisprecio.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @analisisprecio }
    end
  end

  def mostrar
    @analisisprecio = Analisisprecio.find(params[:id])
  end

  def new
    @analisisprecio = Analisisprecio.new
    render :action => "analisisprecio_form"
  end

  def edit
    @analisisprecio = Analisisprecio.find(params[:id])
    @analisisprecioselemento = Analisisprecioselemento.new
    respond_to do |format|
      format.html { render :action => "analisisprecio_form" }
    end
  end

  def create
    @analisisprecio = Analisisprecio.new(params[:analisisprecio])
    @analisisprecio.user_id = is_admin
    if @analisisprecio.save
      flash[:notice] = "Registro Creado con Exito."
      redirect_to edit_analisisprecio_path(@analisisprecio)
    else
      @analisisprecioelemento = Analisisprecioselemento.new
      render :action => "analisisprecio_form"
    end
#    rescue
#    flash[:warning] = "Debe digitar datos del grupo"
#    render :action => "analisisprecio_form"
  end

  def update
    @analisisprecio = Analisisprecio.find(params[:id])
    @analisisprecio.user_actualiza = is_admin
    if @analisisprecio.update_attributes(params[:analisisprecio])
      flash[:notice] = "Registro Actualizado con Exito."
      redirect_to edit_analisisprecio_path(@analisisprecio)
    else
      @analisisprecioelemento = Analisisprecioselemento.new
      render :action => "analisisprecio_form"
    end
  end

  def destroy
    @analisisprecio = Analisisprecio.find(params[:id])
    @analisisprecio.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro ha sido eliminado con Exito."
        redirect_to busqueda_analisisprecios_path
      }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['mostrar'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

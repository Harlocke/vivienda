class GruposController < ApplicationController
  before_filter :require_user
#  layout :determine_layout

  def index
    @grupos = Grupo.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grupos }
    end
  end

  def show
    @grupo = Grupo.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grupo }
    end
  end

  def listar
      @grupos = Grupo.find(:all, :conditions => [' autobuscar LIKE ?', "%#{params[:search]}%"])
  end

  def new
    @grupo = Grupo.new
    render :action => "grupo_form"
  end

  def edit
    @grupo = Grupo.find(params[:id])
    @gruposactividad = Gruposactividad.new
    respond_to do |format|
      format.html { render :action => "grupo_form" }
    end
  end

  def create
    @grupo = Grupo.new(params[:grupo])
    @grupo.user_id = is_admin
    if @grupo.save
      flash[:notice] = "Registro Creado con Exito."
      redirect_to edit_grupo_path(@grupo)
    else
      @gruposactividad = Gruposactividad.new
      render :action => "grupo_form"
    end
  end

  def update
    @grupo = Grupo.find(params[:id])
    if @grupo.update_attributes(params[:grupo])
      flash[:notice] = "Registro Actualizado con Exito."
      #@grupo.actualizavaloresitems
      redirect_to edit_grupo_path(@grupo)
    else
      @gruposactividad = Gruposactividad.new
      render :action => "grupo_form"
    end
  end

  def destroy
    @grupo = Grupo.find(params[:id])
    @grupo.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro ha sido eliminado con Exito."
        redirect_to busqueda_grupos_path
      }
      format.xml  { head :ok }
    end
  end
end

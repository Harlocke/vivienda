class CorrespondenciasremitentesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @correspondenciasremitentes = Correspondenciasremitente.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @correspondenciasremitentes }
    end
  end

  def new
    @correspondenciasremitente = Correspondenciasremitente.new
    render :action => "correspondenciasremitente_form"
  end

  def listar
      @correspondenciasremitentes = Correspondenciasremitente.find(:all, :conditions => [" autobuscar like '%%#{params[:search]}%%'"])
      #@personas = Persona.find(:all, :conditions => [' autobuscar LIKE ?', "%#{params[:search]}%"])
  end

  def edit
    @correspondenciasremitente = Correspondenciasremitente.find(params[:id])
    respond_to do |format|
      format.html { render :action => "correspondenciasremitente_form" }
    end
  end

  def create
    @correspondenciasremitente = Correspondenciasremitente.new(params[:correspondenciasremitente])
    if @correspondenciasremitente.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_correspondenciasremitente_path(@correspondenciasremitente)
    else
      render :action => "correspondenciasremitente_form"
    end
  end

  def update
    @correspondenciasremitente = Correspondenciasremitente.find(params[:id])
      if @correspondenciasremitente.update_attributes(params[:correspondenciasremitente])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_correspondenciasremitente_path(@correspondenciasremitente)
      else
        @correspondenciasremitentesprestamo= Correspondenciasremitentesprestamo.new
        render :action => "correspondenciasremitente_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_correspondenciasremitente_path(@correspondenciasremitente)
  end

  def destroy
    @correspondenciasremitente = Correspondenciasremitente.find(params[:id])
    @correspondenciasremitente.destroy
    respond_to do |format|
       format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_correspondenciasremitentes_path
        }
      format.xml  { head :ok }
    end
  end

  def show
    persona   = Persona.find(params[:correspondenciasremitente_id])
    @correspondenciasremitentes = persona.correspondenciasremitentes.all
  end

    def new2
    @correspondenciasremitente = Correspondenciasremitente.new
  end

  def edit2
    @correspondenciasremitente = Correspondenciasremitente.find(params[:id])
    respond_to do |format|
      format.html { render :action => "edit2" }
    end
  end

  def create2
    @correspondenciasremitente = Correspondenciasremitente.new(params[:correspondenciasremitente])
    if @correspondenciasremitente.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit2_correspondenciasremitente_path(@correspondenciasremitente)
    else
      render :action => "new2"
     end
  end

  def update2
    @correspondenciasremitente = Correspondenciasremitente.find(params[:id])
    if @correspondenciasremitente.update_attributes(params[:correspondenciasremitente])
      flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit2_correspondenciasremitente_path(@correspondenciasremitente)
    else
      render :action => "edit2"
    end
    rescue
      redirect_to edit2_correspondenciasremitente_path(@correspondenciasremitente)
  end

  private
  def determine_layout
    if ['new2','create2','edit2','update2'].include?(action_name)
      "new2"
    else
      "application"
    end
  end

end

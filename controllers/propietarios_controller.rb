class PropietariosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @propietarios = Propietario.search(params[:search], params[:page])
    if @propietarios.count == 0
      flash[:notice] = "No se encontro ningun registro."
    elsif @propietarios.count == 1
      redirect_to edit_propietario_path(@propietarios)

    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @propietarios }
      end
    end
  end

  def new
    @propietario = Propietario.new
    render :action => "propietario_form"
  end

  def listar
    @propietarios = Propietario.find(:all, :conditions => [" autobuscar like '%%#{is_replacespace(params[:search].upcase.to_s)}%%'"], :order=>"autobuscar")
  end

  def edit
    @viviendas = Ayudasvivienda.find(:all, :conditions => ["propietario_id = #{params[:id]}"])
    @propietario = Propietario.find(params[:id])
    respond_to do |format|
      format.html { render :action => "propietario_form" }
    end
  end

  def create
    @propietario = Propietario.new(params[:propietario])
    @propietario.user_id = is_admin
    if @propietario.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_propietario_path(@propietario)
    else
      render :action => "propietario_form"
    end
  end

  def update
    @propietario = Propietario.find(params[:id])
    @propietario.user_actualiza = is_admin
      if @propietario.update_attributes(params[:propietario])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_propietario_path(@propietario)
      else
        @propietariosprestamo= Propietariosprestamo.new
        render :action => "propietario_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_propietario_path(@propietario)
  end

  def destroy
    @propietario = Propietario.find(params[:id])
    @propietario.destroy
    respond_to do |format|
       format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_propietarios_path
        }
      format.xml  { head :ok }
    end
  end

  def show
    persona   = Persona.find(params[:propietario_id])
    @propietarios = persona.propietarios.all
  end

    def new2
    @propietario = Propietario.new
  end

  def edit2
    @propietario = Propietario.find(params[:id])
    respond_to do |format|
      format.html { render :action => "edit2" }
    end
  end

  def create2
    @propietario = Propietario.new(params[:propietario])
    if @propietario.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit2_propietario_path(@propietario)
    else
      render :action => "new2"
     end
  end

  def update2
    @propietario = Propietario.find(params[:id])
    if @propietario.update_attributes(params[:propietario])
      flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit2_propietario_path(@propietario)
    else
      render :action => "edit2"
    end
    rescue
      redirect_to edit2_propietario_path(@propietario)
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

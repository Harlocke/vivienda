class TitulacionesbarriosController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  

  def index
    @titulacionesbarrios = Titulacionesbarrio.find(:all, :order=>"descripcion")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @titulacionesbarrios }
    end
  end

  def show
    @titulacionesbarrio = Titulacionesbarrio.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @titulacionesbarrio }
    end
  end

  def new
    @titulacionesbarrio = Titulacionesbarrio.new
    render :action => "titulacionesbarrio_form"
  end

  def edit
    @titulacionesbarrio = Titulacionesbarrio.find(params[:id])
    respond_to do |format|
      format.html { render :action => "titulacionesbarrio_form" }
    end
  end

  def create
    @titulacionesbarrio = Titulacionesbarrio.new(params[:titulacionesbarrio])
    if @titulacionesbarrio.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_titulacionesbarrio_path(@titulacionesbarrio)
    else
      render :action => "titulacionesbarrio_form"
    end
  end

  def update
    @titulacionesbarrio = Titulacionesbarrio.find(params[:id])
    if @titulacionesbarrio.update_attributes(params[:titulacionesbarrio])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_titulacionesbarrio_path(@titulacionesbarrio)
    else
      render :action => "titulacionesbarrio_form"
    end
    rescue
      redirect_to edit_titulacionesbarrio_path(@titulacionesbarrio)
  end

  def destroy
    @titulacionesbarrio = Titulacionesbarrio.find(params[:id])
    @titulacionesbarrio.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_titulacionesbarrios_path
        }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['import','csv_import','pendientesentrega','notificapendiente','asignar','stiker','rotulo','vigentesentrega'].include?(action_name)
      "atencion"
    else
      "new2"
    end
  end
end

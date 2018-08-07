class EncuestasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    #@encuestas = Encuesta.find(:all)
  end

  def show
    @encuesta = Encuesta.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @encuesta }
    end
  end

  def new
    @encuesta = Encuesta.new
    render :action => "encuesta_form"
  end

  def edit
    @encuesta = Encuesta.find(params[:id])
    #@encuestasactividad = Encuestasactividad.new
    respond_to do |format|
      format.html { render :action => "encuesta_form" }
    end
  end

  def create
    @encuesta = Encuesta.new(params[:encuesta])
    @encuesta.user_id = is_admin
    if @encuesta.save
      flash[:notice] = "Gracias, la encuesta ha sido registrada con exito."
      redirect_to menus_path
    else
      #@encuestasactividad = Encuestasactividad.new
      render :action => "encuesta_form"
    end
  end

  def update
    @encuesta = Encuesta.find(params[:id])
    if @encuesta.update_attributes(params[:encuesta])
      flash[:notice] = "Registro Actualizado con Exito."
      #@encuesta.actualizavaloresitems
      redirect_to edit_encuesta_path(@encuesta)
    else
      render :action => "encuesta_form"
    end
  end

  def destroy
    @encuesta = Encuesta.find(params[:id])
    @encuesta.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro ha sido eliminado con Exito."
        redirect_to busqueda_encuestas_path
      }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['new'].include?(action_name)
      "boletin"
    else
      "application"
    end
  end
end

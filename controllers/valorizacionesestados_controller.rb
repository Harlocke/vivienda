class ValorizacionesestadosController < ApplicationController
before_filter :require_user
#layout :determine_layout
  def index
    @valorizacionesestados = Valorizacionesestado.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @valorizacionesestados }
    end
  end

  def show
    @valorizacionesestado = Valorizacionesestado.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @valorizacionesestado }
    end
  end

  def new
    @valorizacionesestados = Valorizacionesestado.all
    if @valorizacionesestados.length == 0
      @valorizacionesestado = Valorizacionesestado.new
    else
      @valorizacionesestado = Valorizacionesestado.new
      render :action => "valorizacionesestado_form"
    end
  end

  def edit
    @valorizacionesestado = Valorizacionesestado.find(params[:id])
    @valorizacionesestadosnota = Valorizacionesestadosnota.new
    respond_to do |format|
      format.html { render :action => "valorizacionesestado_form" }
    end
  end

  def create
    @valorizacionesestado = Valorizacionesestado.new(params[:valorizacionesestado])
    if @valorizacionesestado.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_valorizacionesestado_path(@valorizacionesestado)
    else
      render :action => "valorizacionesestado_form"
    end
  end

  def update
    @valorizacionesestado = Valorizacionesestado.find(params[:id])
    if @valorizacionesestado.update_attributes(params[:valorizacionesestado])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_valorizacionesestado_path(@valorizacionesestado)
    else
      @valorizacionesestadosnota = Valorizacionesestadosnota.new
      render :action => "valorizacionesestado_form"
    end
    rescue
      redirect_to edit_valorizacionesestado_path(@valorizacionesestado)
  end

  def destroy
    @valorizacionesestado = Valorizacionesestado.find(params[:id])
    @valorizacionesestado.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to valorizacionesestados_path
        }
      format.xml  { head :ok }
    end
  end

#  private
#  def determine_layout
#    if ['new','edit'].include?(action_name)
#      "new2"
#    else
#      "application"
#    end
#  end
end
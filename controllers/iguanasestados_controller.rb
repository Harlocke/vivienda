class IguanasestadosController < ApplicationController
before_filter :require_user
#layout :determine_layout
  def index
    @iguanasestados = Iguanasestado.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iguanasestados }
    end
  end

  def show
    @iguanasestado = Iguanasestado.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @iguanasestado }
    end
  end

  def new
    @iguanasestados = Iguanasestado.all
    if @iguanasestados.length == 0
      @iguanasestado = Iguanasestado.new
    else
      @iguanasestado = Iguanasestado.new
      render :action => "iguanasestado_form"
    end
  end

  def edit
    @iguanasestado = Iguanasestado.find(params[:id])
    @iguanasestadosnota = Iguanasestadosnota.new
    respond_to do |format|
      format.html { render :action => "iguanasestado_form" }
    end
  end

  def create
    @iguanasestado = Iguanasestado.new(params[:iguanasestado])
    if @iguanasestado.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_iguanasestado_path(@iguanasestado)
    else
      render :action => "iguanasestado_form"
    end
  end

  def update
    @iguanasestado = Iguanasestado.find(params[:id])
    if @iguanasestado.update_attributes(params[:iguanasestado])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_iguanasestado_path(@iguanasestado)
    else
      @iguanasestadosnota = Iguanasestadosnota.new
      render :action => "iguanasestado_form"
    end
    rescue
      redirect_to edit_iguanasestado_path(@iguanasestado)
  end

  def destroy
    @iguanasestado = Iguanasestado.find(params[:id])
    @iguanasestado.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to iguanasestados_path
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
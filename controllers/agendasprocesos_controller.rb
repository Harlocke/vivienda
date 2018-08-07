class AgendasprocesosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
	@agendasprocesos = Agendasproceso.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agendasprocesos }
    end
  end

  def new
    @agendasproceso = Agendasproceso.new
    @agendasproceso.etapa = '1'
    render :action => "agendasproceso_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update agendasprocesos set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    @agendasproceso = Agendasproceso.find(params[:id])
    if @agendasproceso.etapa.to_s == "1"
      @agendasprocesosuser = Agendasprocesosuser.new
    elsif @agendasproceso.etapa.to_s == "2"
      @agendasparametro = Agendasparametro.new
    elsif @agendasproceso.etapa.to_s == "3"
      @agendasfecha = Agendasfecha.new
    elsif @agendasproceso.etapa.to_s == "4"
      @agendasrango = Agendasrango.new
    end    
    respond_to do |format|
      format.html { render :action => "agendasproceso_form" }
    end
  end

  def create
    @agendasproceso = Agendasproceso.new(params[:agendasproceso])
    @agendasproceso.etapa = "1"
    #@agendasproceso.user_id = is_admin
    if @agendasproceso.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_agendasproceso_path(@agendasproceso)
    else
      render :action => "agendasproceso_form"
    end
  end

  def update
    @agendasproceso = Agendasproceso.find(params[:id])
    #@agendasproceso.user_id = is_admin
    if @agendasproceso.update_attributes(params[:agendasproceso])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_agendasproceso_path(@agendasproceso)
    else
      @agendasfecha = Agendasfecha.new
      @agendasprocesosuser = Agendasprocesosuser.new
      @agendasparametro = Agendasparametro.new
      @agendasrango = Agendasrango.new
      render :action => "agendasproceso_form"
    end
  rescue
    flash[:notice] = "Existen inconsistencias. Verifique!!!"
    redirect_to edit_agendasproceso_path(@agendasproceso)
  end
  
  def destroy
    @agendasproceso = Agendasproceso.find(params[:id])
    @agendasproceso.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_agendasprocesos_path
      }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['visualizar','buscarx'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
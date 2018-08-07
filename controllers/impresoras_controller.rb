class ImpresorasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @impresoras = Impresora.all  
  end

 
  def new
    @impresora = Impresora.new
    @impresora.etapa = '1'
    render :action => "impresora_form"
  end

  def edit
    @impresora = Impresora.find(params[:id])
    @impresorasconsumo = Impresorasconsumo.new
      respond_to do |format|
      format.html { render :action => "impresora_form" }
    end
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update impresoras set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    @impresora = Impresora.find(params[:id])
    if @impresora.etapa.to_s == "2"
      @impresorasreporte = Impresorasreporte.new
    end
    #@tiposelementos = Tiposelemento.all
    respond_to do |format|
      format.html { render :action => "impresora_form" }
    end
  end

  def create
    @impresora = Impresora.new(params[:impresora])

    if @impresora.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_impresora_path(@impresora)
    else
      render :action => "impresora_form"
    end
  end

  def update
    @impresora = Impresora.find(params[:id])
    #@impresora.user_id = is_admin
    if @impresora.update_attributes(params[:impresora])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_impresora_path(@impresora)
    else
      @impresorasconsumo = Impresorasconsumo.new
      render :action => "impresora_form"
    end
  rescue
    flash[:notice] = "Existen inconsistencias. Verifique!!!"
    redirect_to edit_impresora_path(@impresora)
  end

  
  def destroy
    @impresora = Impresora.find(params[:id])
    @impresora.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_impresoras_path
      }
      format.xml  { head :ok }
    end
  end

#  def show
#    persona   = Persona.find(params[:impresora_id])
#    @impresoras = persona.impresoras.all
#  end

  private
  def determine_layout
    if ['visualizar','buscarx'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
class ArchivosdocumentosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @archivosdocumentos = Archivosdocumento.find(:all, :order=>"descripcion")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @archivosdocumentos }
    end
  end

  def new
    @archivosdocumento = Archivosdocumento.new
    render :action => "archivosdocumento_form"
  end

  def edit
    @archivosdocumento = Archivosdocumento.find(params[:id])
    respond_to do |format|
      format.html { render :action => "archivosdocumento_form" }
    end
  end

  def create
    @archivosdocumento = Archivosdocumento.new(params[:archivosdocumento])
    if @archivosdocumento.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_archivosdocumento_path(@archivosdocumento)
    else
      render :action => "archivosdocumento_form"
    end
  end

  def update
    @archivosdocumento = Archivosdocumento.find(params[:id])
      if @archivosdocumento.update_attributes(params[:archivosdocumento])
        @archivosdocumento.actualizacion(is_admin)
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_archivosdocumento_path(@archivosdocumento)
      else
        render :action => "archivosdocumento_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_archivosdocumento_path(@archivosdocumento)
  end

  def destroy
    @archivosdocumento = Archivosdocumento.find(params[:id])
    @archivosdocumento.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to archivosdocumentos_path
      }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['import','csv_import','pendientesentrega','notificapendiente','asignar','stiker','rotulo','vigentesentrega'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
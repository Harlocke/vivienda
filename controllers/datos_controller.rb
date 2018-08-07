class DatosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    @datos = Dato.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @datos }
    end
  end

  def buscar
    @datos = Dato.find_all_by_identificacion(params[:identificacion])
    if @datos.count == 1
      redirect_to edit_dato_path(@datos)
    else
      flash[:notice] = "La identificacion no se encuentra registrada."
      redirect_to datos_path
    end
  end


  def new
    @dato = Dato.new
    render :action => "dato_form"
  end

  def edit
    @dato = Dato.find(params[:id])
    respond_to do |format|
      format.html { render :action => "dato_form" }
    end
  end

  def create
    @dato = Dato.new(params[:dato])
        if @dato.save
          flash[:notice] = "El registro ha sido registrado con Exito."
          redirect_to edit_dato_path(@dato)
        else
          render :action => "dato_form"
        end
  end

  def update
    @dato = Dato.find(params[:id])
      if @dato.update_attributes(params[:dato])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_dato_path(@dato)
      else
        render :action => "dato_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_dato_path(@dato)
  end

  def destroy
    @dato = Dato.find(params[:id])
    @dato.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to datos_path
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
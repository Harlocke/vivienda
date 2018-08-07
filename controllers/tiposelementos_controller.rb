class TiposelementosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @tiposelementos = Tiposelemento.find(:all, :order=>"descripcion")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposelementos }
    end
  end

  def new
    @tiposelemento = Tiposelemento.new
    render :action => "tiposelemento_form"
  end

  def edit
    @tiposelemento = Tiposelemento.find(params[:id])
    respond_to do |format|
      format.html { render :action => "tiposelemento_form" }
    end
  end

  def create
    @tiposelemento = Tiposelemento.new(params[:tiposelemento])
    if @tiposelemento.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_tiposelemento_path(@tiposelemento)
    else
      render :action => "tiposelemento_form"
    end
  end

  def update
    @tiposelemento = Tiposelemento.find(params[:id])
      if @tiposelemento.update_attributes(params[:tiposelemento])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_tiposelemento_path(@tiposelemento)
      else
        render :action => "tiposelemento_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_tiposelemento_path(@tiposelemento)
  end

  def destroy
    @tiposelemento = Tiposelemento.find(params[:id])
    @tiposelemento.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to tiposelementos_path
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
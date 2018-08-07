class InventarioselementosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @inventarioselementos = Inventarioselemento.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inventarioselementos }
    end
  end

  def new
    @inventarioselemento = Inventarioselemento.new
    render :action => "inventarioselemento_form"
  end

  def edit
    @inventarioselemento = Inventarioselemento.find(params[:id])
    respond_to do |format|
      format.html { render :action => "inventarioselemento_form" }
    end
  end

  def create
    @inventarioselemento = Inventarioselemento.new(params[:inventarioselemento])
    if @inventarioselemento.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_inventarioselemento_path(@inventarioselemento)
    else
      render :action => "inventarioselemento_form"
    end
  end

  def update
    @inventarioselemento = Inventarioselemento.find(params[:id])
    if @inventarioselemento.update_attributes(params[:inventarioselemento])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_inventarioselemento_path(@inventarioselemento)
    else
      render :action => "inventarioselemento_form"
    end
    rescue
      redirect_to edit_inventarioselemento_path(@inventarioselemento)
  end

  def destroy
    @inventarioselemento = Inventarioselemento.find(params[:id])
    @inventarioselemento.destroy
    respond_to do |format|
      format.html { redirect_to(inventarioselementos_url) }
      format.xml  { head :ok }
    end
  end
end
class FiduciascontencargosController < ApplicationController
  before_filter :require_user

 def index
    @fiduciascontencargos = Fiduciascontencargo.all
  end

  def new
    @fiduciascontencargo = Fiduciascontencargo.new
    @fiduciascontencargo.fiduciascontrato_id = params[:fiduciascontrato_id]
    render :action => "fiduciascontencargo_form"
  end

  def edit
    @fiduciascontencargo = Fiduciascontencargo.find(params[:id])
    respond_to do |format|
      format.html { render :action => "fiduciascontencargo_form" }
    end
  end

  def create
    @fiduciascontencargo = Fiduciascontencargo.new(params[:fiduciascontencargo])
    @fiduciascontencargo.user_id = is_admin
    if @fiduciascontencargo.save
      flash[:notice] = "Creado con Exito."
      redirect_to edit_fiduciascontencargo_path(@fiduciascontencargo)
    else
      render :action => "fiduciascontencargo_form"
     end
  end

  def update
    @fiduciascontencargo = Fiduciascontencargo.find(params[:id])
    if @fiduciascontencargo.update_attributes(params[:fiduciascontencargo])
     flash[:notice] = "Actualizado con Exito."
      redirect_to edit_fiduciascontencargo_path(@fiduciascontencargo)
    else
      render :action => "fiduciascontencargo_form"
    end
    rescue
      redirect_to edit_fiduciascontencargo_path(@fiduciascontencargo)
  end

  def destroy
    @fiduciascontencargo = Fiduciascontencargo.find(params[:id])
    @fiduciascontencargo.destroy
    respond_to do |format|
      format.html { redirect_to(fiduciascontencargos_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['visualizar'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

class FiduciascontratosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    fiducia = Fiducia.find(params[:fiducia_id])
    @fiduciascontratos = fiducia.fiduciascontratos.all 
  end


  def edit
    @fiduciascontrato  = Fiduciascontrato.find(params[:id], :include => "fiducia")
    @fiducia  = @fiduciascontrato.fiducia
    respond_to do |format|
      format.js { render :action => "edit_fiduciascontrato" }
    end
  end

  def create
    @fiducia  = Fiducia.find(params[:fiducia_id])
    @fiduciascontrato = Fiduciascontrato.new(params[:fiduciascontrato])
    @fiduciascontrato.user_id = is_admin
       if @fiduciascontrato.valid?
          @fiducia.fiduciascontratos << @fiduciascontrato
          @fiducia.save
          @fiduciascontrato = Fiduciascontrato.new
          flash[:fiduciascontrato] = "Creado con exito"
        else
          flash[:fiduciascontrato] = "Se produjo un error al guardar el registro"
        end
    respond_to do |format|
       format.js { render :action => "fiduciascontratos" }
    end
  end

  def update
    @fiduciascontrato        = Fiduciascontrato.new
    fiduciascontrato         = Fiduciascontrato.find(params[:id])
    @fiducia        = fiduciascontrato.fiducia
    ok = fiduciascontrato.update_attributes(params[:fiduciascontrato])
    flash[:fiduciascontrato] = ok ? "Actualizado con Exito " : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "fiduciascontratos" }
    end
  end

  def destroy
    fiduciascontrato   = Fiduciascontrato.find(params[:id])
    @fiducia  = fiduciascontrato.fiducia
    @fiduciascontrato  = Fiduciascontrato.new
    fiduciascontrato.destroy
    flash[:fiduciascontrato] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "fiduciascontratos" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end

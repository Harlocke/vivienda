class FiduciasnotasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    fiducia = Fiducia.find(params[:fiducia_id])
    @fiduciasnotas = fiducia.fiduciasnotas.all 
  end

  def edit
    @fiduciasnota  = Fiduciasnota.find(params[:id], :include => "fiducia")
    @fiducia  = @fiduciasnota.fiducia
    respond_to do |format|
      format.js { render :action => "edit_fiduciasnota" }
    end
  end

  def create
    @fiducia  = Fiducia.find(params[:fiducia_id])
    @fiduciasnota = Fiduciasnota.new(params[:fiduciasnota])
    @fiduciasnota.user_id = is_admin
       if @fiduciasnota.valid?
          @fiducia.fiduciasnotas << @fiduciasnota
          @fiducia.save
          @fiduciasnota = Fiduciasnota.new
          flash[:fiduciasnota] = "Creado con exito"
        else
          flash[:fiduciasnota] = "Se produjo un error al guardar el registro"
        end
    respond_to do |format|
       format.js { render :action => "fiduciasnotas" }
    end
  end

  def update
    @fiduciasnota        = Fiduciasnota.new
    fiduciasnota         = Fiduciasnota.find(params[:id])
    @fiducia        = fiduciasnota.fiducia
    ok = fiduciasnota.update_attributes(params[:fiduciasnota])
    flash[:fiduciasnota] = ok ? "Actualizado con Exito " : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "fiduciasnotas" }
    end
  end

  def destroy
    fiduciasnota   = Fiduciasnota.find(params[:id])
    @fiducia  = fiduciasnota.fiducia
    @fiduciasnota  = Fiduciasnota.new
    fiduciasnota.destroy
    flash[:fiduciasnota] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "fiduciasnotas" }
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

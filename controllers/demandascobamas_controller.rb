class DemandascobamasController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    demanda   = Demanda.find(params[:demanda_id])
    @demandascobamas = demanda.demandascobamas.all
  end

  def edit
    @demandascobama  = Demandascobama.find(params[:id], :include => "demanda")
    @demanda  = @demandascobama.demanda
    respond_to do |format|
      format.js { render :action => "edit_demandascobama" }
    end
  end

  def informe
    @demandascobama = Demandascobama.find(params[:id])
  end

  def create
    @demanda  = Demanda.find(params[:demanda_id])
    @demandascobama = Demandascobama.new(params[:demandascobama])
      if @demandascobama.valid?
        @demanda.demandascobamas << @demandascobama
        @demanda.save
        @demandascobama = Demandascobama.new
      else
        flash[:demandascobama] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "demandascobamas" }
      end
  end

  def update
    @demandascobama        = Demandascobama.new
    demandascobama         = Demandascobama.find(params[:id])
    @demanda        = demandascobama.demanda
    ok = demandascobama.update_attributes(params[:demandascobama])
    flash[:demandascobama] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "demandascobamas" }
    end
  end

  def destroy
    demandascobama   = Demandascobama.find(params[:id])
    @demanda  = demandascobama.demanda
    @demandascobama  = Demandascobama.new
    demandascobama.respaldo(is_admin)
    demandascobama.destroy
    respond_to do |format|
      format.js { render :action => "demandascobamas" }
    end
  end

  def show
    cobama   = Persona.find(params[:cobama_id])
    @demandascobamas = cobama.demandascobamas.all
  end

  private
  def determine_layout
    if ['informecruce','informe'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
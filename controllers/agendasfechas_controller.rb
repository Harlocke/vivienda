class AgendasfechasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    agendasproceso   = Agendasproceso.find(params[:agendasproceso_id])
    @agendasfechas = agendasproceso.agendasfechas.all
  end

 def edit
    @agendasfecha  = Agendasfecha.find(params[:id], :include => "agendasproceso")
    @agendasproceso  = @agendasfecha.agendasproceso
    respond_to do |format|
      format.js { render :action => "edit_agendasfecha" }
    end
  end

  def create
    @agendasproceso  = Agendasproceso.find(params[:agendasproceso_id])
    @agendasfecha = Agendasfecha.new(params[:agendasfecha])
    #@agendasfecha.user_registra = is_admin
     if @agendasfecha.valid?
        @agendasproceso.agendasfechas << @agendasfecha
        @agendasproceso.save
        @agendasfecha = Agendasfecha.new
        flash[:agendasfecha] = "Creado con exito"
      else
        flash[:agendasfecha] = "Se produjo un error al guardar el registro"
      end
    respond_to do |format|
       format.js { render :action => "agendasfechas" }
    end
  end

def update
    @agendasfecha        = Agendasfecha.new
    agendasfecha         = Agendasfecha.find(params[:id])
    #agendasfecha.user_id = is_admin
    @agendasproceso        = agendasfecha.agendasproceso
    ok = agendasfecha.update_attributes(params[:agendasfecha])
    flash[:agendasfecha] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "agendasfechas" }
    end
  end

  def destroy
    agendasfecha   = Agendasfecha.find(params[:id])
    @agendasproceso  = agendasfecha.agendasproceso
    @agendasfecha  = Agendasfecha.new
    agendasfecha.destroy
    flash[:agendasfecha] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "agendasfechas" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application" 
    end
  end
end

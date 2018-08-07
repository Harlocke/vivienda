class AgendasrangosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    agendasproceso   = Agendasproceso.find(params[:agendasproceso_id])
    @agendasrangos = agendasproceso.agendasrangos.all
  end

 def edit
    @agendasrango  = Agendasrango.find(params[:id], :include => "agendasproceso")
    @agendasproceso  = @agendasrango.agendasproceso
    respond_to do |format|
      format.js { render :action => "edit_agendasrango" }
    end
  end

  def create
    @agendasproceso  = Agendasproceso.find(params[:agendasproceso_id])
    @agendasrango = Agendasrango.new(params[:agendasrango])
    #@agendasrango.user_registra = is_admin
     if @agendasrango.valid?
        @agendasproceso.agendasrangos << @agendasrango
        @agendasproceso.save
        @agendasrango = Agendasrango.new
        flash[:agendasrango] = "Creado con exito"
      else
        flash[:agendasrango] = "Se produjo un error al guardar el registro"
      end
    respond_to do |format|
       format.js { render :action => "agendasrangos" }
    end
  end

def update
    @agendasrango        = Agendasrango.new
    agendasrango         = Agendasrango.find(params[:id])
    #agendasrango.user_id = is_admin
    @agendasproceso        = agendasrango.agendasproceso
    ok = agendasrango.update_attributes(params[:agendasrango])
    flash[:agendasrango] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "agendasrangos" }
    end
  end

  def destroy
    agendasrango   = Agendasrango.find(params[:id])
    @agendasproceso  = agendasrango.agendasproceso
    @agendasrango  = Agendasrango.new
    agendasrango.destroy
    flash[:agendasrango] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "agendasrangos" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application" 
    end
  end
end

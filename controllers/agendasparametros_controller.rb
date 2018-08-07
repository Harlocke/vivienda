class AgendasparametrosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    agendasproceso   = Agendasproceso.find(params[:agendasproceso_id])
    @agendasparametros = agendasproceso.agendasparametros.all
  end

 def edit
    @agendasparametro  = Agendasparametro.find(params[:id], :include => "agendasproceso")
    @agendasproceso  = @agendasparametro.agendasproceso
    respond_to do |format|
      format.js { render :action => "edit_agendasparametro" }
    end
  end

  def create
    @agendasproceso  = Agendasproceso.find(params[:agendasproceso_id])
    @agendasparametro = Agendasparametro.new(params[:agendasparametro])
    @agendasparametro.agendasproceso_id = @agendasproceso.id
    #@agendasparametro.user_registra = is_admin
     if @agendasparametro.valid?
        @agendasproceso.agendasparametros << @agendasparametro
        @agendasproceso.save
        @agendasparametro = Agendasparametro.new
        flash[:agendasparametro] = "Creado con exito"
      else
        flash[:agendasparametro] = "Se produjo un error al guardar el registro"
      end
    respond_to do |format|
       format.js { render :action => "agendasparametros" }
    end
  end

def update
    @agendasparametro        = Agendasparametro.new
    agendasparametro         = Agendasparametro.find(params[:id])
    #agendasparametro.user_id = is_admin
    @agendasproceso        = agendasparametro.agendasproceso
    ok = agendasparametro.update_attributes(params[:agendasparametro])
    flash[:agendasparametro] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "agendasparametros" }
    end
  end

  def destroy
    agendasparametro   = Agendasparametro.find(params[:id])
    @agendasproceso  = agendasparametro.agendasproceso
    @agendasparametro  = Agendasparametro.new
    agendasparametro.destroy
    flash[:agendasparametro] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "agendasparametros" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application" 
    end
  end
end

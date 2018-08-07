class ProcesospersonasController < ApplicationController
  before_filter :require_user
  def index
    procesosjuridico   = Procesosjuridico.find(params[:procesosjuridico_id])
    @procesospersonas = procesosjuridico.procesospersonas.all
  end

  def edit
    @procesospersona  = Procesospersona.find(params[:id], :include => "procesosjuridico")
    @procesosjuridico  = @procesospersona.procesosjuridico
    respond_to do |format|
      format.js { render :action => "edit_procesospersona" }
    end
  end

  def create
    @procesosjuridico  = Procesosjuridico.find(params[:procesosjuridico_id])
    @procesospersona = Procesospersona.new(params[:procesospersona])
    @procesospersona.user_id = is_admin
    if Persona.exists?(["id = ?", @procesospersona.persona_id]) == true
      if @procesospersona.valid?
        @procesosjuridico.procesospersonas << @procesospersona
        @procesosjuridico.save
        @procesospersona = Procesospersona.new
      else
        flash[:procesospersona] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "procesospersonas" }
      end
    else
      flash[:procesospersona] = "Debe seleccionar el usuario para Asociar"
      respond_to do |format|
        format.js { render :action => "procesospersonas" }
      end
    end
  end

  def update
    @procesospersona        = Procesospersona.new
    procesospersona         = Procesospersona.find(params[:id])
    @procesosjuridico        = procesospersona.procesosjuridico
    ok = procesospersona.update_attributes(params[:procesospersona])
    flash[:procesospersona] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "procesospersonas" }
    end
  end

  def destroy
    procesospersona   = Procesospersona.find(params[:id])
    @procesosjuridico  = procesospersona.procesosjuridico
    @procesospersona  = Procesospersona.new
    procesospersona.destroy
    respond_to do |format|
      format.js { render :action => "procesospersonas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @procesospersonas = persona.procesospersonas.all
  end
end

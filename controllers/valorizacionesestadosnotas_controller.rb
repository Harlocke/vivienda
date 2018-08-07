class ValorizacionesestadosnotasController < ApplicationController
before_filter :require_user

  def index
    valorizacionesestado   = Valorizacionesestado.find(params[:valorizacionesestado_id])
    @valorizacionesestadosnotas = valorizacionesestado.valorizacionesestadosnotas.all
  end

  def edit
    @valorizacionesestadosnota  = Valorizacionesestadosnota.find(params[:id], :include => "valorizacionesestado")
    @valorizacionesestado  = @valorizacionesestadosnota.valorizacionesestado
    respond_to do |format|
      format.js { render :action => "edit_valorizacionesestadosnota" }
    end
  end

  def create
    @valorizacionesestado  = Valorizacionesestado.find(params[:valorizacionesestado_id])
    @valorizacionesestadosnota = Valorizacionesestadosnota.new(params[:valorizacionesestadosnota])
    @valorizacionesestadosnota.user_id = is_admin
    if @valorizacionesestadosnota.valid?
      @valorizacionesestado.valorizacionesestadosnotas << @valorizacionesestadosnota
      @valorizacionesestado.save
      @valorizacionesestadosnota = Valorizacionesestadosnota.new
      flash[:valorizacionesestadosnota] = "Se guardo el registro con exito"
    else
      flash[:valorizacionesestadosnota] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "valorizacionesestadosnotas" }
    end
  end

  def update
    @valorizacionesestadosnota        = Valorizacionesestadosnota.new
    valorizacionesestadosnota         = Valorizacionesestadosnota.find(params[:id])
    @valorizacionesestado        = valorizacionesestadosnota.valorizacionesestado
    ok = valorizacionesestadosnota.update_attributes(params[:valorizacionesestadosnota])
    flash[:valorizacionesestadosnota] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "valorizacionesestadosnotas" }
    end
  end

  def destroy
    valorizacionesestadosnota   = Valorizacionesestadosnota.find(params[:id])
    @valorizacionesestado  = valorizacionesestadosnota.valorizacionesestado
    @valorizacionesestadosnota  = Valorizacionesestadosnota.new
    valorizacionesestadosnota.destroy
    respond_to do |format|
      format.js { render :action => "valorizacionesestadosnotas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @valorizacionesestadosnotas = persona.valorizacionesestadosnotas.all
  end
end

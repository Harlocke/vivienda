class PendientesnotasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    pendiente   = Pendiente.find(params[:pendiente_id])
    @pendientesnotas = pendiente.pendientesnotas.all
  end

  def edit
    @pendientesnota  = Pendientesnota.find(params[:id], :include => "pendiente")
    @pendiente  = @pendientesnota.pendiente
    respond_to do |format|
      format.js { render :action => "edit_pendientesnota" }
    end
  end

  def create
    @pendiente  = Pendiente.find(params[:pendiente_id])
    @pendientesnota = Pendientesnota.new(params[:pendientesnota])
    @pendientesnota.user_id = is_admin
    if @pendientesnota.valid?
      @pendiente.pendientesnotas << @pendientesnota
      @pendiente.save
      @pendientesnota = Pendientesnota.new
      flash[:pendientesnota] = "Se guardo el registro con exito"
    else
      flash[:pendientesnota] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "pendientesnotas" }
    end
  end

  def update
    @pendientesnota        = Pendientesnota.new
    pendientesnota         = Pendientesnota.find(params[:id])
    @pendiente        = pendientesnota.pendiente
    ok = pendientesnota.update_attributes(params[:pendientesnota])
    flash[:pendientesnota] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "pendientesnotas" }
    end
  end

  def destroy
    pendientesnota   = Pendientesnota.find(params[:id])
    @pendiente  = pendientesnota.pendiente
    @pendientesnota  = Pendientesnota.new
    pendientesnota.destroy
    respond_to do |format|
      format.js { render :action => "pendientesnotas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @pendientesnotas = persona.pendientesnotas.all
  end

  def atencion
    @pendientesnotas = Pendientesnota.find(params[:id])
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


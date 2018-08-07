class ViviendasusadasnotasController < ApplicationController

  before_filter :require_user

  layout :determine_layout

  def index
    viviendasusada   = Viviendasusada.find(params[:viviendasusada_id])
    @viviendasusadasnotas = viviendasusada.viviendasusadasnotas.all
  end

  def edit
    @viviendasusadasnota  = Viviendasusadasnota.find(params[:id], :include => "viviendasusada")
    @viviendasusada  = @viviendasusadasnota.viviendasusada
    respond_to do |format|
      format.js { render :action => "edit_viviendasusadasnota" }
    end
  end

  def create
    @viviendasusada  = Viviendasusada.find(params[:viviendasusada_id])
    @viviendasusadasnota = Viviendasusadasnota.new(params[:viviendasusadasnota])
    @viviendasusadasnota.user_id = is_admin
    if @viviendasusadasnota.valid?
      @viviendasusada.viviendasusadasnotas << @viviendasusadasnota
      @viviendasusada.save
      @viviendasusadasnota = Viviendasusadasnota.new
      flash[:viviendasusadasnota] = "Creado con exito"
    else
      flash[:viviendasusadasnota] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "viviendasusadasnotas" }
    end
  end

  def update
    @viviendasusadasnota        = Viviendasusadasnota.new
    viviendasusadasnota         = Viviendasusadasnota.find(params[:id])
    @viviendasusada        = viviendasusadasnota.viviendasusada
    ok = viviendasusadasnota.update_attributes(params[:viviendasusadasnota])
    flash[:viviendasusadasnota] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "viviendasusadasnotas" }
    end
  end

  def destroy
    viviendasusadasnota   = Viviendasusadasnota.find(params[:id])
    @viviendasusada  = viviendasusadasnota.viviendasusada
    @viviendasusadasnota  = Viviendasusadasnota.new
    viviendasusadasnota.destroy
    flash[:viviendasusadasnota] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "viviendasusadasnotas" }
    end
  end

  def atencion
    @viviendasusadasnotas = Viviendasusadasnota.find(params[:id])
  end

  private
  def determine_layout
    if ['atencion'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

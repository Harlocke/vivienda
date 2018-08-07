class ViviendasusadastramitesController < ApplicationController

  before_filter :require_user
  
  def index
    viviendasusada   = Viviendasusada.find(params[:viviendasusada_id])
    @viviendasusadastramites = viviendasusada.viviendasusadastramites.all
  end

  def edit
    @viviendasusadastramite  = Viviendasusadastramite.find(params[:id], :include => "viviendasusada")
    @viviendasusada  = @viviendasusadastramite.viviendasusada
    respond_to do |format|
      format.js { render :action => "edit_viviendasusadastramite" }
    end
  end

  def create
    @viviendasusada  = Viviendasusada.find(params[:viviendasusada_id])
    @viviendasusadastramite = Viviendasusadastramite.new(params[:viviendasusadastramite])
    if @viviendasusadastramite.valid?
      @viviendasusada.viviendasusadastramites << @viviendasusadastramite
      @viviendasusada.save
      @viviendasusadastramite = Viviendasusadastramite.new
      flash[:viviendasusadastramite] = "Creado con exito"
    else
      flash[:viviendasusadastramite] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "viviendasusadastramites" }
    end
  end

  def update
    @viviendasusadastramite        = Viviendasusadastramite.new
    viviendasusadastramite         = Viviendasusadastramite.find(params[:id])
    @viviendasusada        = viviendasusadastramite.viviendasusada
    ok = viviendasusadastramite.update_attributes(params[:viviendasusadastramite])
    flash[:viviendasusadastramite] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "viviendasusadastramites" }
    end
  end

  def destroy
    viviendasusadastramite   = Viviendasusadastramite.find(params[:id])
    @viviendasusada  = viviendasusadastramite.viviendasusada
    @viviendasusadastramite  = Viviendasusadastramite.new
    viviendasusadastramite.destroy
    flash[:viviendasusadastramite] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "viviendasusadastramites" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @viviendasusadastramites = persona.viviendasusadastramites.all
  end
end

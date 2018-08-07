class ViviendasusadaspersonasController < ApplicationController

  before_filter :require_user

  def index
    viviendasusada   = Viviendasusada.find(params[:viviendasusada_id])
    @viviendasusadaspersonas = viviendasusada.viviendasusadaspersonas.all
  end

  def edit
    @viviendasusadaspersona  = Viviendasusadaspersona.find(params[:id], :include => "viviendasusada")
    @viviendasusada  = @viviendasusadaspersona.viviendasusada
    respond_to do |format|
      format.js { render :action => "edit_viviendasusadaspersona" }
    end
  end

  def create
    @viviendasusada  = Viviendasusada.find(params[:viviendasusada_id])
    @viviendasusadaspersona = Viviendasusadaspersona.new(params[:viviendasusadaspersona])
    if Persona.exists?(["id = ?", @viviendasusadaspersona.persona_id]) == true
      if @viviendasusadaspersona.valid?
        @viviendasusada.viviendasusadaspersonas << @viviendasusadaspersona
        @viviendasusada.save
        @viviendasusadaspersona = Viviendasusadaspersona.new
      else
        flash[:viviendasusadaspersona] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "viviendasusadaspersonas" }
      end
    else
      flash[:viviendasusadaspersona] = "Debe seleccionar el usuario para Asociar"
      respond_to do |format|
        format.js { render :action => "viviendasusadaspersonas" }
      end
    end
  end

  def update
    @viviendasusadaspersona        = Viviendasusadaspersona.new
    viviendasusadaspersona         = Viviendasusadaspersona.find(params[:id])
    @viviendasusada        = viviendasusadaspersona.viviendasusada
    ok = viviendasusadaspersona.update_attributes(params[:viviendasusadaspersona])
    flash[:viviendasusadaspersona] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "viviendasusadaspersonas" }
    end
  end

  def destroy
    viviendasusadaspersona   = Viviendasusadaspersona.find(params[:id])
    @viviendasusada  = viviendasusadaspersona.viviendasusada
    @viviendasusadaspersona  = Viviendasusadaspersona.new
    viviendasusadaspersona.destroy
    respond_to do |format|
      format.js { render :action => "viviendasusadaspersonas" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @viviendasusadaspersonas = persona.viviendasusadaspersonas.all
  end
end

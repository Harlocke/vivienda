class ViviendasrenunciasController < ApplicationController

  before_filter :require_user

  layout :determine_layout

  def index
    persona   = Persona.find(params[:persona_id])
    @viviendasrenuncias = persona.viviendasrenuncias.all
  end

 def edit
    @viviendasrenuncia  = Viviendasrenuncia.find(params[:id], :include => "persona")
    @persona  = @viviendasrenuncia.persona
    respond_to do |format|
      format.js { render :action => "edit_viviendasrenuncia" }
    end
  end

  def create
    @persona  = Persona.find(params[:persona_id])
    @viviendasrenuncia = Viviendasrenuncia.new(params[:viviendasrenuncia])
    @viviendasrenuncia.user_id = is_admin
    if @viviendasrenuncia.valid?
      viviendaspersona = Viviendaspersona.find_by_persona_id(@persona.id)
      @viviendasrenuncia.vivienda_id = viviendaspersona.vivienda_id
      Viviendasrenuncia.resetvivienda(@persona.id, viviendaspersona.vivienda_id, @viviendasrenuncia.tipo_renuncia, is_admin)
      @persona.viviendasrenuncias << @viviendasrenuncia
      @persona.save
      @viviendasrenuncia = Viviendasrenuncia.new
      flash[:viviendasrenuncia] = "Creado con exito"
    else
      flash[:viviendasrenuncia] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "viviendasrenuncias" }
    end
  end

  def update
    @viviendasrenuncia        = Viviendasrenuncia.new
    viviendasrenuncia         = Viviendasrenuncia.find(params[:id])
    @persona        = viviendasrenuncia.persona
    ok = viviendasrenuncia.update_attributes(params[:viviendasrenuncia])
    flash[:notice] = ok ? "Registro modificado correctamente" : "Se produjo un error al guardar el registro"
    respond_to do |format|
      format.js { render :action => "viviendasrenuncias" }
    end
  end

  def destroy
    viviendasrenuncia   = Viviendasrenuncia.find(params[:id])
    @persona  = viviendasrenuncia.persona
    @viviendasrenuncia  = Viviendasrenuncia.new
    viviendasrenuncia.destroy
    respond_to do |format|
      format.js { render :action => "viviendasrenuncias" }
    end
  end
end

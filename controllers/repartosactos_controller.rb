class RepartosactosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    reparto   = Reparto.find(params[:reparto_id])
    @repartosactos = reparto.repartosactos.all
  end

  def edit
    @repartosacto  = Repartosacto.find(params[:id], :include => "reparto")
    @reparto  = @repartosacto.reparto
    respond_to do |format|
      format.js { render :action => "edit_repartosacto" }
    end
  end

  def create
    @reparto  = Reparto.find(params[:reparto_id])
    @repartosacto = Repartosacto.new(params[:repartosacto])
    @repartosacto.user_id = is_admin
    if @repartosacto.valid?
      @reparto.repartosactos << @repartosacto
      @reparto.save
      @repartosacto = Repartosacto.new
      flash[:repartosacto] = "Se guardo el registro con exito"
    else
      flash[:repartosacto] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "repartosactos" }
    end
  end

  def update
    @repartosacto        = Repartosacto.new
    repartosacto         = Repartosacto.find(params[:id])
    @reparto        = repartosacto.reparto
    ok = repartosacto.update_attributes(params[:repartosacto])
    flash[:repartosacto] = ok ? "asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "repartosactos" }
    end
  end

  def destroy
    repartosacto   = Repartosacto.find(params[:id])
    @reparto  = repartosacto.reparto
    @repartosacto  = Repartosacto.new
    repartosacto.destroy
    respond_to do |format|
      format.js { render :action => "repartosactos" }
    end
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @repartosactos = persona.repartosactos.all
  end

  def atencion
    @repartosactos = Repartosacto.find(params[:id])
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

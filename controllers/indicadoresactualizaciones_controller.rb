class IndicadoresactualizacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    indicador   = Indicador.find(params[:indicador_id])
    @indicadoresactualizaciones = indicador.indicadoresactualizaciones.all
  end

 def edit
    @indicadoresactualizacion  = Indicadoresactualizacion.find(params[:id], :include => "indicador")
    @indicador  = @indicadoresactualizacion.indicador
    respond_to do |format|
      format.js { render :action => "edit_indicadoresactualizacion" }
    end
  end

  def create
    @indicador  = Indicador.find(params[:indicador_id])
    @indicadoresactualizacion = Indicadoresactualizacion.new(params[:indicadoresactualizacion])
    @indicadoresactualizacion.user_id = is_admin
    if @indicadoresactualizacion.valid?
      @indicador.indicadoresactualizaciones << @indicadoresactualizacion
      @indicador.save
      @indicadoresactualizacion = Indicadoresactualizacion.new
      flash[:indicadoresactualizacion] = "Creado con exito"
    else
      flash[:indicadoresactualizacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "indicadoresactualizaciones" }
    end
  end

  def update
    @indicadoresactualizacion        = Indicadoresactualizacion.new
    indicadoresactualizacion         = Indicadoresactualizacion.find(params[:id])
    #indicadoresactualizacion.user_id = is_admin
    @indicador        = indicadoresactualizacion.indicador
    ok = indicadoresactualizacion.update_attributes(params[:indicadoresactualizacion])
    flash[:indicadoresactualizacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "indicadoresactualizaciones" }
    end
  end

  def destroy
    indicadoresactualizacion   = Indicadoresactualizacion.find(params[:id])
    @indicador  = indicadoresactualizacion.indicador
    @indicadoresactualizacion  = Indicadoresactualizacion.new
    indicadoresactualizacion.destroy
    flash[:indicadoresactualizacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "indicadoresactualizaciones" }
    end
  end
end
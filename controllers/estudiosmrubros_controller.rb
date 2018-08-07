class EstudiosmrubrosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    estudiosmodificacion   = Estudiosmodificacion.find(params[:estudiosmodificacion_id])
    @estudiosmrubros = estudiosmodificacion.estudiosmrubros.all
  end

 def edit
    @estudiosmrubro  = Estudiosmrubro.find(params[:id], :include => "estudiosmodificacion")
    @estudiosmodificacion  = @estudiosmrubro.estudiosmodificacion
    respond_to do |format|
      format.js { render :action => "edit_estudiosmrubro" }
    end
  end

  def create
    @estudiosmodificacion  = Estudiosmodificacion.find(params[:estudiosmodificacion_id])
    @estudiosmrubro = Estudiosmrubro.new(params[:estudiosmrubro])
    @estudiosmrubro.user_id = is_admin
    if @estudiosmrubro.valid?
      @estudiosmodificacion.estudiosmrubros << @estudiosmrubro
      @estudiosmodificacion.save
      @estudiosmrubro = Estudiosmrubro.new
      flash[:estudiosmrubro] = "Creado con exito"
    else
      flash[:estudiosmrubro] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "estudiosmrubros" }
    end
  end
  
  def update
    @estudiosmrubro        = Estudiosmrubro.new
    estudiosmrubro         = Estudiosmrubro.find(params[:id])
    #estudiosmrubro.user_id = is_admin
    @estudiosmodificacion        = estudiosmrubro.estudiosmodificacion
    ok = estudiosmrubro.update_attributes(params[:estudiosmrubro])
    flash[:estudiosmrubro] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "estudiosmrubros" }
    end
  end

  def destroy
    estudiosmrubro   = Estudiosmrubro.find(params[:id])
    @estudiosmodificacion  = estudiosmrubro.estudiosmodificacion
    @estudiosmrubro  = Estudiosmrubro.new
    estudiosmrubro.destroy
    flash[:estudiosmrubro] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "estudiosmrubros" }
    end
  end
end

class EstudiospreviosrubrosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    estudiosprevio   = Estudiosprevio.find(params[:estudiosprevio_id])
    @estudiospreviosrubros = estudiosprevio.estudiospreviosrubros.all
  end

 def edit
    @estudiospreviosrubro  = Estudiospreviosrubro.find(params[:id], :include => "estudiosprevio")
    @estudiosprevio  = @estudiospreviosrubro.estudiosprevio
    respond_to do |format|
      format.js { render :action => "edit_estudiospreviosrubro" }
    end
  end

  def create
    @estudiosprevio  = Estudiosprevio.find(params[:estudiosprevio_id])
    @estudiospreviosrubro = Estudiospreviosrubro.new(params[:estudiospreviosrubro])
    @estudiospreviosrubro.user_id = is_admin
    if @estudiospreviosrubro.valid?
      @estudiosprevio.estudiospreviosrubros << @estudiospreviosrubro
      @estudiosprevio.save
      @estudiospreviosrubro = Estudiospreviosrubro.new
      flash[:estudiospreviosrubro] = "Creado con exito"
    else
      flash[:estudiospreviosrubro] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "estudiospreviosrubros" }
    end
  end

  def update
    @estudiospreviosrubro        = Estudiospreviosrubro.new
    estudiospreviosrubro         = Estudiospreviosrubro.find(params[:id])
    #estudiospreviosrubro.user_id = is_admin
    @estudiosprevio        = estudiospreviosrubro.estudiosprevio
    ok = estudiospreviosrubro.update_attributes(params[:estudiospreviosrubro])
    flash[:estudiospreviosrubro] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "estudiospreviosrubros" }
    end
  end

  def destroy
    estudiospreviosrubro   = Estudiospreviosrubro.find(params[:id])
    @estudiosprevio  = estudiospreviosrubro.estudiosprevio
    @estudiospreviosrubro  = Estudiospreviosrubro.new
    estudiospreviosrubro.destroy
    flash[:estudiospreviosrubro] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "estudiospreviosrubros" }
    end
  end
end

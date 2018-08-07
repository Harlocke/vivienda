class ElementosmantenimientosController < ApplicationController
before_filter :require_user

  layout :determine_layout

  def index
    elemento   = Elemento.find(params[:elemento_id])
    @elementosmantenimientos = elemento.elementosmantenimientos.all
  end

 def edit
    @elementosmantenimiento  = Elementosmantenimiento.find(params[:id], :include => "elemento")
    @elemento  = @elementosmantenimiento.elemento
    respond_to do |format|
      format.js { render :action => "edit_elementosmantenimiento" }
    end
  end

  def create
    @elemento  = Elemento.find(params[:elemento_id])
    @elementosmantenimiento = Elementosmantenimiento.new(params[:elementosmantenimiento])
    @elementosmantenimiento.user_id = is_admin
     if @elementosmantenimiento.valid?
        @elemento.elementosmantenimientos << @elementosmantenimiento
        @elemento.save
        @elementosmantenimiento = Elementosmantenimiento.new
        flash[:elementosmantenimiento] = "Creado con exito"
      else
        flash[:elementosmantenimiento] = "Se produjo un error al guardar el registro"
      end
    respond_to do |format|
       format.js { render :action => "elementosmantenimientos" }
    end
  end

  def update
    @elementosmantenimiento        = Elementosmantenimiento.new
    elementosmantenimiento         = Elementosmantenimiento.find(params[:id])
    @elemento        = elementosmantenimiento.elemento
    ok = elementosmantenimiento.update_attributes(params[:elementosmantenimiento])
    flash[:elementosmantenimiento] = ok ? "Actualizado con Exito " : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "elementosmantenimientos" }
    end
  end

  def destroy
    elementosmantenimiento   = Elementosmantenimiento.find(params[:id])
    @elemento  = elementosmantenimiento.elemento
    @elementosmantenimiento  = Elementosmantenimiento.new
    elementosmantenimiento.destroy
    flash[:elementosmantenimiento] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "elementosmantenimientos" }
    end
  end

  def visualizar
    @elementosmantenimientos = Elementosmantenimiento.find(params[:id])
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

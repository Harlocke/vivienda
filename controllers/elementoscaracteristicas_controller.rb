class ElementoscaracteristicasController < ApplicationController
before_filter :require_user

  layout :determine_layout

  def index
    elemento   = Elemento.find(params[:elemento_id])
    @elementoscaracteristicas = elemento.elementoscaracteristicas.all
  end

 def edit
    @elementoscaracteristica  = Elementoscaracteristica.find(params[:id], :include => "elemento")
    @elemento  = @elementoscaracteristica.elemento
    respond_to do |format|
      format.js { render :action => "edit_elementoscaracteristica" }
    end
  end

  def create
    @elemento  = Elemento.find(params[:elemento_id])
    @elementoscaracteristica = Elementoscaracteristica.new(params[:elementoscaracteristica])
       if @elementoscaracteristica.valid?
          @elemento.elementoscaracteristicas << @elementoscaracteristica
          @elemento.save
          @elementoscaracteristica = Elementoscaracteristica.new
          flash[:elementoscaracteristica] = "Creado con exito"
        else
          flash[:elementoscaracteristica] = "Se produjo un error al guardar el registro"
        end
    respond_to do |format|
       format.js { render :action => "elementoscaracteristicas" }
    end
  end

  def update
    @elementoscaracteristica        = Elementoscaracteristica.new
    elementoscaracteristica         = Elementoscaracteristica.find(params[:id])
    @elemento        = elementoscaracteristica.elemento
    ok = elementoscaracteristica.update_attributes(params[:elementoscaracteristica])
    flash[:elementoscaracteristica] = ok ? "Actualizado con Exito " : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "elementoscaracteristicas" }
    end
  end

  def destroy
    elementoscaracteristica   = Elementoscaracteristica.find(params[:id])
    @elemento  = elementoscaracteristica.elemento
    @elementoscaracteristica  = Elementoscaracteristica.new
    elementoscaracteristica.destroy
    flash[:elementoscaracteristica] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "elementoscaracteristicas" }
    end
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end

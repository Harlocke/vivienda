class ElementosotrosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    elemento   = Elemento.find(params[:elemento_id])
    @elementosotros = elemento.elementosotros.all
  end

 def edit
    @elementosotro  = Elementosotro.find(params[:id], :include => "elemento")
    @elemento  = @elementosotro.elemento
    respond_to do |format|
      format.js { render :action => "edit_elementosotro" }
    end
  end

  def create
    @elemento  = Elemento.find(params[:elemento_id])
    @elementosotro = Elementosotro.new(params[:elementosotro])
    @elementosotro.user_id = is_admin
       if @elementosotro.valid?
          @elemento.elementosotros << @elementosotro
          @elemento.save
          @elementosotro = Elementosotro.new
          flash[:elementosotro] = "Creado con exito"
        else
          flash[:elementosotro] = "Se produjo un error al guardar el registro"
        end
    respond_to do |format|
       format.js { render :action => "elementosotros" }
    end
  end

  def update
    @elementosotro        = Elementosotro.new
    elementosotro         = Elementosotro.find(params[:id])
    @elemento        = elementosotro.elemento
    ok = elementosotro.update_attributes(params[:elementosotro])
    flash[:elementosotro] = ok ? "Actualizado con Exito " : "Se produjo un error al actualizar el registro "
    respond_to do |format|
      format.js { render :action => "elementosotros" }
    end
  end

  def destroy
    elementosotro   = Elementosotro.find(params[:id])
    @elemento  = elementosotro.elemento
    @elementosotro  = Elementosotro.new
    elementosotro.destroy
    flash[:elementosotro] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "elementosotros" }
    end
  end

  def visualizar
    @elementosotros = Elementosotro.find(params[:id])
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

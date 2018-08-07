class CorresinternasbitacorasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    correspondenciasinterna   = Correspondenciasinterna.find(params[:correspondenciasinterna_id])
    @corresinternasbitacoras = correspondenciasinterna.corresinternasbitacoras.all
  end

 def edit
    @corresinternasbitacora  = Corresinternasbitacora.find(params[:id], :include => "correspondenciasinterna")
    @correspondenciasinterna  = @corresinternasbitacora.correspondenciasinterna
    respond_to do |format|
      format.js { render :action => "edit_corresinternasbitacora" }
    end
  end

 def visualizar
    @corresinternasbitacora  = Corresinternasbitacora.find(params[:id])
  end

  def create
    @correspondenciasinterna  = Correspondenciasinterna.find(params[:correspondenciasinterna_id])
    @corresinternasbitacora = Corresinternasbitacora.new(params[:corresinternasbitacora])
    if @corresinternasbitacora.valid?
      @correspondenciasinterna.corresinternasbitacoras << @corresinternasbitacora
      @correspondenciasinterna.save
      @corresinternasbitacora = Corresinternasbitacora.new
      flash[:corresinternasbitacora] = "Creado con exito"
    else
      flash[:corresinternasbitacora] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "corresinternasbitacoras" }
    end
  end

  def update
    @corresinternasbitacora   = Corresinternasbitacora.new
    corresinternasbitacora    = Corresinternasbitacora.find(params[:id])
    @correspondenciasinterna        = corresinternasbitacora.correspondenciasinterna
    ok = corresinternasbitacora.update_attributes(params[:corresinternasbitacora])
    flash[:corresinternasbitacora] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "corresinternasbitacoras" }
    end
  end

  def destroy
    corresinternasbitacora   = Corresinternasbitacora.find(params[:id])
    @correspondenciasinterna  = corresinternasbitacora.correspondenciasinterna
    @corresinternasbitacora  = Corresinternasbitacora.new
    corresinternasbitacora.destroy
    flash[:corresinternasbitacora] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "corresinternasbitacoras" }
    end
  end

  private
  def determine_layout
    if ['create'].include?(action_name)
      "application"
#    else
#      "basico"
    end
  end
end
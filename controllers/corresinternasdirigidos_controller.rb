class CorresinternasdirigidosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    correspondenciasinterna   = Correspondenciasinterna.find(params[:correspondenciasinterna_id])
    @corresinternasdirigidos = correspondenciasinterna.corresinternasdirigidos.all
  end

 def edit
    @corresinternasdirigido  = Corresinternasdirigido.find(params[:id], :include => "correspondenciasinterna")
    @correspondenciasinterna  = @corresinternasdirigido.correspondenciasinterna
    respond_to do |format|
      format.js { render :action => "edit_corresinternasdirigido" }
    end
  end

 def visualizar
    @corresinternasdirigido  = Corresinternasdirigido.find(params[:id])
  end

  def create
    @correspondenciasinterna  = Correspondenciasinterna.find(params[:correspondenciasinterna_id])
    @corresinternasdirigido = Corresinternasdirigido.new(params[:corresinternasdirigido])
    if @corresinternasdirigido.valid?
      @correspondenciasinterna.corresinternasdirigidos << @corresinternasdirigido
      @correspondenciasinterna.save
      @corresinternasdirigido = Corresinternasdirigido.new
      flash[:corresinternasdirigido] = "Creado con exito"
    else
      flash[:corresinternasdirigido] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "corresinternasdirigidos" }
    end
  end

  def update
    @corresinternasdirigido   = Corresinternasdirigido.new
    corresinternasdirigido    = Corresinternasdirigido.find(params[:id])
    @correspondenciasinterna        = corresinternasdirigido.correspondenciasinterna
    ok = corresinternasdirigido.update_attributes(params[:corresinternasdirigido])
    flash[:corresinternasdirigido] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "corresinternasdirigidos" }
    end
  end

  def destroy
    corresinternasdirigido   = Corresinternasdirigido.find(params[:id])
    @correspondenciasinterna  = corresinternasdirigido.correspondenciasinterna
    @corresinternasdirigido  = Corresinternasdirigido.new
    corresinternasdirigido.destroy
    flash[:corresinternasdirigido] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "corresinternasdirigidos" }
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

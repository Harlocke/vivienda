class PrecioselementoshijosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    precioselemento   = Precioselemento.find(params[:precioselemento_id])
    @precioselementoshijos = precioselemento.precioselementoshijos.all
  end

  def edit
    @precioselementoshijo      = Precioselementoshijo.new
    precioselementoshijo       = Precioselementoshijo.find(params[:id])
    @precioselemento       = precioselementoshijo.precioselemento
    ok = precioselementoshijo.update_attributes(params[:precioselementoshijo])
    respond_to do |format|
      format.js { render :action => "precioselementoshijos" }
    end
  end

  def visualizar
    @precioselementoshijo  = Precioselementoshijo.find(params[:id])
  end

  def mostrar
    @precioselemento = Precioselemento.find(params[:id])
    @precioselementoshijos = Precioselementoshijo.find(:all, :conditions=>["precioselemento_id = #{params[:id]}"])
  end

  def create
    @precioselemento  = Precioselemento.find(params[:precioselemento_id])
    @precioselementoshijo = Precioselementoshijo.new(params[:precioselementoshijo])
    @precioselementoshijo.user_id = is_admin
    if @precioselementoshijo.valid?
      @valor1 = Precioselemento.find(@precioselementoshijo.elementoenlace_id).valor.to_f * @precioselementoshijo.cantidad
      @valor2 = @valor1 * (@precioselementoshijo.desp.to_f/100)
      @valort = @valor1 +  @valor2
      @precioselementoshijo.valortotal = @valort
      @precioselemento.precioselementoshijos << @precioselementoshijo
      @precioselemento.save
      @precioselementoshijo = Precioselementoshijo.new
      flash[:precioselementoshijo] = "Creado con exito"
    else
      flash[:precioselementoshijo] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "precioselementoshijos" }
    end
  end

  def update
    @precioselementoshijo   = Precioselementoshijo.new
    precioselementoshijo    = Precioselementoshijo.find(params[:id])
    @precioselemento        = precioselementoshijo.precioselemento
    ok = precioselementoshijo.update_attributes(params[:precioselementoshijo])
    flash[:precioselementoshijo] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "precioselementoshijos" }
    end
  end

  def destroy
    precioselementoshijo   = Precioselementoshijo.find(params[:id])
    @precioselemento  = precioselementoshijo.precioselemento
    @precioselementoshijo  = Precioselementoshijo.new
    precioselementoshijo.destroy
    flash[:precioselementoshijo] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "precioselementoshijos" }
    end
  end

  private
  def determine_layout
    if ['mostrar'].include?(action_name)
      "informesapu"
    else
      "application"
    end
  end
end

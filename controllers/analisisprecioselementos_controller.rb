class AnalisisprecioselementosController < ApplicationController
  before_filter :require_user
    layout :determine_layout

  def index
    analisisprecio   = Analisisprecio.find(params[:analisisprecio_id])
    @analisisprecioselementos = analisisprecio.analisisprecioselementos.all
  end

  def edit
    @analisisprecioselemento  = Analisisprecioselemento.find(params[:id], :include => "analisisprecio")
    @analisisprecio  = @analisisprecioselemento.analisisprecio
    respond_to do |format|
      format.js { render :action => "edit_analisisprecioselemento" }
    end
  end

  def create
    @analisisprecio  = Analisisprecio.find(params[:analisisprecio_id])
    @analisisprecioselemento = Analisisprecioselemento.new(params[:analisisprecioselemento])
    if @analisisprecioselemento.valid?
      @analisisprecioselemento.user_id = is_admin
      elemento = Precioselemento.find(@analisisprecioselemento.precioselemento_id)
      @analisisprecioselemento.valorunitario = elemento.valor.to_f
      @analisisprecioselemento.valortotal    = elemento.valor.to_f * @analisisprecioselemento.cantidad.to_f
      @analisisprecioselemento.herramienta   =  (@analisisprecioselemento.valortotal.to_f * 5)/100.to_f
      @analisisprecio.analisisprecioselementos << @analisisprecioselemento
      @analisisprecio.save
      @analisisprecioselemento = Analisisprecioselemento.new
      flash[:notice] = "Creadooo"
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "analisisprecioselementos" }
    end
  end
  
  def update
    @analisisprecioselemento        = Analisisprecioselemento.new
    analisisprecioselemento         = Analisisprecioselemento.find(params[:id])
    @analisisprecio        = analisisprecioselemento.analisisprecio
    elemento = Precioselemento.find(analisisprecioselemento.precioselemento_id)
    params[:analisisprecioselemento][:valorunitario] = elemento.valor.to_f
    params[:analisisprecioselemento][:valortotal] = elemento.valor.to_f * params[:analisisprecioselemento][:cantidad].to_f
    params[:analisisprecioselemento][:herramienta] = (params[:analisisprecioselemento][:valortotal].to_f * 5)/100.to_f
    ok = analisisprecioselemento.update_attributes(params[:analisisprecioselemento])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "analisisprecioselementos" }
    end
  end

  def destroy
    analisisprecioselemento   = Analisisprecioselemento.find(params[:id])
    @analisisprecio  = analisisprecioselemento.analisisprecio
    @analisisprecioselemento  = Analisisprecioselemento.new
    analisisprecioselemento.destroy
    respond_to do |format|
      format.js { render :action => "analisisprecioselementos" }
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
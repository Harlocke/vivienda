class LicitacionesenlacesController < ApplicationController
  before_filter :require_user

  def index
    licitacion   = Licitacion.find(params[:licitacion_id])
    @licitacionesenlaces = licitacion.licitacionesenlaces.all
  end

  def edit
    @licitacionesenlace  = Licitacionesenlace.find(params[:id], :include => "licitacion")
    @licitacion  = @licitacionesenlace.licitacion
    respond_to do |format|
      format.js { render :action => "edit_licitacionesenlace" }
    end
  end

  def create
    @licitacion  = Licitacion.find(params[:licitacion_id])
    @licitacionesenlace = Licitacionesenlace.new(params[:licitacionesenlace])
    if @licitacionesenlace.valid?
      @licitacionesenlace.user_id = is_admin
      @licitacionesenlace.valorunitario = @licitacionesenlace.analisisprecio.valor.to_f
      @licitacionesenlace.valortotal = @licitacionesenlace.cantidad * @licitacionesenlace.analisisprecio.valor.to_f
      @licitacion.licitacionesenlaces << @licitacionesenlace
      @licitacion.save
      @licitacionesenlace = Licitacionesenlace.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "licitacionesenlaces" }
    end
  end

  def update
    @licitacionesenlace        = Licitacionesenlace.new
    licitacionesenlace         = Licitacionesenlace.find(params[:id])
    @licitacion        = licitacionesenlace.licitacion
    params[:licitacionesenlace][:valorunitario] = licitacionesenlace.analisisprecio.valor.to_f
    params[:licitacionesenlace][:valortotal] = params[:licitacionesenlace][:cantidad].to_f * licitacionesenlace.analisisprecio.valor.to_f
    ok = licitacionesenlace.update_attributes(params[:licitacionesenlace])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "licitacionesenlaces" }
    end
  end

  def destroy
    licitacionesenlace   = Licitacionesenlace.find(params[:id])
    #licitacionesprecio =Licitacionesprecio.find_by_licitacionesenlace_id(params[:id])
    @licitacion  = licitacionesenlace.licitacion
    @licitacionesenlace  = Licitacionesenlace.new
    licitacionesenlace.destroy
    #licitacionesprecio.destroy
    respond_to do |format|
      format.js { render :action => "licitacionesenlaces" }
    end
  end
end
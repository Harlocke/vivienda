class LicitacionesenlacespagosController < ApplicationController
  before_filter :require_user
#  layout :determine_layout

  def new
    @licitacionesenlacespago = Licitacionesenlacespago.new
    @licitacionesenlacespago.licitacionesenlace_id = params[:licitacionesenlace_id]
    @licitacionesenlace = Licitacionesenlace.find(params[:licitacionesenlace_id])
    render :action => "licitacionesenlacespago_form"
  end

  def edit
    @licitacionesenlacespago = Licitacionesenlacespago.find(params[:id])
    @licitacionesenlace = Licitacionesenlace.find(@licitacionesenlacespago.licitacionesenlace_id)
    respond_to do |format|
      format.html { render :action => "licitacionesenlacespago_form" }
    end
  end

  def create
    @licitacionesenlacespago = Licitacionesenlacespago.new(params[:licitacionesenlacespago])
    @licitacionesenlacespago.user_id = is_admin
    @licitacionesenlace = Licitacionesenlace.find(params[:licitacionesenlacespago][:licitacionesenlace_id])
    sumvalor = 0
    sumvalor = Licitacionesenlacespago.sum('valor', :conditions => ["licitacionesenlace_id = #{params[:licitacionesenlacespago][:licitacionesenlace_id]}"]) rescue 0
    sumvalor = sumvalor.to_i + params[:licitacionesenlacespago][:valor].to_i
    if sumvalor > @licitacionesenlace.valortotal
      flash[:warning] = "El valor ingresado super el valor total del Analisis Seleccionado"
      render :action => "licitacionesenlacespago_form"
    else
      if @licitacionesenlacespago.save
        flash[:notice] = "Registro Creado con Exito."
        redirect_to edit_licitacionesenlacespago_path(@licitacionesenlacespago)
      else
        render :action => "licitacionesenlacespago_form"
      end
    end
  end

  def update
    @licitacionesenlacespago = Licitacionesenlacespago.find(params[:id])
    @licitacionesenlacespago.user_actualiza = is_admin
    if @licitacionesenlacespago.update_attributes(params[:licitacionesenlacespago])
      flash[:notice] = "Registro Actualizado con Exito."
      redirect_to edit_licitacionesenlacespago_path(@licitacionesenlacespago)
    else
      @licitacionesenlace = Licitacionesenlace.find(@licitacionesenlacespago.licitacionesenlace_id)
      render :action => "licitacionesenlacespago_form"
    end
  end

  def destroy
    @licitacionesenlacespago = Licitacionesenlacespago.find(params[:id])
    @licitacionesenlace = Licitacionesenlace.find(@licitacionesenlacespago.licitacionesenlace_id)
    @licitacionesenlacespago.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El Pago ha sido eliminado con Exito."
        redirect_to edit_licitacion_path(@licitacionesenlace.licitacion_id)
      }
      format.xml  { head :ok }
    end
  end

end

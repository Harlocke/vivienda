class MejoramientospagoslistasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    mejoramientospago   = Mejoramientospago.find(params[:mejoramientospago_id])
    @mejoramientospagoslistas = mejoramientospago.mejoramientospagoslistas.all
  end

  def informe
    @mejoramientospago = Mejoramientospago.find(params[:id])
  end

  def edit
    @mejoramientospagoslista  = Mejoramientospagoslista.find(params[:id], :include => "mejoramientospago")
    @mejoramientospagoslista  = @mejoramientospagoslista.mejoramientospago
    respond_to do |format|
      format.js { render :action => "edit_mejoramientospagoslista" }
    end
  end

  def update
    @mejoramientospagoslista        = Mejoramientospagoslista.new
    mejoramientospagoslista         = Mejoramientospagoslista.find(params[:id])
    params[:mejoramientospagoslista][:user_actualiza] = is_admin
    @mejoramiento        = mejoramientospagoslista.mejoramiento
    ok = mejoramientospagoslista.update_attributes(params[:mejoramientospagoslista])
    if ok == true
      is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientospagoslistas','A')
      flash[:mejoramientospagoslista] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "mejoramientospagoslistas" }
      end
    else
      render :update do |page|
        page.alert "El registro tiene inconsistencias por falta de campos o valor ingresado supera el subsidio. Verifique!!"
      end
    end
#    respond_to do |format|
#      format.js { render :action => "mejoramientospagoslistas" }
#    end
  end

  def si
    @mejoramientospagoslista        = Mejoramientospagoslista.new
    mejoramientospagoslista         = Mejoramientospagoslista.find(params[:id])
    mejoramientospagoslista.estado ='SI'
    @mejoramientospago       = mejoramientospagoslista.mejoramientospago
    ok = mejoramientospagoslista.update_attributes(params[:mejoramientospagoslista])
    respond_to do |format|
      format.js { render :action => "mejoramientospagoslistas" }
    end
  end

  def no
    @mejoramientospagoslista        = Mejoramientospagoslista.new
    mejoramientospagoslista         = Mejoramientospagoslista.find(params[:id])
    mejoramientospagoslista.estado ='NO'
    @mejoramientospago       = mejoramientospagoslista.mejoramientospago
    ok = mejoramientospagoslista.update_attributes(params[:mejoramientospagoslista])
    respond_to do |format|
      format.js { render :action => "mejoramientospagoslistas" }
    end
  end

  def na
    @mejoramientospagoslista        = Mejoramientospagoslista.new
    mejoramientospagoslista         = Mejoramientospagoslista.find(params[:id])
    mejoramientospagoslista.estado ='NO APLICA'
    @mejoramientospago       = mejoramientospagoslista.mejoramientospago
    ok = mejoramientospagoslista.update_attributes(params[:mejoramientospagoslista])
    respond_to do |format|
      format.js { render :action => "mejoramientospagoslistas" }
    end
  end

  private
  def determine_layout
    if ['atencion','informe'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

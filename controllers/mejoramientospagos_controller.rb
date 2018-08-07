class MejoramientospagosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def verlista
    @mejoramientospago = Mejoramientospago.find(params[:id])
    @mejoramientospagoslista = Mejoramientospagoslista.new
  end

  def index
    mejoramiento   = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientospagos = mejoramiento.mejoramientospagos.all
  end

 def edit
    @mejoramientospago  = Mejoramientospago.find(params[:id], :include => "mejoramiento")
    @mejoramiento  = @mejoramientospago.mejoramiento
    respond_to do |format|
      format.js { render :action => "edit_mejoramientospago" }
    end
  end

  def create
    @mejoramiento  = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientospago = Mejoramientospago.new(params[:mejoramientospago])
    @mejoramientospago.user_id = is_admin
    sumvalor = 0
    sumvalor = Mejoramientospago.sum('valor', :conditions => ["mejoramiento_id = #{@mejoramiento.id}"]) rescue 0
    sumvalor = sumvalor.to_i + params[:mejoramientospago][:valor].to_i
    if @mejoramientospago.valid?
      if sumvalor > @mejoramiento.valor_resolucion
        render :update do |page|
          page.alert "ATENCIÓN: El valor ingresado supera el valor del Subsidio... Verifique!!! - Valor Subsidio : " + @mejoramiento.valor_resolucion.to_s
        end
      else
        @mejoramiento.mejoramientospagos << @mejoramientospago
        @mejoramiento.save
        is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientospagos','I')
        @mejoramientospago = Mejoramientospago.new
        flash[:mejoramientospago] = "Creado con exito"
        respond_to do |format|
          format.js { render :action => "mejoramientospagos" }
        end
      end
    else
      flash[:mejoramientospago] = "Se produjo un error al guardar el registro"
      respond_to do |format|
        format.js { render :action => "mejoramientospagos" }
      end
    end    
  end

  def update
    @mejoramientospago        = Mejoramientospago.new
    mejoramientospago         = Mejoramientospago.find(params[:id])
    #mejoramientospago.user_id = is_admin
    params[:mejoramientospago][:user_actualiza] = is_admin
    @mejoramiento        = mejoramientospago.mejoramiento
    ok = mejoramientospago.update_attributes(params[:mejoramientospago])
    if ok == true
      is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientospagos','A')
      flash[:mejoramientospago] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "mejoramientospagos" }
      end
    else
      render :update do |page|
        page.alert "El registro tiene inconsistencias por falta de campos o valor ingresado supera el subsidio. Verifique!!"
      end
    end
#    respond_to do |format|
#      format.js { render :action => "mejoramientospagos" }
#    end
  end

  def destroy
    mejoramientospago   = Mejoramientospago.find(params[:id])
    @mejoramiento  = mejoramientospago.mejoramiento
    @mejoramientospago  = Mejoramientospago.new
    mejoramientospago.destroy
    flash[:mejoramientospago] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "mejoramientospagos" }
    end
  end

  def atencion
    @mejoramientospagos = Mejoramientospago.find(params[:id])
  end

  private
  def determine_layout
    if ['atencion'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

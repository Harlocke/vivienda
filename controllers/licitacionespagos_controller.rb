class LicitacionespagosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    licitacion   = Licitacion.find(params[:licitacion_id])
    @licitacionespagos = licitacion.licitacionespagos.all
  end

 def edit
    @licitacionespago  = Licitacionespago.find(params[:id], :include => "licitacion")
    @licitacion  = @licitacionespago.licitacion
    respond_to do |format|
      format.js { render :action => "edit_licitacionespago" }
    end
  end

  def create
    @licitacion  = Licitacion.find(params[:licitacion_id])
    @licitacionespago = Licitacionespago.new(params[:licitacionespago])
    @licitacionespago.user_id = is_admin
    sumvalor = 0
    sumvalor = Licitacionespago.sum('valor', :conditions => ["licitacion_id = #{@licitacion.id}"]) rescue 0
    sumvalor = sumvalor.to_i + params[:licitacionespago][:valor].to_i
    if @licitacionespago.valid?
      if sumvalor > @licitacion.valor_resolucion
        render :update do |page|
          page.alert "ATENCIÓN: El valor ingresado supera el valor del Subsidio... Verifique!!! - Valor Subsidio : " + @licitacion.valor_resolucion.to_s
        end
      else
        @licitacion.licitacionespagos << @licitacionespago
        @licitacion.save
        #is_trigger_mej(@licitacion.id,is_admin,'licitacionespagos','I')
        @licitacionespago = Licitacionespago.new
        flash[:licitacionespago] = "Creado con exito"
        respond_to do |format|
          format.js { render :action => "licitacionespagos" }
        end
      end
    else
      flash[:licitacionespago] = "Se produjo un error al guardar el registro"
      respond_to do |format|
        format.js { render :action => "licitacionespagos" }
      end
    end

  end

  def update
    @licitacionespago        = Licitacionespago.new
    licitacionespago         = Licitacionespago.find(params[:id])
    #licitacionespago.user_id = is_admin
    params[:licitacionespago][:user_actualiza] = is_admin
    @licitacion        = licitacionespago.licitacion
    ok = licitacionespago.update_attributes(params[:licitacionespago])
    if ok == true
      #is_trigger_mej(@licitacion.id,is_admin,'licitacionespagos','A')
      flash[:licitacionespago] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "licitacionespagos" }
      end
    else
      render :update do |page|
        page.alert "El registro tiene inconsistencias por falta de campos o valor ingresado supera el subsidio. Verifique!!"
      end
    end
#    respond_to do |format|
#      format.js { render :action => "licitacionespagos" }
#    end
  end

  def destroy
    licitacionespago   = Licitacionespago.find(params[:id])
    licitacionespago.destroy
    @licitacion  = licitacionespago.licitacion
    @licitacionespago  = Licitacionespago.new
    licitacionespago.destroy
    flash[:licitacionespago] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "licitacionespagos" }
    end
  end

  def atencion
    @licitacionespagos = Licitacionespago.find(params[:id])
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

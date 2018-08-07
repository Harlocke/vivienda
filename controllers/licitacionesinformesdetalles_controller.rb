class LicitacionesinformesdetallesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    licitacionesinforme   = Licitacionesinforme.find(params[:licitacionesinforme_id])
    @licitacionesinformesdetalles = licitacionesinforme.licitacionesinformesdetalles.all
  end

 def edit
    @licitacionesinformesdetalle  = Licitacionesinformesdetalle.find(params[:id], :include => "licitacionesinforme")
    @licitacionesinforme  = @licitacionesinformesdetalle.licitacionesinforme
    respond_to do |format|
      format.js { render :action => "edit_licitacionesinformesdetalle" }
    end
  end

  def create
    @licitacionesinforme  = Licitacionesinforme.find(params[:licitacionesinforme_id])
    @licitacionesinformesdetalle = Licitacionesinformesdetalle.new(params[:licitacionesinformesdetalle])
    #@licitacionesinformesdetalle.user_id = is_admin
    if @licitacionesinformesdetalle.valid?
      @licitacionesinforme.licitacionesinformesdetalles << @licitacionesinformesdetalle
      @licitacionesinforme.save
      #is_trigger_mej(@licitacionesinforme.id,is_admin,'licitacionesinformesdetalles','I')
      @licitacionesinformesdetalle = Licitacionesinformesdetalle.new
      flash[:licitacionesinformesdetalle] = "Creado con exito"
    else
      flash[:licitacionesinformesdetalle] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "licitacionesinformesdetalles" }
    end
  end

  def update
    @licitacionesinformesdetalle        = Licitacionesinformesdetalle.new
    licitacionesinformesdetalle         = Licitacionesinformesdetalle.find(params[:id])
    @licitacionesinforme        = licitacionesinformesdetalle.licitacionesinforme
    params[:licitacionesinformesdetalle][:valor_total] = licitacionesinformesdetalle.licitacionesenlace.valorunitario.to_f * params[:licitacionesinformesdetalle][:cantidad].to_f
    valortotal = Licitacionesinformesdetalle.sum('valor_total', :conditions=>["licitacion_id = #{@licitacionesinforme.licitacion_id} and id != #{params[:id]}"]) rescue 0
    tot = params[:licitacionesinformesdetalle][:valor_total].to_f + valortotal.to_f
#    logger.error("Eerror " + valortotal.to_s)
#    logger.error("Eerror " + tot.to_s)
    if @licitacionesinforme.licitacion.valor_resolucion < tot
      render :update do |page|
        page.alert "La cantidad supera el valor del Subsidio. Verifique!! ($#{tot.to_i})"
      end
    else
      ok = licitacionesinformesdetalle.update_attributes(params[:licitacionesinformesdetalle])
      if ok == true
        flash[:licitacionesinformesdetalle] = "Actualizado con Exito"
        respond_to do |format|
          format.js { render :action => "licitacionesinformesdetalles" }
        end
      else
        render :update do |page|
          page.alert "El registro tiene inconsistencias. Verifique!!"
        end
      end
    end

#    flash[:licitacionesinformesdetalle] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
#    respond_to do |format|
#      format.js { render :action => "licitacionesinformesdetalles" }
#    end
  end


  def destroy
    licitacionesinformesdetalle   = Licitacionesinformesdetalle.find(params[:id])
    @licitacionesinforme  = licitacionesinformesdetalle.licitacionesinforme
    @licitacionesinformesdetalle  = Licitacionesinformesdetalle.new
    licitacionesinformesdetalle.destroy
    flash[:licitacionesinformesdetalle] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "licitacionesinformesdetalles" }
    end
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

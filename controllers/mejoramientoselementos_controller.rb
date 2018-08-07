class MejoramientoselementosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    mejoramiento   = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientoselementos = mejoramiento.mejoramientoselementos.all
  end

  def edit
    @mejoramientoselemento  = Mejoramientoselemento.find(params[:id], :include => "mejoramiento")
    @mejoramiento  = @mejoramientoselemento.mejoramiento
    respond_to do |format|
      format.js { render :action => "edit_mejoramientoselemento" }
    end
  end

  def buscar
    respond_to do |format|
       format.html
       format.xls if params[:format] == 'xls'
    end
  end

  def informe
    #logger.error("Aqui")
    @mejoramiento = Mejoramiento.find(params[:id])
    if params[:format] == 'xls'
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Presupuestos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
         format.xls
      end
    else
      respond_to do |format|
#        format.pdf do
#          render :pdf => 'foo',:save_to_file => Rails.root.join('public', "foo.pdf"),
#            :layout => 'report.html',
#       :save_only    => true
#        end
#
#        format.pdf do
#          render :pdf          => 'foo', :header => { :right => '[page] of [topage]' },
#       :print_media_type => true,
#       :page_size => "Letter",
#       :disposition => "inline"
#        end
#        format.pdf do
#        render :pdf => "#{@car.carname.name}",
#               :print_media_type => true
#      end
        format.html
      end
    end
  end

  def actacambioobra
    if params[:id2].to_i == 2
      @mejoramiento = Mejoramiento.find(params[:id])
      @mejoramiento.just_fecha = Time.now
      @mejoramiento.mejoramientosestado_id = 6
      @mejoramiento.save
      redirect_to edit_mejoramiento_path(@mejoramiento)
    else
      @mejoramiento = Mejoramiento.find(params[:id])
      respond_to do |format|
         format.html
      end
    end
  end

  def actaterminaobra
    if params[:id2].to_i == 2
      @mejoramiento = Mejoramiento.find(params[:id])
      @mejoramiento.just_terminacion_fecha = Time.now
      @mejoramiento.mejoramientosestado_id = 6
      @mejoramiento.save
      redirect_to edit_mejoramiento_path(@mejoramiento)
    else
      @mejoramiento = Mejoramiento.find(params[:id])
      respond_to do |format|
         format.html
      end
    end
  end

  def actareciboobra
    if params[:id2].to_i == 2
      @mejoramiento = Mejoramiento.find(params[:id])
      @mejoramiento.just_recibo_fecha = Time.now
      @mejoramiento.mejoramientosestado_id = 6
      @mejoramiento.save
      redirect_to edit_mejoramiento_path(@mejoramiento)
    else
      @mejoramiento = Mejoramiento.find(params[:id])
      respond_to do |format|
         format.html
      end
    end
  end
  
#  def actaaprobacionobra
#    @mejoramiento = Mejoramiento.find(params[:id])
#    respond_to do |format|
#       format.html
#    end
#  end

  def create
    @mejoramiento  = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientoselemento = Mejoramientoselemento.new(params[:mejoramientoselemento])
    @conveniosmejoramiento = Conveniosmejoramiento.find(:first, :conditions=>["convenio_id = #{@mejoramiento.convenio_id} and mejoramientositem_id = #{params[:mejoramientoselemento][:mejoramientositem_id]}"])
    @mejoramientoselemento.valor_unitario = @conveniosmejoramiento.valor_unitario
    @mejoramientoselemento.valor_total = @conveniosmejoramiento.valor_unitario.to_f * params[:mejoramientoselemento][:cantidad].to_f
    @mejoramientoselemento.user_id = is_admin
    if @mejoramientoselemento.valid?
      @mejoramiento.mejoramientoselementos << @mejoramientoselemento
      @mejoramiento.save
      is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientoselementos','I')
      @mejoramientoselemento = Mejoramientoselemento.new
      flash[:mejoramientoselemento] = "Registro almacenado con Exito"
    else
      flash[:mejoramientoselemento] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "mejoramientoselementos" }
    end
  end

  def update
    @mejoramientoselemento        = Mejoramientoselemento.new
    mejoramientoselemento         = Mejoramientoselemento.find(params[:id])
    params[:mejoramientoselemento][:user_actualiza] = is_admin
    #@conveniosmejoramiento = Conveniosmejoramiento.find(:first, :conditions=>["convenio_id = #{mejoramientoselemento.mejoramiento.convenio_id} and mejoramientositem_id = #{mejoramientoselemento.mejoramientositem_id}"])
    params[:mejoramientoselemento][:valor_unitario] = mejoramientoselemento.valor_unitario.to_f
    params[:mejoramientoselemento][:valor_total] = mejoramientoselemento.valor_unitario.to_f * params[:mejoramientoselemento][:cantidad].to_f
    @mejoramiento        = mejoramientoselemento.mejoramiento
    ok = mejoramientoselemento.update_attributes(params[:mejoramientoselemento])
    if ok == true
      is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientoselementos','A')
      flash[:mejoramientoselemento] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "mejoramientoselementos" }
      end
    else
      if @mejoramiento.calculo.to_s == "EJECUCION 2015"
        valorregmejora = Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id not in (10043,2)
                                                                                     and id != #{params[:id]}"]).to_i
      else
        valorregmejora = Mejoramientoselemento.sum('valor_total', :conditions=>["mejoramiento_id = #{mejoramientoselemento.mejoramiento_id}
                                                                                 and mejoramientositem_id != 10043
                                                                                 and id != #{params[:id]}"])
      end
      valordiag = @mejoramiento.valordiag
#      logger.error("valordiag - "+valordiag.to_s)
      if params[:mejoramientoselemento][:mejoramientositem_id].to_i !=  10043
        valortotal = valorregmejora.to_f + params[:mejoramientoselemento][:valor_total].to_f
      else
        valortotal = valorregmejora.to_f
      end
      #Calcula el 13%
      trece = @mejoramiento.valoradmin
      if @mejoramiento.calculo.to_s == "EJECUCION 2015"
        valortotal = valortotal.to_f
      else
        if params[:mejoramientoselemento][:mejoramientositem_id].to_i !=  10043
          valortotal = valortotal.to_f + trece.to_f + valordiag.to_f
        else
          valortotal = valortotal.to_f + trece.to_f + params[:mejoramientoselemento][:valor_total].to_f
        end
      end
      logger.error("a......total - "+valortotal.to_s)
      logger.error("valorregmejora - "+valorregmejora.to_s)
      logger.error("valorresolucion - "+mejoramientoselemento.mejoramiento.valor_resolucion.to_s)
      if valortotal.to_f > mejoramientoselemento.mejoramiento.valor_resolucion.to_f
        render :update do |page|
          page.alert "La cantidad supera el valor del Subsidio ($#{mejoramientoselemento.mejoramiento.valor_resolucion.to_f}). Verifique!! ($#{valortotal.to_i})"
        end
      else
        render :update do |page|
          page.alert "El registro tiene inconsistencias. Verifique!!"
        end
      end
    end
  end

  def destroy
    mejoramientoselemento   = Mejoramientoselemento.find(params[:id])
    @mejoramiento  = mejoramientoselemento.mejoramiento
    @mejoramientoselemento  = Mejoramientoselemento.new
    mejoramientoselemento.destroy
    respond_to do |format|
      format.js { render :action => "mejoramientoselementos" }
    end
  end

  private
  def determine_layout
    if ['informe','actacambioobra','actaterminaobra','actareciboobra','actaaprobacionobra'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

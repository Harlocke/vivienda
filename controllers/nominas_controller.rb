class NominasController < ApplicationController
before_filter :require_user
  layout :determine_layout

#  def index
#    @nominas = Nomina.all
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @nominas }
#    end
#  end

  def exenomina
    if params[:ubicacion][:periodosliquidacion_id].to_s == ""
      flash[:notice] = "No hay informacion del periodo para generar la Nomina. Verifique!!!"
      redirect_to parnomina_nominas_path
    else
      @nominas = Nomina.proceso(params[:ubicacion][:periodosliquidacion_id])
      periodosliquidacion = Periodosliquidacion.find(params[:ubicacion][:periodosliquidacion_id])
      @nominas = Nomina.all(:include => :empleado, :conditions => { :nominas => {:periodosliquidacion_id => params[:ubicacion][:periodosliquidacion_id]}}, :order=>"to_number(empleados.identificacion) ASC")
      @fechanomina = periodosliquidacion.nombreperiodo
      @periodoliq = params[:ubicacion][:periodosliquidacion_id]
      @nominasnovedades = Nominasnovedad.find(:all, :conditions => ['fecha_novedad between ? and ?', periodosliquidacion.fecha_inicial, periodosliquidacion.fecha_final])
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def gennomina
    periodosliquidacion = Periodosliquidacion.find(params[:periodo])
    periodosliquidacion.estado=0
    periodosliquidacion.save
    #Nomina.comprobante(params[:periodo])
    redirect_to parnomina_nominas_path
  end

  def enviarcomprobante
    Nomina.comprobante(params[:periodo])
    redirect_to parnomina_nominas_path
  end

  def consolidado
    if params[:ubicacion][:anno]
      @anno = params[:ubicacion][:anno]
      @nominas = Nomina.find_by_sql("select distinct empleado_id,
                                           sum(salario) salario,
                                           sum(subtotal) subtotal,
                                           sum(salud) salud,
                                           sum(pension) pension,
                                           sum(solidaridad) solidaridad,
                                           sum(retefuente) retefuente,
                                           sum(novedades) novedades,
                                           sum(total_deducciones) total_deducciones,
                                           sum(total_incapacidad) total_incapacidad,
                                           sum(otros_devengados) otros_devengados,
                                           sum(total) total
                                    from   nominas
                                    where  periodosliquidacion_id in (select id
                                                                      from   periodosliquidaciones
                                                                      where  to_char(fecha_final,'YYYY') = '#{params[:ubicacion][:anno]}')
                                    group by empleado_id")
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Consolidado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
         format.xls
      end
    else
      flash[:notice] = "No hay informacion del año para consultar. Verifique!!!"
      redirect_to parnomina_nominas_path
    end
  end

  def consulta
    if params[:ubicacion][:periodosliquidacion_id].to_s == ""
      flash[:notice] = "No hay informacion del periodo para consultar la Prenomina. Verifique!!!"
      redirect_to parnomina_nominas_path
    else
      periodosliquidacion = Periodosliquidacion.find(params[:ubicacion][:periodosliquidacion_id])
      @nominas = Nomina.all(:include => :empleado, :conditions => { :nominas => {:periodosliquidacion_id => params[:ubicacion][:periodosliquidacion_id]}}, :order=>"to_number(empleados.identificacion) ASC")
      @fechanomina = periodosliquidacion.nombreperiodo
      @periodoliq = params[:ubicacion][:periodosliquidacion_id]
      @nominasnovedades = Nominasnovedad.find(:all, :conditions => ['fecha_novedad between ? and ?', periodosliquidacion.fecha_inicial, periodosliquidacion.fecha_final])
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
    rescue
      if params[:id]
        periodosliquidacion = Periodosliquidacion.find(params[:id])
        @nominas = Nomina.all(:include => :empleado, :conditions => { :nominas => {:periodosliquidacion_id => params[:id]}}, :order=>"to_number(empleados.identificacion) ASC")
        @fechanomina = periodosliquidacion.nombreperiodo
        @periodoliq = params[:id]
        @nominasnovedades = Nominasnovedad.find(:all, :conditions => ['fecha_novedad between ? and ?', periodosliquidacion.fecha_inicial, periodosliquidacion.fecha_final])
        respond_to do |format|
           format.html
           format.xls if params[:format] == 'xls'
        end
      else
        flash[:notice] = "No hay informacion del periodo para consultar la Prenomina. Verifique!!!"
        redirect_to parnomina_nominas_path
      end
  end

  def consultaimp
    if params[:periodosliquidacion_id].to_s == ""
      flash[:notice] = "No hay informacion del periodo para consultar la Prenomina. Verifique!!!"
      redirect_to parnomina_nominas_path
    else
      periodosliquidacion = Periodosliquidacion.find(params[:periodosliquidacion_id])
      @nominas = Nomina.all(:include => :empleado, :conditions => { :nominas => {:periodosliquidacion_id => params[:periodosliquidacion_id]}}, :order=>"to_number(empleados.identificacion) ASC")
      @fechanomina = periodosliquidacion.nombreperiodo
      @periodoliq = params[:periodosliquidacion_id]
      @nominasnovedades = Nominasnovedad.find(:all, :conditions => ['fecha_novedad between ? and ?', periodosliquidacion.fecha_inicial, periodosliquidacion.fecha_final])
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def tirilla
    @nomina = Nomina.find_by_periodosliquidacion_id_and_empleado_id(params[:id], params[:id2])
    periodosliquidacion = Periodosliquidacion.find(@nomina.periodosliquidacion_id)
    @nominasnovedades = Nominasnovedad.find(:all, :conditions => ["empleado_id = #{@nomina.empleado_id} and fecha_novedad between '#{periodosliquidacion.fecha_inicial.to_date}' and '#{periodosliquidacion.fecha_final.to_date}'"])
  end

  def tirillamasiva
    @nominas = Nomina.all(:include => :empleado, :conditions => { :nominas => {:periodosliquidacion_id => params[:periodosliquidacion_id]}}, :order=>"to_number(empleados.identificacion) ASC")
  end

  def enviopersonal
    Nomina.comprobantepersona(params[:id], params[:id2])
    flash[:notice] = 'Enviado con Exito.'
  end

  def new
    @nomina = Nomina.new
    render :action => "nomina_form"
  end

  def edit
    @nomina = Nomina.find(params[:id])
    respond_to do |format|
      format.html { render :action => "nomina_form" }
    end
  end

  def create
    @nomina = Nomina.new(params[:nomina])
    if @nomina.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_nomina_path(@nomina)
    else
      render :action => "nomina_form"
    end
  end

  def update
    @nomina = Nomina.find(params[:id])
    if @nomina.update_attributes(params[:nomina])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      ActiveRecord::Base.connection.execute("update nominas set total_deducciones = (salud+pension+solidaridad+retefuente+novedades)
                                             where periodosliquidacion_id = #{@nomina.periodosliquidacion_id.to_i}")
      ActiveRecord::Base.connection.execute("update nominas set total = ((subtotal + otros_devengados + total_incapacidad)-total_deducciones)
                                             where periodosliquidacion_id = #{@nomina.periodosliquidacion_id.to_i}")
      redirect_to edit_nomina_path(@nomina)
    else
      flash[:notice] = "Error al realizar la actualizacion."
      render :action => "nomina_form"
    end
    rescue
     redirect_to edit_nomina_path(@nomina)
  end

  def destroy
    @nomina = Nomina.find(params[:id])
    @nomina.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to nominas_path
        }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['tirilla','consultaimp','tirillamasiva','consolidado'].include?(action_name)
      "tirilla"
    elsif['consolidado'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

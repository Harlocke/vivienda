class EstudiospreviosController < ApplicationController
  before_filter :require_user
  layout :determine_layout


  def index
    #if params[:search].to_s != "" or params[:searchn].to_s != ""
      @estudiosprevios = Estudiosprevio.search(params[:search],params[:searchn], params[:page])
#      if @estudiosprevios.count == 0
        #flash[:notice] = "No hay resultados de la consulta "+params[:search].to_s
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @estudiosprevios }
        end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="Estudios_Previos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @estudiosprevios = Estudiosprevio.searchcontratos(params[:ubicacion][:fchinicial], params[:ubicacion][:fchfinal])
    @fchinicial = params[:ubicacion][:fchinicial]
    @fchfinal   = params[:ubicacion][:fchfinal]
    respond_to do |format|
       format.xls
    end

  end

  def minuta
    @estudiosprevio = Estudiosprevio.find(params[:id])
  end

  def minutapdf
    @estudiosprevio = Estudiosprevio.find(params[:id])
    respond_to do |format|
      format.pdf  { render :layout => false }
    end
  end

  def buscar
    @estudiosprevios = Estudiosprevio.search(params[:identificacion],
                           params[:ubicacion][:tipoevacuacion],
                           params[:ubicacion][:categoriaisvimed],
                           params[:ubicacion][:fchinicial],
                           params[:ubicacion][:fchfinal],
                           params[:nroficha],
                           params[:ubicacion][:estudiospreviostiposevento_id]
                       )
    if @estudiosprevios.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_estudiosprevios_path
    elsif @estudiosprevios.count == 1 and params[:format] != 'xls'
      redirect_to edit_estudiosprevio_path(@estudiosprevios)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def new
    @estudiosprevio = Estudiosprevio.new
    render :action => "estudiosprevio_form"
  end

  def solicitarcontrato
    @estudiosprevio  = Estudiosprevio.find(params[:id])
    @correos = Sifi.find(6).valor.to_s
    begin
      Notifier.deliver_estudiosolicitud_message(@correos, @estudiosprevio)
      @estudiosprevio.estado = 'ENVIADO'
      @estudiosprevio.save
      rescue Exception => exc
         logger.error("SIFI ERROR solicitarcompromiso - Correo No enviado a #{@correos}")
    end
    flash[:notice] = "La solicitud de Contrato se ha enviado con exito"
    redirect_to edit_estudiosprevio_path(@estudiosprevio)
  end

  def ir
    @estudiosprevio  = Estudiosprevio.find(:first, :conditions=>["contrato_id = #{params[:id].to_i}"])
    redirect_to edit_estudiosprevio_path(@estudiosprevio)
  end

  def edit
    @estudiosprevio  = Estudiosprevio.find(params[:id])
    @estudiospreviosrubro = Estudiospreviosrubro.new
    @estudiosactividad = Estudiosactividad.new
    @estudiosmodificacion = Estudiosmodificacion.new
    respond_to do |format|
      format.html { render :action => "estudiosprevio_form" }
    end
  end

  def createcontrato
    last_id = Contrato.maximum('id')
    begin
      @contrato = Contrato.find(last_id)
      if @contrato.created_at.strftime("%Y") == Time.now.strftime("%Y")
        conse = @contrato.nro_contrato.to_i + 1
      else
        conse = '1'
      end
    rescue
      conse = '1'
    end
    @estudiosprevio  = Estudiosprevio.find(params[:id])
    if @estudiosprevio.estado.to_s == 'ENVIADO'
      @contrato = Contrato.new
      @contrato.empleado_id = @estudiosprevio.empleado_id
      @contrato.fecha_firma = @estudiosprevio.fecha_suscripcion
      @contrato.objeto = @estudiosprevio.objeto
      @contrato.plazo_dias = @estudiosprevio.dias.to_s
      @contrato.plazo_mes = @estudiosprevio.meses.to_s
      @contrato.valor_contrato = @estudiosprevio.valor_total
      @contrato.valor_mes = @estudiosprevio.valor_mes
      @contrato.fecha_inicio = @estudiosprevio.fecha_inicio
      @contrato.fecha_final = @estudiosprevio.fecha_fin
      @contrato.interventorempleado_id = @estudiosprevio.user_interventor
      @contrato.modalidad_id = @estudiosprevio.modalidad_id
      @contrato.tiposcontrato_id = @estudiosprevio.tiposcontrato_id
      @contrato.nro_disponibilidad = @estudiosprevio.nro_cdp
      @contrato.fecha_disponibilidad = @estudiosprevio.fecha_cdp
      @contrato.publicacion_cc = "NA"
      @contrato.publicacion_gazeta = "NA"
      @contrato.poliza = @estudiosprevio.poliza
      @contrato.publicacion_secop = @estudiosprevio.secop
      @contrato.abogadoempleado_id = @estudiosprevio.abogadoempleado_id
      @contrato.user_id = is_admin
      @contrato.nro_contrato = conse
      @contrato.estado = "P"
      @contrato.anticipo = @estudiosprevio.anticipo
      @contrato.pago_anticipado = @estudiosprevio.pago_anticipado
      @contrato.save
      last_id = Contrato.maximum('id')
      @estudiosprevio.estudiospreviosrubros.each do |estudiospreviosrubro|
        @contratosrubro = Contratosrubro.new
        @contratosrubro.contrato_id = last_id
        @contratosrubro.rubro_id = estudiospreviosrubro.rubro_id
        #@contratosrubro.posicion = estudiospreviosrubro.posicion
        @contratosrubro.valor = estudiospreviosrubro.valor
        @contratosrubro.user_id = is_admin
        @contratosrubro.save
      end
      @estudiosprevio.contrato_id = last_id
      @estudiosprevio.estado = "ASIGNADO"
      @estudiosprevio.save
      flash[:notice] = "El contrato se ha asignado con exito ... Nro de Contrato "+conse.to_s
      begin
        @correos = Sifi.find(33).valor.to_s  + User.find(@estudiosprevio.user_id).email rescue nil
        Notifier.deliver_estudioconfirma_message(@correos, @estudiosprevio, conse)
        rescue Exception => exc
           logger.error("SIFI ERROR estudioconfirma - Correo No enviado a #{@correos}")
      end
    else
      flash[:notice] = "Este contrato ya fue generadooo.. que pasa!!!"
    end
    redirect_to edit_empleado_path(@estudiosprevio.empleado_id)
  end

  def ver
    @estudiosprevio  = Estudiosprevio.find(params[:id])
  end

  def create
    @estudiosprevio = Estudiosprevio.new(params[:estudiosprevio])
    @estudiosprevio.user_id = is_admin
    @estudiosprevio.estado = 'PENDIENTE'
    if @estudiosprevio.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_estudiosprevio_path(@estudiosprevio)
    else
      render :action => "estudiosprevio_form"
    end
  end

  def update
    @estudiosprevio = Estudiosprevio.find(params[:id])
    @estudiosprevio.user_id = is_admin
    if @estudiosprevio.update_attributes(params[:estudiosprevio])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_estudiosprevio_path(@estudiosprevio)
    else
      @estudiospreviosrubro = Estudiospreviosrubro.new
      @estudiosactividad = Estudiosactividad.new
      @estudiosmodificacion = Estudiosmodificacion.new
      render :action => "estudiosprevio_form"
    end
    rescue
      redirect_to edit_estudiosprevio_path(@estudiosprevio)
  end

  def destroy
    @estudiosprevio = Estudiosprevio.find(params[:id])
    @estudiosprevio.destroy
    redirect_to busqueda_empleados_path
  end

  def show
    persona   = Persona.find(params[:estudiosprevio_id])
    @estudiosprevios = persona.estudiosprevios.all
  end

  def valormes
     valor = params[:valor].to_i  #valor digitado en la variable
     pvr2 = (valor.to_f / 30).to_f
     pvrmes = params[:pvrmes].to_i  #valor digitado en la variable meses
     pvrcant = params[:pvrcant].to_i  #valor digitado en la variable cantidad
     pvrdia = params[:pvrdia]  #valor digitado en la variable dias
     pvrtotal1 = (pvrdia.to_i * pvr2.round).to_f
     pvrtotal2 = (pvrmes.to_i * valor.round).to_f
     render :update do |page|
       page[:estudiosprevio_valor_dia][:value] = pvr2.round
       if pvrcant.to_i > 0
         page[:estudiosprevio_valor_total][:value] = pvrmes.to_f
       else
         page[:estudiosprevio_valor_total][:value] = (pvrtotal1.to_f + pvrtotal2.to_f)
       end
     end
  end

  def dias
     pvrdia = params[:valor]  #valor digitado en la variable dias
     valor  = params[:pvrdia]  #valor dia
     valormes = params[:pvr1]  #valor mes
     pvrmes = params[:pvr2].to_i  #valor digitado en la variable meses
     pvrcant = params[:pvrcant].to_i  #valor digitado en la variable cantidad
     pvrtotal1 = (pvrdia.to_i * valor.to_i).to_f
     pvrtotal2 = (pvrmes.to_i * valormes.to_i).to_f
     render :update do |page|
       if pvrcant.to_i > 0
         page[:estudiosprevio_valor_total][:value] = valormes.to_f
       else
         page[:estudiosprevio_valor_total][:value] = (pvrtotal1.to_f + pvrtotal2.to_f)
       end
     end
  end

  def meses
     pvrmes = params[:valor].to_i #valor digitado en la variable dias
     valor  = params[:pvrdia]  #valor dia
     valormes = params[:pvr1]  #valor mes
     pvrdia = params[:pvr2]  #valor digitado en la variable dias
     pvrtotal1 = (pvrdia.to_i * valor.to_i).to_f
     pvrtotal2 = (pvrmes.to_i * valormes.to_i).to_f
     pvrcant = params[:pvrcant].to_i  #valor digitado en la variable cantidad
     render :update do |page|
       if pvrcant.to_i > 0
         page[:estudiosprevio_valor_total][:value] = valormes.to_f
       else
         page[:estudiosprevio_valor_total][:value] = (pvrtotal1.to_f + pvrtotal2.to_f)
       end
       
     end
  end

  def cantidad
     pvrcant   = params[:valor].to_i
     valordia  = params[:pvrdia]  #valor dia
     valormes  = params[:pvr1]  #valor mes
     pvrdia    = params[:pvr2].to_i  #valor digitado en la variable dias
     pvrmes    = params[:pvr3].to_i  #valor digitado en la variable meses
     pvrtotal1 = (pvrdia.to_i * valordia.to_i).to_f
     pvrtotal2 = (pvrmes.to_i * valormes.to_i).to_f
     render :update do |page|
       if pvrcant.to_i > 0
         page[:estudiosprevio_valor_total][:value] = valormes.to_f
       else
         page[:estudiosprevio_valor_total][:value] = (pvrtotal1.to_f + pvrtotal2.to_f)
       end
     end
  end

  private
  def determine_layout
    if ['import','csv_import','pendientesentrega','notificapendiente','asignar','minuta','minutapdf'].include?(action_name)
      "atencion"
    elsif ['ver','solicitarcontrato'].include?(action_name)
      "vercontrato"
    elsif ['informe'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

class InterventoriasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def buscar
    @interventorias = Interventoria.search(params[:identificacion],params[:nombre])
    if @interventorias.count == 0
      flash[:notice] = "No hay resultados de la consulta "+params[:search].to_s
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @interventorias }
      end
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @interventorias }
      end
    end
  end

  def index
    user = User.find(is_admin)
    #user = User.find(12396)
    if user.identificacion.to_s != ""
      @empleado = Empleado.find_by_identificacion(user.identificacion)
      if Contrato.exists?(["interventorempleado_id = #{@empleado.id} and to_char(fecha_inicio,'YYYY') = to_char(trunc(sysdate),'YYYY')"]) == true
        @messageinterventor = "SI"
        #Verificacion de interventorias sin revision
        @interventorias = Interventoria.find(:all, :conditions=>["estado in ('REVISION','REVISIONFINALINT') and interventorempleado_id = #{@empleado.id}"], :order=>"updated_at asc")
      end
      if @empleado.tipo.to_s == 'V'
        @messagevinculado = 'SI'
      end
    else
      @message = "Atención: Su usuario del SIFI (#{user.username rescue nil}) no tiene numero de identificación asociada, contacte a Sistemas para actualizar el dato."
    end
    @interventoriasok = Interventoria.find(:all, :conditions=>["anno = to_char(trunc(sysdate),'YYYY') and estado in ('APROBADO','APROBADOGH')"], :order=>"updated_at asc")
    if permiso("interventoriagh","C").to_s == "S"
      @interventoriasgh = Interventoria.find(:all, :conditions=>["estado in ('APROBADO','REVISIONFINALGH')"], :order=>"updated_at asc")
    end
#    if permiso("interventoriacont","C").to_s == "S"
#      @interventoriascont = Interventoria.find(:all, :conditions=>["estado in ('APROBADOGH','APROBADOFINAL')"], :order=>"updated_at asc")
#    end
  end

  def new
    @interventoria = Interventoria.new
    @interventoria.contrato_id = params[:contrato_id]
    @interventoria.etapa = '1'
    render :action => "interventoria_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update interventorias set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end
    @interventoria = Interventoria.find(params[:id])
    respond_to do |format|
      format.html { render :action => "interventoria_form" }
    end
  end

  def revisioninter
    @interventoria = Interventoria.find(params[:id])
  end

  def revisionfinal
    @interventoria = Interventoria.find(params[:id])
  end

  def verificacionfinal
    @interventoria = Interventoria.find(params[:id])
  end

  def create
    @interventoria = Interventoria.new(params[:interventoria])
    @interventoria.user_id = is_admin
    if @interventoria.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_interventoria_path(@interventoria)
    else
      render :action => "interventoria_form"
    end
  end

  def update
    @interventoria = Interventoria.find(params[:id])
    @interventoria.user_actualiza = is_admin
      if @interventoria.update_attributes(params[:interventoria])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_interventoria_path(@interventoria)
      else
        #@interventoriasforma = Interventoriasforma.new
        render :action => "interventoria_form"
      end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_interventoria_path(@interventoria)
  end

  def destroy
    @interventoria = Interventoria.find(params[:id])
    @interventoria.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to interventorias_path
      }
      format.xml  { head :ok }
    end
  end
  
  def envio
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'REVISION'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - SE ENVIA PARA REVISION DEL INTERVENTOR")
    flash[:notice] = "El informe ha sido enviado para revisión"
    redirect_to interventorias_path
  end

  def enviofinalgh
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'REVISIONFINALGH'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - SE ENVIA PARA VALIDACION DEL SGSST")
    flash[:notice] = "El informe ha sido enviado para revisión"
    redirect_to interventorias_path
  end

  def aprobarint
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'REVISIONFINALGH'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME APROBADO POR EL INTERVENTOR")
    flash[:notice] = "El informe ha sido aprobado y enviado a validacion del SGSST"
    redirect_to interventorias_path
  end

  def rechazarint
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'RECHAZADOFINALINT'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME RECHAZADO POR EL INTERVENTOR")
    flash[:notice] = "El informe ha sido rechazado"
    redirect_to interventorias_path
  end  

  def enviofinalint
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'REVISIONFINALINT'
    @interventoria.save
    flash[:notice] = "El informe ha sido enviado para revisión"
    redirect_to interventorias_path    
  end

  def aprobar
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'APROBADO'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME APROBADO POR INTERVENTOR")
    flash[:notice] = "El informe ha sido Aprobado"
    begin
      user = User.find_by_identificacion_and_activo(@interventoria.contrato.empleado.identificacion,'S')
      if user
        Notifier.deliver_interventoria_message(@interventoria,user,'sendpendiente')
      end
      rescue Exception => exc
         logger.error("SIFI Correo NO enviado a #{user.email rescue nil}")
    end
    redirect_to interventorias_path
  end

  def rechazar
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'RECHAZADO'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME RECHAZADO POR INTERVENTOR")
    flash[:notice] = "El informe ha sido Rechazado"
    begin
      user = User.find_by_identificacion_and_activo(@interventoria.contrato.empleado.identificacion,'S')
      if user
        Notifier.deliver_interventoria_message(@interventoria,user,'sendrechazo')
      end
      rescue Exception => exc
         logger.error("SIFI Correo NO enviado a #{user.email rescue nil}")
    end
    redirect_to interventorias_path
  end

  def enviogh
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'APROBADO'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME ENVIADO AL SGSST")
    #Enviar mensaje de aprobadogh
    flash[:notice] = "El informe ha sido enviado para revisión"
    redirect_to interventorias_path
  end

  def aprobargh
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'APROBADOGH'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME VALIDADO POR EL SGSST")
    flash[:notice] = "El informe ha sido Aprobado"
    begin
      user = User.find_by_identificacion_and_activo(@interventoria.contrato.empleado.identificacion,'S')
      if user
        Notifier.deliver_interventoria_message(@interventoria,user,'sendaprobacion')
      end
      rescue Exception => exc
         logger.error("SIFI Correo NO enviado a #{user.email rescue nil}")
    end
    redirect_to interventorias_path
  end
  
  def rechazargh
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'RECHAZADOGH'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME RECHAZADO POR EL SGSST")
    begin
      user = User.find_by_identificacion_and_activo(@interventoria.contrato.empleado.identificacion,'S')
      if user
        Notifier.deliver_interventoria_message(@interventoria,user,'sendrechazog')
      end
      rescue Exception => exc
         logger.error("SIFI Correo NO enviado a #{user.email rescue nil}")
    end
    flash[:notice] = "El informe ha sido Rechazado"
    redirect_to interventorias_path
  end

  def aprobarghfinal
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'PENDIENTE'
    @interventoria.bloqueado = 'S'
    @interventoria.save
    ActiveRecord::Base.connection.execute("update interactividades set bloqueado = 'SI'
                                           where  interventoria_id = #{@interventoria.id}
                                           and    actividad like '%%PAGO%%DE%%SEGURIDAD%%SOCIAL%%'")
    flash[:notice] = "El informe ha sido Aprobado"
    #Enviar correo al usuario y a contabilidad
    begin
      user = User.find_by_identificacion_and_activo(@interventoria.contrato.empleado.identificacion,'S')
      if user
        Notifier.deliver_interventoria_message(@interventoria,user,'sendaprobacionfinalrh')
        valor = Sifi.find(87).valor.to_s
        Notifier.deliver_interventoriacontabilidad_message(@interventoria,valor,@interventoria.contrato.empleado.nombres)
      end
      rescue Exception => exc
         logger.error("SIFI Correo NO enviado a #{user.email rescue nil}")
    end
    redirect_to interventorias_path
  end

  def rechazarghfinal
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'RECHAZADOFINALGH'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME RECHAZADO POR EL SGSST")
    begin
      user = User.find_by_identificacion_and_activo(@interventoria.contrato.empleado.identificacion,'S')
      if user
        Notifier.deliver_interventoria_message(@interventoria,user,'sendrechazogfinal')
      end
      rescue Exception => exc
         logger.error("SIFI Correo NO enviado a #{user.email rescue nil}")
    end
    flash[:notice] = "El informe ha sido Rechazado"
    redirect_to interventorias_path
  end

  def aprobarcont
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'APROBADOCONT'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME APROBADO POR CONTABILIDAD")
    flash[:notice] = "El informe ha sido Aprobado"
    redirect_to interventorias_path
  end

  def rechazarcont
    @interventoria = Interventoria.find(params[:id])
    @interventoria.estado = 'RECHAZADOCONT'
    @interventoria.save
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>@interventoria.id, :observacion=>"#{@interventoria.bitacora.to_s } - INFORME RECHAZADO POR CONTABILIDAD")
    flash[:notice] = "El informe ha sido Rechazado"
    redirect_to interventorias_path
  end

  def actualizacionact
    ActiveRecord::Base.connection.execute("begin prc_interventoriapendientes(#{params[:id].to_i}); end;")
    flash[:notice] = "El informe de interventoria ha sido actualizado en sus actividades"
    redirect_to menus_path
  end

  def validar
    #logger.error("ingreso a validar")
    if Interventoria.exists?(["contrato_id =#{params[:contrato_id]} and anno = #{params[:ano]} and mes = #{params[:mes]}"])
      interventoria = Interventoria.find_by_anno_and_mes_and_contrato_id(params[:ano],params[:mes],params[:contrato_id])
      redirect_to edit_interventoria_path(:id => interventoria.id, :etapa => "1")
    else
      ActiveRecord::Base.connection.execute("begin prc_interventoriacargue(#{params[:contrato_id].to_i},'#{params[:ano].to_s}','#{params[:mes].to_s}',#{is_admin}); end;")
      interventoria = Interventoria.find_by_anno_and_mes_and_contrato_id(params[:ano],params[:mes],params[:contrato_id])
      Interbitacora.create(:user_id=>is_admin,:interventoria_id=>interventoria.id, :observacion=>"#{interventoria.bitacora.to_s } - SE CREA EL PROCESO")
      redirect_to edit_interventoria_path(:id => interventoria.id, :etapa => "1")
    end
  end

  def validaresp
    interventoria = Interventoria.find_by_anno_and_mes_and_contrato_id(params[:ano],params[:mes],params[:contrato_id])
    ActiveRecord::Base.connection.execute("begin prc_interventoriarecalculo(#{params[:contrato_id].to_i},'#{params[:ano].to_s}','#{params[:mes].to_s}',#{is_admin},#{interventoria.id}); end;")    
    redirect_to edit_interventoria_path(:id => interventoria.id, :etapa => "1")
  end

  def visualizar
    @interventoria = Interventoria.find_by_anno_and_mes_and_contrato_id(params[:ano],params[:mes],params[:contrato_id])
  end

  def borrar
    interventoria = Interventoria.find_by_anno_and_mes_and_contrato_id(params[:ano],params[:mes],params[:contrato_id])
    Interbitacora.create(:user_id=>is_admin,:interventoria_id=>interventoria.id, :observacion=>"#{interventoria.bitacora.to_s } - SE BORRA EL PROCESO")
    if interventoria.bloqueado.to_s == ""
      interventoria.destroy
      flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
    else
      flash[:notice] = "Informe bloqueado para eliminaciones"
    end;
    redirect_to interventorias_path
  end

  # 2015-11-03 Fabian Fernandez A.
  # Se modificaron todos lo observ_field con relacion a los parametros, de esta manera la programacion es la misma en todos,
  # se continua en la busqueda de mejoras mas este proceso

  def obs_salud
     pvr0 = params[:pvr0] # interventoria_valor_mes
     pvr1 = params[:pvr1] # interventoria_salud
     pvr2 = params[:pvr2] # interventoria_arl
     pvr3 = params[:pvr3] # interventoria_interes_credito
     pvr4 = params[:pvr4] # interventoria_salud_prepagada
     pvr5 = params[:pvr5] # interventoria_dependientes
     pvr6 = params[:pvr6] # interventoria_pension
     pvr7 = params[:pvr7] # interventoria_afc
     pvr8 = params[:pvr8] # interventoria_voluntarias
     subtotal  = (pvr1.to_i + pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
     subtotalr = (pvr6.to_i + pvr7.to_i + pvr8.to_i)
     valortotal = pvr0.to_i - (subtotal + subtotalr) 
     #(valormes - salud - arl - pension)
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     renta            = (valortotal * 25)/100.to_i
     base_retefuente  = valortotal - renta 
     base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
     vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
     retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     vlrbase384       = is_base384(base384.to_s)
     retefuente384    = (vlrbase384.to_f * is_retefuente384.to_f).to_f.round(-3).to_i
     if retefuente383.to_f > retefuente384.to_f
        total = pvr0.to_i - retefuente383.to_i
     else
        total = pvr0.to_i - retefuente384.to_i
     end

     render :update do |page|
       page[:interventoria_subtotal][:value]  = subtotal.to_s
       page[:interventoria_subtotalr][:value] = subtotalr.to_s
       page[:interventoria_subtotalt][:value] = valortotal.to_s
       page[:interventoria_renta][:value] = renta.to_s
       page[:interventoria_base_retefuente][:value] = base_retefuente.to_s
       page[:interventoria_base_uvt][:value] = base_uvt.to_s
       page[:interventoria_retefuente383][:value] = retefuente383.to_s
       page[:interventoria_retefuente384][:value] = retefuente384.to_s
       page[:interventoria_total][:value] = total.to_s
     end
  end

  def obs_arl
     pvr0 = params[:pvr0] # interventoria_valor_mes
     pvr1 = params[:pvr2] # interventoria_salud
     pvr2 = params[:pvr1] # interventoria_arl
     pvr3 = params[:pvr3] # interventoria_interes_credito
     pvr4 = params[:pvr4] # interventoria_salud_prepagada
     pvr5 = params[:pvr5] # interventoria_dependientes
     pvr6 = params[:pvr6] # interventoria_pension
     pvr7 = params[:pvr7] # interventoria_afc
     pvr8 = params[:pvr8] # interventoria_voluntarias
     subtotal  = (pvr1.to_i + pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
     subtotalr = (pvr6.to_i + pvr7.to_i + pvr8.to_i)
     valortotal = pvr0.to_i - (subtotal + subtotalr)
     #(valormes - salud - arl - pension)
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     renta            = (valortotal * 25)/100.to_i
     base_retefuente  = valortotal - renta
     base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
     vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
     retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     vlrbase384       = is_base384(base384.to_s)
     retefuente384    = (vlrbase384.to_f * is_retefuente384.to_f).to_f.round(-3).to_i
     if retefuente383.to_f > retefuente384.to_f
        total = pvr0.to_i - retefuente383.to_i
     else
        total = pvr0.to_i - retefuente384.to_i
     end
     render :update do |page|
       page[:interventoria_subtotal][:value]  = subtotal.to_s
       page[:interventoria_subtotalr][:value] = subtotalr.to_s
       page[:interventoria_subtotalt][:value] = valortotal.to_s
       page[:interventoria_renta][:value] = renta.to_s
       page[:interventoria_base_retefuente][:value] = base_retefuente.to_s
       page[:interventoria_base_uvt][:value] = base_uvt.to_s
       page[:interventoria_retefuente383][:value] = retefuente383.to_s
       page[:interventoria_retefuente384][:value] = retefuente384.to_s
       page[:interventoria_total][:value] = total.to_s
     end
  end

  def obs_interes_credito
     pvr0 = params[:pvr0] # interventoria_valor_mes
     pvr1 = params[:pvr2] # interventoria_salud
     pvr2 = params[:pvr3] # interventoria_arl
     pvr3 = params[:pvr1] # interventoria_interes_credito
     pvr4 = params[:pvr4] # interventoria_salud_prepagada
     pvr5 = params[:pvr5] # interventoria_dependientes
     pvr6 = params[:pvr6] # interventoria_pension
     pvr7 = params[:pvr7] # interventoria_afc
     pvr8 = params[:pvr8] # interventoria_voluntarias
     subtotal  = (pvr1.to_i + pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
     subtotalr = (pvr6.to_i + pvr7.to_i + pvr8.to_i)
     valortotal = pvr0.to_i - (subtotal + subtotalr)
     #(valormes - salud - arl - pension)
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     renta            = (valortotal * 25)/100.to_i
     base_retefuente  = valortotal - renta
     base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
     vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
     retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     vlrbase384       = is_base384(base384.to_s)
     retefuente384    = (vlrbase384.to_f * is_retefuente384.to_f).to_f.round(-3).to_i
     if retefuente383.to_f > retefuente384.to_f
        total = pvr0.to_i - retefuente383.to_i
     else
        total = pvr0.to_i - retefuente384.to_i
     end
     render :update do |page|
       page[:interventoria_subtotal][:value]  = subtotal.to_s
       page[:interventoria_subtotalr][:value] = subtotalr.to_s
       page[:interventoria_subtotalt][:value] = valortotal.to_s
       page[:interventoria_renta][:value] = renta.to_s
       page[:interventoria_base_retefuente][:value] = base_retefuente.to_s
       page[:interventoria_base_uvt][:value] = base_uvt.to_s
       page[:interventoria_retefuente383][:value] = retefuente383.to_s
       page[:interventoria_retefuente384][:value] = retefuente384.to_s
       page[:interventoria_total][:value] = total.to_s
     end
  end

  def obs_salud_prepagada
     pvr0 = params[:pvr0] # interventoria_valor_mes
     pvr1 = params[:pvr2] # interventoria_salud
     pvr2 = params[:pvr3] # interventoria_arl
     pvr3 = params[:pvr4] # interventoria_interes_credito
     pvr4 = params[:pvr1] # interventoria_salud_prepagada
     pvr5 = params[:pvr5] # interventoria_dependientes
     pvr6 = params[:pvr6] # interventoria_pension
     pvr7 = params[:pvr7] # interventoria_afc
     pvr8 = params[:pvr8] # interventoria_voluntarias
     subtotal  = (pvr1.to_i + pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
     subtotalr = (pvr6.to_i + pvr7.to_i + pvr8.to_i)
     valortotal = pvr0.to_i - (subtotal + subtotalr)
     #(valormes - salud - arl - pension)
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     renta            = (valortotal * 25)/100.to_i
     base_retefuente  = valortotal - renta
     base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
     vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
     retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     vlrbase384       = is_base384(base384.to_s)
     retefuente384    = (vlrbase384.to_f * is_retefuente384.to_f).to_f.round(-3).to_i
     if retefuente383.to_f > retefuente384.to_f
        total = pvr0.to_i - retefuente383.to_i
     else
        total = pvr0.to_i - retefuente384.to_i
     end
     render :update do |page|
       page[:interventoria_subtotal][:value]  = subtotal.to_s
       page[:interventoria_subtotalr][:value] = subtotalr.to_s
       page[:interventoria_subtotalt][:value] = valortotal.to_s
       page[:interventoria_renta][:value] = renta.to_s
       page[:interventoria_base_retefuente][:value] = base_retefuente.to_s
       page[:interventoria_base_uvt][:value] = base_uvt.to_s
       page[:interventoria_retefuente383][:value] = retefuente383.to_s
       page[:interventoria_retefuente384][:value] = retefuente384.to_s
       page[:interventoria_total][:value] = total.to_s
     end
  end

  def obs_dependientes
     pvr0 = params[:pvr0] # interventoria_valor_mes
     pvr1 = params[:pvr2] # interventoria_salud
     pvr2 = params[:pvr3] # interventoria_arl
     pvr3 = params[:pvr4] # interventoria_interes_credito
     pvr4 = params[:pvr5] # interventoria_salud_prepagada
     pvr5 = params[:pvr1] # interventoria_dependientes
     pvr6 = params[:pvr6] # interventoria_pension
     pvr7 = params[:pvr7] # interventoria_afc
     pvr8 = params[:pvr8] # interventoria_voluntarias
     subtotal  = (pvr1.to_i + pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
     subtotalr = (pvr6.to_i + pvr7.to_i + pvr8.to_i)
     valortotal = pvr0.to_i - (subtotal + subtotalr)
     #(valormes - salud - arl - pension)
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     renta            = (valortotal * 25)/100.to_i
     base_retefuente  = valortotal - renta
     base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
     vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
     retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     vlrbase384       = is_base384(base384.to_s)
     retefuente384    = (vlrbase384.to_f * is_retefuente384.to_f).to_f.round(-3).to_i
     if retefuente383.to_f > retefuente384.to_f
        total = pvr0.to_i - retefuente383.to_i
     else
        total = pvr0.to_i - retefuente384.to_i
     end
     render :update do |page|
       page[:interventoria_subtotal][:value]  = subtotal.to_s
       page[:interventoria_subtotalr][:value] = subtotalr.to_s
       page[:interventoria_subtotalt][:value] = valortotal.to_s
       page[:interventoria_renta][:value] = renta.to_s
       page[:interventoria_base_retefuente][:value] = base_retefuente.to_s
       page[:interventoria_base_uvt][:value] = base_uvt.to_s
       page[:interventoria_retefuente383][:value] = retefuente383.to_s
       page[:interventoria_retefuente384][:value] = retefuente384.to_s
       page[:interventoria_total][:value] = total.to_s
     end
  end

  def obs_pension
     pvr0 = params[:pvr0] # interventoria_valor_mes
     pvr1 = params[:pvr2] # interventoria_salud
     pvr2 = params[:pvr3] # interventoria_arl
     pvr3 = params[:pvr4] # interventoria_interes_credito
     pvr4 = params[:pvr5] # interventoria_salud_prepagada
     pvr5 = params[:pvr6] # interventoria_dependientes
     pvr6 = params[:pvr1] # interventoria_pension
     pvr7 = params[:pvr7] # interventoria_afc
     pvr8 = params[:pvr8] # interventoria_voluntarias
     subtotal  = (pvr1.to_i + pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
     subtotalr = (pvr6.to_i + pvr7.to_i + pvr8.to_i)
     valortotal = pvr0.to_i - (subtotal + subtotalr)
     #(valormes - salud - arl - pension)
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     renta            = (valortotal * 25)/100.to_i
     base_retefuente  = valortotal - renta
     base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
     vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
     retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     vlrbase384       = is_base384(base384.to_s)
     retefuente384    = (vlrbase384.to_f * is_retefuente384.to_f).to_f.round(-3).to_i
     if retefuente383.to_f > retefuente384.to_f
        total = pvr0.to_i - retefuente383.to_i
     else
        total = pvr0.to_i - retefuente384.to_i
     end
     render :update do |page|
       page[:interventoria_subtotal][:value]  = subtotal.to_s
       page[:interventoria_subtotalr][:value] = subtotalr.to_s
       page[:interventoria_subtotalt][:value] = valortotal.to_s
       page[:interventoria_renta][:value] = renta.to_s
       page[:interventoria_base_retefuente][:value] = base_retefuente.to_s
       page[:interventoria_base_uvt][:value] = base_uvt.to_s
       page[:interventoria_retefuente383][:value] = retefuente383.to_s
       page[:interventoria_retefuente384][:value] = retefuente384.to_s
       page[:interventoria_total][:value] = total.to_s
     end
  end

  def obs_afc
     pvr0 = params[:pvr0] # interventoria_valor_mes
     pvr1 = params[:pvr2] # interventoria_salud
     pvr2 = params[:pvr3] # interventoria_arl
     pvr3 = params[:pvr4] # interventoria_interes_credito
     pvr4 = params[:pvr5] # interventoria_salud_prepagada
     pvr5 = params[:pvr6] # interventoria_dependientes
     pvr6 = params[:pvr7] # interventoria_pension
     pvr7 = params[:pvr1] # interventoria_afc
     pvr8 = params[:pvr8] # interventoria_voluntarias
     subtotal  = (pvr1.to_i + pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
     subtotalr = (pvr6.to_i + pvr7.to_i + pvr8.to_i)
     valortotal = pvr0.to_i - (subtotal + subtotalr)
     #(valormes - salud - arl - pension)
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     renta            = (valortotal * 25)/100.to_i
     base_retefuente  = valortotal - renta
     base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
     vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
     retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     vlrbase384       = is_base384(base384.to_s)
     retefuente384    = (vlrbase384.to_f * is_retefuente384.to_f).to_f.round(-3).to_i
     if retefuente383.to_f > retefuente384.to_f
        total = pvr0.to_i - retefuente383.to_i
     else
        total = pvr0.to_i - retefuente384.to_i
     end
     render :update do |page|
       page[:interventoria_subtotal][:value]  = subtotal.to_s
       page[:interventoria_subtotalr][:value] = subtotalr.to_s
       page[:interventoria_subtotalt][:value] = valortotal.to_s
       page[:interventoria_renta][:value] = renta.to_s
       page[:interventoria_base_retefuente][:value] = base_retefuente.to_s
       page[:interventoria_base_uvt][:value] = base_uvt.to_s
       page[:interventoria_retefuente383][:value] = retefuente383.to_s
       page[:interventoria_retefuente384][:value] = retefuente384.to_s
       page[:interventoria_total][:value] = total.to_s
     end
  end

  def obs_voluntarias
     pvr0 = params[:pvr0] # interventoria_valor_mes
     pvr1 = params[:pvr2] # interventoria_salud
     pvr2 = params[:pvr3] # interventoria_arl
     pvr3 = params[:pvr4] # interventoria_interes_credito
     pvr4 = params[:pvr5] # interventoria_salud_prepagada
     pvr5 = params[:pvr6] # interventoria_dependientes
     pvr6 = params[:pvr7] # interventoria_pension
     pvr7 = params[:pvr8] # interventoria_afc
     pvr8 = params[:pvr1] # interventoria_voluntarias
     subtotal  = (pvr1.to_i + pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
     subtotalr = (pvr6.to_i + pvr7.to_i + pvr8.to_i)
     valortotal = pvr0.to_i - (subtotal + subtotalr)
     #(valormes - salud - arl - pension)
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     renta            = (valortotal * 25)/100.to_i
     base_retefuente  = valortotal - renta
     base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
     vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
     retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     vlrbase384       = is_base384(base384.to_s)
     retefuente384    = (vlrbase384.to_f * is_retefuente384.to_f).to_f.round(-3).to_i
     if retefuente383.to_f > retefuente384.to_f
        total = pvr0.to_i - retefuente383.to_i
     else
        total = pvr0.to_i - retefuente384.to_i
     end
     render :update do |page|
       page[:interventoria_subtotal][:value]  = subtotal.to_s
       page[:interventoria_subtotalr][:value] = subtotalr.to_s
       page[:interventoria_subtotalt][:value] = valortotal.to_s
       page[:interventoria_renta][:value] = renta.to_s
       page[:interventoria_base_retefuente][:value] = base_retefuente.to_s
       page[:interventoria_base_uvt][:value] = base_uvt.to_s
       page[:interventoria_retefuente383][:value] = retefuente383.to_s
       page[:interventoria_retefuente384][:value] = retefuente384.to_s
       page[:interventoria_total][:value] = total.to_s
     end
  end

# Calculo que me agrupa todo.... 2017-03-21
# Calculo que me agrupa todo.... 2017-03-21
# Calculo que me agrupa todo.... 2017-03-21
# Calculo que me agrupa todo.... 2017-03-21
# Calculo que me agrupa todo.... 2017-03-21
# Calculo que me agrupa todo.... 2017-03-21
# Calculo que me agrupa todo.... 2017-03-21

  def obs_calculofinal
    pvr0 = params[:pvr0] # interventoria_valor_mes
    pvr1 = params[:pvr1] # interventoria_salud
    pvr2 = params[:pvr2] # interventoria_arl
    pvr3 = params[:pvr3] # interventoria_interes_credito
    pvr4 = params[:pvr4] # interventoria_salud_prepagada
    pvr5 = params[:pvr5] # interventoria_dependientes
    pvr6 = params[:pvr6] # interventoria_pension
    pvr7 = params[:pvr7] # interventoria_afc
    pvr8 = params[:pvr8] # interventoria_voluntarias
    eltreinta = (pvr0.to_i * 0.3).to_i
    e = ""
    if (pvr7.to_i + pvr8.to_i + pvr6.to_i) >= eltreinta
      if pvr7.to_i > pvr8.to_i
        pvr7 = (eltreinta - (pvr8.to_i + pvr6.to_i))
        e = 'S'
      elsif pvr8.to_i > pvr7.to_i
        pvr8 = (eltreinta - (pvr7.to_i + pvr6.to_i))
        e = 'S'
      end
    end
    a = ""
    if pvr4.to_i >= 509744
      pvr4 = 509744.to_i
      a = 'S'
    end      
    b = ""
    if pvr3.to_i >= 3185900
      pvr3 = 3185900.to_i
      b = 'S'
    end      
    c = ""
    if pvr5.to_i >= 1019488
      pvr5 = 1019488.to_i
      c = 'S'
    end      
    vlrincr     = (pvr0.to_i - (pvr1.to_i + pvr6.to_i))
    subtotalr   = (pvr7.to_i + pvr8.to_i)
    subtotal    = (pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
    subtotalt   = vlrincr.to_i - subtotalr.to_i - subtotal.to_i
    renta       = (subtotalt * 25)/100.to_i
    total_rentas = renta.to_i + subtotalr.to_i + subtotal.to_i
    cuarenta = (vlrincr.to_i * 0.4).to_i
    if total_rentas > cuarenta.to_i
      total_rentas = cuarenta.to_i
    end
    base_retefuente  = vlrincr.to_i - total_rentas.to_i
    base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
    vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
    retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
    total            = pvr0.to_i - retefuente383.to_i    
    render :update do |page|
      page[:interventoria_valor_incr][:value] = vlrincr.to_s
      page[:interventoria_subtotalr][:value]  = subtotalr.to_s
      page[:interventoria_subtotal][:value]   = subtotal.to_s
      page[:interventoria_subtotalt][:value]  = subtotalt.to_s
      page[:interventoria_renta][:value]  = renta.to_s
      page[:interventoria_total_rentas][:value]  = total_rentas.to_s
      page[:interventoria_base_retefuente][:value]  = base_retefuente.to_s
      page[:interventoria_base_uvt][:value] = base_uvt.to_s
      page[:interventoria_retefuente383][:value] = retefuente383.to_s
      page[:interventoria_total][:value] = total.to_s
      if a == 'S'
        page[:interventoria_salud_prepagada][:value] = pvr4.to_s
      end
      if b == 'S'
        page[:interventoria_interes_credito][:value] = pvr3.to_s
      end
      if c == 'S'
        page[:interventoria_dependientes][:value] = pvr5.to_s
      end
      if e == 'S'
        page[:interventoria_afc][:value] = pvr7.to_s
        page[:interventoria_voluntarias][:value] = pvr8.to_s
      end
    end    
=begin
     subtotal  = (pvr1.to_i + pvr2.to_i + pvr3.to_i + pvr4.to_i + pvr5.to_i)
     subtotalr = (pvr6.to_i + pvr7.to_i + pvr8.to_i)
     valortotal = pvr0.to_i - (subtotal + subtotalr)
     #(valormes - salud - arl - pension)
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     renta            = (valortotal * 25)/100.to_i
     base_retefuente  = valortotal - renta
     base_uvt         = (base_retefuente.to_f/is_baseuvt.to_f).to_f.round(0).to_i
     vlr1             = ((is_restauvt(base_uvt).to_i * is_baseuvtpor(base_uvt)).to_f/100.to_f).to_f
     retefuente383    = (vlr1.to_f * is_retefuente383.to_f).to_f.round(-3).to_i
     base384          = (((pvr0.to_i - pvr1.to_i - pvr2.to_i - pvr6.to_i).to_f / is_retefuente384.to_f).to_f).round(2)
     vlrbase384       = is_base384(base384.to_s)
     retefuente384    = (vlrbase384.to_f * is_retefuente384.to_f).to_f.round(-3).to_i
     total = pvr0.to_i - retefuente384.to_i
=end     
  end


  def visualizarfinal
    @interventoria = Interventoria.find_by_anno_and_mes_and_contrato_id(params[:ano],params[:mes],params[:contrato_id])
    @estudiosactividades = Estudiosactividad.find(:all, :conditions=>["estudiosprevio_id = (select id from estudiosprevios where contrato_id = #{@interventoria.contrato_id})"])
    respond_to do |format|
      format.pdf  { render :layout => false }
    end
  end

  def verificacion
    @interventoria = Interventoria.find(params[:id])
  end

  private
  def determine_layout
    if ['visualizar','visualizarfinal','verificacion'].include?(action_name)
      "atencion"
    elsif['informeseguimiento'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end
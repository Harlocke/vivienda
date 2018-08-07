class Notifier < ActionMailer::Base

  def gmail_message(recipient, recipient1, recipient2)
    subject      'SIFI - Solicitud de Entrega de Vivienda'
    recipients   recipient.email
    reply_to     recipient.email
    from         'sistemas@isvimed.gov.co'
    body         :user => recipient, :vivienda => recipient1, :persona => recipient2
    content_type "text/html"
  end

  def comite_message(recipient, recipient1, recipient2, recipient3)
    subject      'SIFI - Informacion ' + recipient1.fecha.strftime("%Y-%m-%d").to_s + ' - ' + recipient1.comitestipo.descripcion rescue nil
    recipients   recipient.email
    reply_to     recipient.email
    from         'sistemas@isvimed.gov.co'
    body         :user => recipient, :comite => recipient1, :comitesactividades => recipient2, :comitesobservaciones =>recipient3
    content_type "text/html"
  end

  def invitacion_message(recipient, recipient1, recipient2)
    subject      'SIFI - Invitacion '+ recipient1.fecha.strftime("%Y-%m-%d").to_s + ' - ' + recipient1.comitestipo.descripcion rescue nil
    recipients   recipient.email
    reply_to     recipient.email
    from         'sistemas@isvimed.gov.co'
    body         :user => recipient, :comite => recipient1, :comitesresponsables => recipient2
    content_type "text/html"
  end

  def comitejefe_message(recipient, recipient1, recipient2, recipient3, recipient4)
    subject      'SIFI - Informacion ' + recipient1.fecha.strftime("%Y-%m-%d").to_s + ' - ' + recipient1.comitestipo.descripcion rescue nil
    recipients   recipient.email
    reply_to     recipient.email
    from         'sistemas@isvimed.gov.co'
    body         :user => recipient, :comite => recipient1, :comitesactividades => recipient2, :comitesobservaciones =>recipient3, :comitesusers => recipient4
    content_type "text/html"
  end

  def soporte_message(recipient, recipient1)
    subject      'SIFI - Requerimiento Soporte'
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :soporte => recipient1
    content_type "text/html"
  end

  def nomina_message(recipient, recipient1, recipient2,recipient3)
    subject      recipient2
    recipients   recipient1.email
    reply_to     recipient1.email
    from         'sistemas@isvimed.gov.co'
    body         :nomina => recipient, :empleado => recipient1, :nominasnovedades => recipient3
    content_type "text/html"
  end

  def archivo_message(recipient, recipient1)
    subject      'SIFI - Control de Prestamos Archivo'
    recipients   recipient.email
    reply_to     recipient.email
    from         'sistemas@isvimed.gov.co'
    body         :user => recipient, :archivosprestamos => recipient1
    content_type "text/html"
  end

  def compromiso_message(recipient, recipient1, recipient2)
    subject      'SIFI - Solicitud de Compromiso - '+recipient1.empleado.nombre.to_s
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :contrato => recipient1, :estudiosprevio => recipient2
    content_type "text/html"
  end

  def estudiosolicitud_message(recipient, recipient1)
    subject      'SIFI - Solicitud Contrato - '+recipient1.empleado.nombre.to_s
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :estudiosprevio => recipient1
    content_type "text/html"
  end

  def estudioconfirma_message(recipient, recipient1, recipient2)
    subject      'SIFI - Solicitud Contrato - '+recipient1.empleado.nombre.to_s
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :estudiosprevio => recipient1, :contrato => recipient2
    content_type "text/html"
  end

  def correspondencia_message(recipient, recipient1, recipient2)
    subject      'SIFI - Correspondencia pendiente'
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :correspondenciasrecibidas=> recipient1, :dependencia => recipient2
    content_type "text/html"
  end

  def personaslista_message(recipient, recipient1, recipient2)
    subject      'SIFI - Informe Revisión de Expedientes de Diagnostico'
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :personaslistas=> recipient1, :persona => recipient2
    content_type "text/html"
  end

  def titulacionesrechazo_message(recipient, recipient1, recipient2)
    subject      'SIFI - Documento rechazado cobama ' + recipient2
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :titulacionesdocumento => recipient1
    content_type "text/html"    
  end

  def titulacionesasignacion_message(recipient, recipient1)
    subject      'SIFI - Asignación de Reconocimiento: ' + recipient.nombre.to_s
    recipients   [recipient.email]
    reply_to     [recipient.email]
    from         'sistemas@isvimed.gov.co'
    body         :asigtemporales => recipient1, :user =>recipient
    content_type "text/html"
  end

  def soltransporte_message(recipient, recipient1, recipient2)
    subject      'SIFI - Asignación de Transporte ' + recipient.nombre.to_s
    recipients   [recipient.email,recipient2]
    reply_to     [recipient.email,recipient2]
    from         'sistemas@isvimed.gov.co'
    body         :vehiculosprogramacion => recipient1, :user =>recipient
    content_type "text/html"
  end

  def demandasasignacion_message(recipient, recipient1)
    subject      'SIFI - Asignación de Procesos Juridicos: ' + recipient.nombre.to_s
    recipients   [recipient.email]
    reply_to     [recipient.email]
    from         'sistemas@isvimed.gov.co'
    body         :asigdemandas => recipient1, :user =>recipient
    content_type "text/html"
  end

  def prestamosasignacion_message(recipient, recipient1)
    subject      'SIFI - Relación de Prestamos: ' + recipient.nombre.to_s
    recipients   [recipient.email]
    reply_to     [recipient.email]
    from         'sistemas@isvimed.gov.co'
    body         :asigprestamos => recipient1, :user =>recipient
    content_type "text/html"
  end

  def titulacionesrecordacion_message(recipient, recipient1)
    subject      'SIFI - Asignaciones pendientes: ' + recipient.nombre.to_s
    recipients   [recipient.email]
    reply_to     [recipient.email]
    from         'sistemas@isvimed.gov.co'
    body         :titulacionesasignaciones => recipient1, :user =>recipient
    content_type "text/html"
  end

  def titulacionesinforme_message(recipient, recipient1)
    subject      'SIFI - Informe de gestion procesos de titulacion'
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :temporales => recipient1
    content_type "text/html"
  end

  def titulacionesasignacionf_message(recipient, recipient1)
    subject      'SIFI - Asignación de Titulación Fiscal: ' + recipient.nombre.to_s
    recipients   [recipient.email]
    reply_to     [recipient.email]
    from         'sistemas@isvimed.gov.co'
    body         :asigfiscales => recipient1, :user =>recipient
    content_type "text/html"
  end

  def trasladatitulacionesobs_message(recipient, recipient1, recipient2)
    subject      'SIFI - Traslado de Tramite Cobama: ' + recipient2.to_s
    recipients   [recipient.email]
    reply_to     [recipient.email]
    from         'sistemas@isvimed.gov.co'
    body         :titulacionesobservacion => recipient1, :user =>recipient
    content_type "text/html"
  end

  def santaelenasasignacion_message(recipient, recipient1)
    subject      'SIFI - Asignación de Procesos Santa Elena: ' + recipient.nombre.to_s
    recipients   [recipient.email]
    reply_to     [recipient.email]
    from         'sistemas@isvimed.gov.co'
    body         :asigsantaelenas => recipient1, :user =>recipient
    content_type "text/html"
  end

  def correspondenciasrecibida_message(recipient, recipient1, recipient2)
    subject      'SIFI - Radicado recibido '+ recipient.nro_radicado
    recipients   [recipient1]
    reply_to     [recipient1]
    from         'sistemas@isvimed.gov.co'
    body         :correspondenciasrecibida => recipient, :dependencianombre => recipient2
    content_type "multipart/mixed"
    part 'text/html' do |p|
      p.body = render_message("correspondenciasrecibida_message", { :correspondenciasrecibida => recipient, :dependencianombre => recipient2 })
    end
    if Corresrecibidasimagen.exists?(["correspondenciasrecibida_id = #{recipient.id}"]) == true
      @corresrecibidasimagenes = Corresrecibidasimagen.find_all_by_correspondenciasrecibida_id(recipient.id)
      @corresrecibidasimagenes.each do |corresrecibidasimagen|
        attachment "#{corresrecibidasimagen.recibida_content_type}" do |a|
          a.content_disposition = "attachment"
          a.body = File.new("#{Rails.root}/public/system/recibidas/#{corresrecibidasimagen.id}/original/#{corresrecibidasimagen.recibida_file_name}",'rb').read()
          a.filename = "#{corresrecibidasimagen.recibida_file_name}"
        end
      end
    end
  end

  def queja_message(recipient, recipient1)
   subject      'SIFI - Atencion de PQRS'
   recipients   [recipient]
   reply_to     [recipient]
   from         'sistemas@isvimed.gov.co'
   body         :queja => recipient1
   content_type "text/html"
  end

  def interventoria_message(recipient, recipient1, recipient2)
    subject      'SIFI - Estado Informe Interventoria'
    recipients   [recipient1.email]
    reply_to     [recipient1.email]
    from         'sistemas@isvimed.gov.co'
    body         :interventoria => recipient, :variable =>recipient2
    content_type "text/html"
  end

  def interventoriacontabilidad_message(recipient, recipient1, recipient2)
    subject      'SIFI Informe - ' + recipient2
    recipients   [recipient1]
    reply_to     [recipient1]
    from         'sistemas@isvimed.gov.co'
    body         :interventoria => recipient
    content_type "text/html"
  end

  def trasladatitulacionesvisitaobs_message(recipient, recipient1, recipient2)
    subject      'SIFI - Traslado de Tramite Cobama: ' + recipient2.to_s
    recipients   [recipient.email]
    reply_to     [recipient.email]
    from         'sistemas@isvimed.gov.co'
    body         :titulacionesvisita => recipient1, :user =>recipient
    content_type "text/html"
  end

  def compromiso2_message(recipient, recipient1)
    subject      'SIFI - Solicitud de Compromiso - ' + recipient1.estudiosprevio.empleado.nombre.to_s
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :estudiosmodificacion => recipient1
    content_type "text/html"
  end

  def reqtransporte_message(recipient, recipient1)
    subject      'SIFI - Solicitud de Transporte ' + recipient.user.nombre.to_s
    recipients   [recipient1]
    reply_to     [recipient1]
    from         'sistemas@isvimed.gov.co'
    body         :vehiculossolicitud => recipient
    content_type "text/html"
  end

  def canctransporte_message(recipient, recipient1)
    subject      'SIFI - Estado Solicitud de Transporte'
    @correos = recipient.user.email
    if recipient.user1_id.to_s != ""
      @correos = @correos.to_s + ',' + User.find(recipient.user1_id).email.to_s
    end
    if recipient.user2_id.to_s != ""
      @correos = @correos.to_s + ',' + User.find(recipient.user2_id).email.to_s
    end
    if recipient.user3_id.to_s != ""
      @correos = @correos.to_s + ',' + User.find(recipient.user3_id).email.to_s
    end
    recipients   [@correos]
    reply_to     [@correos]
    from         'sistemas@isvimed.gov.co'
    body         :vehiculossolicitud => recipient, :variable =>recipient1
    content_type "text/html"
  end

  def radicacion_message(recipient, recipient1, recipient2)
    subject      'SIFI - Correspondencia Interna Nro. ' + recipient1.consecutivo.to_s
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :correspondenciasinterna => recipient1, :calidadversion => recipient2
    content_type "text/html"
  end

  def notificajefe_message(recipient)
    subject      'SIFI - Requerimiento Soporte Atendido'
    recipients   ['cesar.castano@isvimed.gov.co']
    reply_to     ['cesar.castano@isvimed.gov.co']
    from         'sistemas@isvimed.gov.co'
    body         :soporte => recipient
    content_type "text/html"
  end

  def pendiente_message(recipient,recipient1)
    subject      'SIFI - Compromiso asignado'
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :pendiente => recipient1
    content_type "text/html"
  end
  
  def pendientesmasivo_message(recipient,recipient1)
   subject      'SIFI - Compromiso asignado'
   recipients   [recipient1]
   reply_to     [recipient1]
   from         'sistemas@isvimed.gov.co'
   body         :pendientes => recipient
   content_type "text/html"
 end
 
  def pendientesnota_message(recipient,recipient1)
    subject      'SIFI - Seguimiento Registrado'
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :pendientesnota => recipient1
    content_type "text/html"
  end
 
  def actainterventoria_message(recipient,recipient1)
    subject      'SIFI - Asignación de Interventoria'
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :contrato => recipient1
    content_type "text/html"
  end  

  def solicitudvisita_message(recipient,recipient1,recipient2,recipient3)
    subject      'SIFI - Solicitud Visita Tecnica - '+ recipient2.to_s
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :viviendasusada => recipient1, :nombre =>recipient2, :solicitante =>recipient3
    content_type "text/html"
  end 

  def notificacionweb_message(recipient,recipient1)
    subject      'SIFI - Confirmacion de PQRSD recibidas'
    recipients   [recipient]
    reply_to     [recipient]
    from         'sistemas@isvimed.gov.co'
    body         :queja => recipient1
    content_type "text/html"
  end  

end



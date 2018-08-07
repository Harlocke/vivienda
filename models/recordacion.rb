class Recordacion < ActiveRecord::Base

  def e_titulacion
    #Notificaciones para todos
    @temporales = Temporal.find_by_sql(["select distinct user_id
                                         from   titulacionesasignaciones
                                         where  fecha_fin is null
                                         and    tipo is not null
                                         group by user_id"])
    @temporales.each do  |temporal|
      @titulacionesasignaciones = Titulacionesasignacion.find(:all, :conditions=>["user_id = #{temporal.user_id} and tipo is not null and fecha_fin is null"])
      @user = User.find(temporal.user_id)
      begin
        Notifier.deliver_titulacionesrecordacion_message(@user,@titulacionesasignaciones)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{@user.email rescue nil}")
      end
    end
    #Recordacion al jefe
    @temporales = Temporal.find_by_sql(["select distinct t.tipo, u.nombre, count(t.id) cant
                                         from   titulacionesasignaciones t, users u
                                         where  t.fecha_fin is null
                                         and    t.tipo is not null
                                         and    t.user_id = u.id
                                         group by t.tipo, u.nombre order by u.nombre"])
    @correos = Sifi.find(35).valor.to_s
    begin
      Notifier.deliver_titulacionesinforme_message(@correos,@temporales)
      rescue Exception => exc
         logger.error("SIFI Correo NO titulacionesinforme_message ")
    end
  end

  def e_correspondenciasrecibidas
    @dependencias = Dependencia.all
    @dependencias.each do |dependencia|
      @correspondenciasrecibidas = Correspondenciasrecibida.find_by_sql("
        select distinct r.correspondenciasclase_id,
               r.nro_radicado,
               r.asunto,
               r.created_at,
               r.fecha_limite,
               r.correspondenciasremitente_id,
               r.persona_id,
               (select nombre from users where id in (select user_id from correspondenciasrecibidasusers where correspondenciasrecibida_id = r.id and rownum = 1)) usuarioasignado
        from   correspondenciasasignadas c, correspondenciasrecibidas r, dependenciasusers d
        where  d.dependencia_id = #{dependencia.id}
        and    d.dependencia_id = r.dependencia_id
        and    c.user_id =  d.user_id
        and    c.correspondenciasrecibida_id = r.id
        and    r.fecha_limite <= (trunc(sysdate)+4)
        and    r.id not in (select correspondenciasrecibida_id from correspondenciasradicados)
        and    r.respuesta = 'NO'
        order by r.correspondenciasclase_id")
      if @correspondenciasrecibidas.count > 0
        @correos = dependencia.depcorreo rescue nil
        begin
          @correos = @correos.to_s + Sifi.find(23).valor.to_s
          Notifier.deliver_correspondencia_message(@correos, @correspondenciasrecibidas, dependencia)
          #logger.error("SIFI correspondencia_message - Correo enviado a #{@correos}")
          rescue Exception => exc
             logger.error("SIFI correspondencia_message - Correo No enviado a #{@correos}")
        end
      end
    end
  end

  def e_correspondenciamasiva
    @dependencias = Dependencia.all
    @dependencias.each do |dependencia|
      @correos = dependencia.depcorreo rescue nil
      @dependencianombre = dependencia.descripcion rescue nil
      if @correos.to_s != ""
        @correspondenciasrecibidas = Correspondenciasrecibida.find(:all, :conditions=>["dependencia_id = #{dependencia.id} 
                                                                                        and user_envio is null
                                                                                        and trunc(created_at) >= to_date('03-03-2015','dd-mm-yyyy')"])
        @correspondenciasrecibidas.each do |correspondenciasrecibida|
          if correspondenciasrecibida.corresrecibidasimagenes.exists? == true
            if @correos.to_s != ""
              begin
                #ActiveRecord::Base.connection.execute("insert into error values ('radicado..'||' '||#{correspondenciasrecibida.nro_radicado.to_s}||' - Fecha '||'#{correspondenciasrecibida.created_at.strftime("%Y-%m-%d")}')")
                Notifier.deliver_correspondenciasrecibida_message(correspondenciasrecibida, @correos, @dependencianombre)
                ActiveRecord::Base.connection.execute("update correspondenciasrecibidas set fechaenvio = sysdate, user_envio = 10002 where id = #{correspondenciasrecibida.id}")
                sleep 8
                rescue Exception => exc
                  logger.error("*** SIFI ERROR correspondenciasrecibida - Correo NO enviado a #{@correos}")
              end
            end
          end
        end
        @correos = ""
      end
    end
  end

#  def e_pendiente
#    "control_int,planeacion,administrativa,poblacional,juridica,dotacion,comunicaciones,direccion".split(",").map { |s|      
#      if Pendiente.exists?(["#{s.to_s} = 'SI' and estado in ('PENDIENTE','EN TRAMITE')"]) 
#        if s.to_s == 'control_int'
#          @correos = Mensaje.find(78).asignadoscorreos.to_s
#        elsif s.to_s == 'planeacion'
#          @correos =  Mensaje.find(77).asignadoscorreos.to_s
#        elsif s.to_s == 'administrativa'
#          @correos =  Mensaje.find(76).asignadoscorreos.to_s
#        elsif s.to_s == 'poblacional'
#          @correos =  Mensaje.find(101).asignadoscorreos.to_s
#        elsif s.to_s == 'juridica'
#          @correos =  Mensaje.find(74).asignadoscorreos.to_s
#        elsif s.to_s == 'dotacion'
#          @correos =  Mensaje.find(72).asignadoscorreos.to_s
#        elsif s.to_s == 'comunicaciones'
#          @correos =  Mensaje.find(71).asignadoscorreos.to_s
#        elsif s.to_s == 'direccion'
#          @correos =  Mensaje.find(70).asignadoscorreos.to_s
#        end
#        @pendientes = Pendiente.find(:all, :conditions=>["#{s.to_s} = 'SI' and estado in ('PENDIENTE','EN TRAMITE')"])
#        begin
#          Notifier.deliver_pendientesmasivo_message(@pendientes,@correos) 
#          sleep 5
#          rescue Exception => exc
#            logger.error("---------------------------------------------------------------")
#            logger.error(Time.now.strftime("%Y-%m-%d").to_s + " ....No ENVIADO "+s.to_s)
#            logger.error("---------------------------------------------------------------")
#        end
#      else
#        logger.error("-------------------------------------------------------------------------")
#        logger.error(Time.now.strftime("%Y-%m-%d").to_s + " ....No tienen pendientes "+s.to_s)
#        logger.error("-------------------------------------------------------------------------")
#      end
#    }    
#  end
end

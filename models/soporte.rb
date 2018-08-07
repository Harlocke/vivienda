class Soporte < ActiveRecord::Base
  belongs_to :user
  has_many :soportesactividades
  has_many :mensajesenvios

  validates_presence_of :descripcion, :tipo_requerimiento

  def self.mensaje(soporte)
    dat = ""  
    if soporte.identificacion_jefe.to_s != "" and soporte.identificacion_beneficario.to_s != ""
      ActiveRecord::Base.connection.execute("begin prc_persona('#{soporte.identificacion_jefe.to_s.strip}','#{soporte.identificacion_beneficario.to_s.strip}'); end;")
      objetos = Objeto.find_by_sql(["select descripcion dato from error"])
      objetos.each do |objeto|
        if objeto.dato.to_s == 'OK'
          dat = 'OK'
        else
          dat = dat + ' - ' + objeto.dato.to_s rescue nil
        end
      end
      sa = Soportesactividad.new
      sa.soporte_id = soporte.id 
      sa.solucionado = '1'
      if dat.to_s == 'OK'
        sa.observacion = 'SE REALIZA LA UNIFICACION SOLICITADA DE MANERA CORRECTA'
      else
        sa.observacion = 'NO SE LOGRA REALIZAR LA UNIFICACION DEBIDO AL SIGUIENTE ERROR: ' + dat.upcase.to_s
      end
      sa.user_id = 10002
      sa.save      
    end
    if dat == ""
      # Para registro de los tickets enviados
      u  = Mensajesenvio.new
      cadena = "REGISTRO TICKET NRO.  "
      cadena = cadena + soporte.id.to_s
      cadena = cadena + ' ('+ soporte.descripcion.to_s+')'
      ActiveRecord::Base.connection.execute("insert into mensajesenvios (id,user_id,descripcion,estado,created_at,updated_at)
                                             values (mensajesenvios_seq.nextval,#{soporte.user_id},'#{cadena}','I',sysdate,sysdate)")
      correos = ""
      if soporte.tipo_requerimiento == 1
        users  = User.find(:all, :conditions => ['id in (select user_id from mensajesusers where mensaje_id = 61)'])
        users.each do |x|
          if correos == ""
            correos = x.email.to_s
          else
            correos = correos.to_s + ',' + x.email.to_s
          end          
        end
        Notifier.deliver_soporte_message(correos, soporte)
      elsif soporte.tipo_requerimiento == 2
        users  = User.find(:all, :conditions => ['id in (select user_id from mensajesusers where mensaje_id = 41)'])
        users.each do |x|
          if correos == ""
            correos = x.email.to_s
          else
            correos = correos.to_s + ',' + x.email.to_s
          end          
        end
        Notifier.deliver_soporte_message(correos, soporte)
      else soporte.tipo_requerimiento == 3
        users  = User.find(:all, :conditions => ['id in (select user_id from mensajesusers where mensaje_id = 141)'])
        users.each do |x|
          if correos == ""
            correos = x.email.to_s
          else
            correos = correos.to_s + ',' + x.email.to_s
          end          
        end
        Notifier.deliver_soporte_message(correos, soporte)
      end
    end
  end

  def self.search(soporte, fchinicial, fchfinal, solucionado, funcionario)
      solu = "1"
      cadena = ""
      if fchinicial != "" and fchfinal != ""
        if cadena != ""
          cadena = cadena + ' and trunc(created_at) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
        else
          cadena = ' trunc(created_at) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
        end
      end
      if solucionado.to_s != ""
        if solucionado.to_s == "1"
          if cadena != ""
            cadena = cadena + ' and id in (select soporte_id from soportesactividades where solucionado = ' + solucionado.to_s.strip + ')'
          else
            cadena = ' id in (select soporte_id from soportesactividades where solucionado = ' + solucionado.to_s.strip + ')'
          end
        else
          if cadena != ""
            cadena = cadena + ' and (id in (select soporte_id from soportesactividades where solucionado = ' + solucionado.to_s.strip + ')
                                or id not in (select soporte_id from soportesactividades))
                                and id not in (select soporte_id from soportesactividades where solucionado = 1)'
          else
            cadena = ' (id in (select soporte_id from soportesactividades where solucionado = ' + solucionado.to_s.strip + ')
                       or id not in (select soporte_id from soportesactividades))
                       and id not in (select soporte_id from soportesactividades where solucionado = 1 )'
          end
        end
      end
      if funcionario.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id in (select soporte_id from soportesactividades where user_id = ' + funcionario.to_s + ')'
        else
          cadena = ' id in (select soporte_id from soportesactividades where user_id = ' + funcionario.to_s + ')'
        end
      end
      if soporte.user_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and user_id = ' + soporte.user_id.to_s
        else
          cadena = ' user_id = ' + soporte.user_id.to_s
        end
      end
      if soporte.tipo_requerimiento.to_s != ""
        if cadena != ""
          cadena = cadena + ' and tipo_requerimiento = ' + soporte.tipo_requerimiento.to_s
        else
          cadena = ' tipo_requerimiento = ' + soporte.tipo_requerimiento.to_s
        end
      end
      if soporte.prioridad.to_s != ""
        if cadena != ""
          cadena = cadena + ' and prioridad = ' + soporte.prioridad.to_s
        else
          cadena = ' prioridad = ' + soporte.prioridad.to_s
        end
      end
      if soporte.tipo.to_s != ""
        if cadena != ""
          cadena = cadena + ' and tipo = ' + soporte.tipo.to_s
        else
          cadena = ' tipo = ' + soporte.tipo.to_s
        end
      end
      if soporte.descripcion != ""
        if cadena != ""
          s = soporte.descripcion.upcase
          cadena = cadena + ' and upper(descripcion) like '+ "'%%#{s.to_s}%%'"
        else
          s = soporte.descripcion.upcase
          cadena = ' upper(descripcion) like '+ "'%%#{s.to_s}%%'"
        end
      end
      if soporte.id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id = ' + soporte.id.to_s
        else
          cadena = ' id = ' + soporte.id.to_s
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end

end

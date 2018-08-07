class Archivosprestamo < ActiveRecord::Base
  belongs_to :archivo

  def calculatiempo
    minutosmas = 5 * 86400
    fechaprog = (Time.now + minutosmas.to_i)
    cantidad = Festivo.count(:conditions =>['fecha between ? and ?', Time.now, fechaprog])
    if cantidad > 0
      minutosadd = cantidad.to_i * 86400
      fechaprogramacion = Time.now + minutosmas.to_i + minutosadd.to_i
      fecha = fechaprogramacion.strftime("%Y-%m-%d")
      cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
      while cantidad1.to_i > 0
        fechaprogramacion = fechaprogramacion + 86400
        fecha = fechaprogramacion.strftime("%Y-%m-%d")
        cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
      end
    else
      fechaprogramacion = (Time.now + minutosmas.to_i)
      fecha = fechaprogramacion.strftime("%Y-%m-%d")
      cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
      while cantidad1.to_i > 0
        fechaprogramacion = fechaprogramacion + 86400
        fecha = fechaprogramacion.strftime("%Y-%m-%d")
        cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
      end
    end
    return fechaprogramacion
  end

  def self.searchprestamo (userid, userprestamo, fchinicial, fchfinal, devolfchinicial, devolfchfinal, userdevol, page, perpage)
    cadena = ""
    if userid.to_s != ""
      if fchinicial.to_s != "" and fchfinal.to_s != ""
        cadena = cadena + ' userregistro = '+ "'#{userid}'" +' and trunc(created_at) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      else
        cadena = cadena + ' userregistro = '+ "'#{userid}'"
      end
    elsif userprestamo.to_s != ""
      if fchinicial.to_s != "" and fchfinal.to_s != ""
        cadena = cadena + ' userprestamo = '+ "'#{userprestamo}'" +' and trunc(created_at) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      else
        cadena = cadena + ' userprestamo = '+ "'#{userprestamo}'"
      end
    elsif userdevol.to_s != ""
      if devolfchinicial.to_s != "" and devolfchfinal.to_s != ""
        cadena = cadena + ' userdevolucion = '+ "'#{userprestamo}'" +' and trunc(fecha_devolucion) between ' + "'#{devolfchinicial}'" + ' and ' + "'#{devolfchfinal}'"
      else
        cadena = cadena + ' userdevolucion = '+ "'#{userprestamo}'"
      end
    elsif fchinicial.to_s != "" and fchfinal.to_s != ""
       cadena = cadena + ' trunc(created_at) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
    end
    if devolfchinicial.to_s != "" and devolfchfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(fecha_devolucion) between ' + "'#{devolfchinicial}'" + ' and ' + "'#{devolfchfinal}'"
        else
          cadena = cadena + ' trunc(fecha_devolucion) between ' + "'#{devolfchinicial}'" + ' and ' + "'#{devolfchfinal}'"
        end
      end
    if cadena != ""
      paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "created_at desc"
    else
      paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at desc"
    end
  end

  def self.searchpazysalvo(userprestamo, page)
        paginate :per_page => 14,
                 :page => page,
                 :conditions => ['id in (select ap.id 
                                       from archivosprestamos ap, archivos a 
                                       where a.id = ap.archivo_id
                                       and ap.fecha_devolucion is null
                                       and ap.userprestamo = ' + "'#{userprestamo}'" + ')'],
                 :order => 'created_at desc'
  end
  
  def userprestamoname
    return User.find(self.userprestamo).nombre rescue nil
  end

  def userregistroname
    return User.find(self.userregistro).username rescue nil
  end

  def userdevolucionname
    return User.find(self.userdevolucion).username rescue nil
  end

  def beneficiarioprestamo
    cadena = ""
    cadena2 = ""
    @archivospersonas = Archivospersona.find_all_by_archivo_id(self.archivo_id);
    if @archivospersonas
      for archivospersona in @archivospersonas
        if cadena != ""
          cadena = cadena + ' - ' + archivospersona.persona.autobuscar rescue nil
        else
          cadena = archivospersona.persona.autobuscar rescue nil
        end
      end
    end
    @archivosempleados = Archivosempleado.find_all_by_archivo_id(self.archivo_id);
    if @archivosempleados
      for archivosempleado in @archivosempleados
        if cadena != ""
         cadena = cadena + ' - ' + archivosempleado.empleado.autobuscar rescue nil
        else
         cadena = archivosempleado.empleado.autobuscar rescue nil
        end
      end
    end
    return cadena
  end

  def after_create
    cadena = "SR(A) " + self.userprestamoname.to_s + ". SE NOTIFICA EL PRESTAMO DE CARPETA CORRESPONDIENTE AL BENEFICIARIO(S): " + self.beneficiarioprestamo.to_s + " - DEL BARRIO " + self.archivo.barrio.to_s + ". RECUERDE QUE EL VENCIMIENTO DEL PRESTAMO ES : " + self.fecha_vence.to_s
    ActiveRecord::Base.connection.execute(
      "insert into mensajesenvios (id,user_id,descripcion,estado,archivosprestamo_id,created_at,updated_at)
       values (mensajesenvios_seq.nextval,#{self.userprestamo},'#{cadena}','C',#{self.id},sysdate,sysdate)")
  end

  def deletemensajeenvio
    ActiveRecord::Base.connection.execute(
      "delete from mensajesenvios where user_id = #{self.userprestamo} and estado = 'C' and archivosprestamo_id = #{self.id}")
  end

  def mensajeaplaza
    cadena = "SR(A) " + self.userprestamoname.to_s + ". SE NOTIFICA EL APLAZAMIENTO DEL PRESTAMO DE LA CARPETA CORRESPONDIENTE AL BENEFICIARIO(S): " + self.beneficiarioprestamo.to_s + " - DEL BARRIO " + self.archivo.barrio.to_s + ". RECUERDE QUE EL VENCIMIENTO DEL PRESTAMO ES : " + self.fecha_vence.to_s
    ActiveRecord::Base.connection.execute(
      "insert into mensajesenvios (id,user_id,descripcion,estado,archivosprestamo_id,created_at,updated_at)
       values (mensajesenvios_seq.nextval,#{self.userprestamo},'#{cadena}','C',#{self.id},sysdate,sysdate)")
  end

  def mensajereturn
    cadena = "SR(A) " + self.userprestamoname.to_s + ". SE NOTIFICA EL RECIBO DE LA CARPETA CORRESPONDIENTE AL BENEFICIARIO(S): " + self.beneficiarioprestamo.to_s + " - DEL BARRIO " + self.archivo.barrio.to_s
    ActiveRecord::Base.connection.execute(
      "insert into mensajesenvios (id,user_id,descripcion,estado,archivosprestamo_id,created_at,updated_at)
       values (mensajesenvios_seq.nextval,#{self.userprestamo},'#{cadena}','C',#{self.id},sysdate,sysdate)")
  end

end

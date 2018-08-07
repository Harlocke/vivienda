class Titulacionesprestamo < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :user

  #alias_attribute :user_id, :userprestamo
  #validates_presence_of :user_nombre
  validates_presence_of :userprestamo


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

  def self.searchprestamo (userid, userprestamo, fchinicial, fchfinal, devolfchinicial, devolfchfinal)
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
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end

#  def user_nombre
#    user.nombre if user
#  end
#
#  def user_nombre=(nombre)
#    logger.error("1ingreso..."+nombre.to_s)
#    self.user = User.find_or_create_by_nombre(nombre) unless nombre.blank?
#    self.userprestamo = self.user.id
#    logger.error("2ingreso..."+self.user.id.to_s)
#  end

#  def persona_autobuscar
#    persona.autobuscar if persona
#  end
#
#  def persona_autobuscar=(autobuscar)
#    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
#  end


end


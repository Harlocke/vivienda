class Titulacionesasignacion < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :user

  def self.search (userid,fchinicial,fchfinal)
    cadena = ""
    if userid != ""
      if cadena != ""
        cadena = cadena + ' and user_id = ' + "#{userid.to_i}"
      else
        cadena = ' user_id = ' + "#{userid.to_i}"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and trunc(fecha_asignacion) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      else
        cadena = cadena + ' trunc(fecha_asignacion) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      end
    end
    if cadena != ""
      cadena = cadena + " and tipo is not null and tipo not in ('PROCESO DE PROYECCION DE DEMANDA','NOTIFICACION AL USUARIO','REASIGNACION AL EQUIPO DE CAMPO','REVISION JURIDICA DE EXPEDIENTES') "
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end

  def self.searchd (userid,fchinicial,fchfinal)
    cadena = ""
    if userid != ""
      if cadena != ""
        cadena = cadena + ' and user_id = ' + "#{userid.to_i}"
      else
        cadena = ' user_id = ' + "#{userid.to_i}"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and trunc(fecha_asignacion) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      else
        cadena = cadena + ' trunc(fecha_asignacion) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      end
    end
    if cadena != ""
      cadena = cadena + " and tipo in ('PROCESO DE PROYECCION DE DEMANDA','NOTIFICACION AL USUARIO','REASIGNACION AL EQUIPO DE CAMPO','REVISION JURIDICA DE EXPEDIENTES') "
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end

  def self.searchs (userid,fchinicial,fchfinal)
    cadena = ""
    if userid != ""
      if cadena != ""
        cadena = cadena + ' and user_id = ' + "#{userid.to_i}"
      else
        cadena = ' user_id = ' + "#{userid.to_i}"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and trunc(fecha_asignacion) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      else
        cadena = cadena + ' trunc(fecha_asignacion) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      end
    end
    if cadena != ""
      cadena = cadena + " and tipo in ('SANTA ELENA - PREDIAGNOSTICO','SANTA ELENA - DIAGNOSTICO') "
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end

  def self.searchf (userid,fchinicial,fchfinal)
    cadena = ""
    if userid != ""
      if cadena != ""
        cadena = cadena + ' and user_id = ' + "#{userid.to_i}"
      else
        cadena = ' user_id = ' + "#{userid.to_i}"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and trunc(fecha_asignacion) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      else
        cadena = cadena + ' trunc(fecha_asignacion) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
      end
    end
    if cadena != ""
      cadena = cadena + " and tipo in ('ESTUDIO TECNICO','ESTUDIO DE TITULOS','CORRECCION ACTO ADMINISTRATIVO','REVOCATORIA DE ACTO ADMINISTRATIVO','NUEVA CESION') "
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end



  def validadesactiva
    if self.tipo.to_s == 'PROCESO DE PROYECCION DE DEMANDA' or
       self.tipo.to_s == 'NOTIFICACION AL USUARIO' or
       self.tipo.to_s == 'REASIGNACION AL EQUIPO DE CAMPO' or
       self.tipo.to_s == 'REVISION JURIDICA DE EXPEDIENTES'
      return '2'
    elsif self.tipo.to_s == 'SANTA ELENA - PREDIAGNOSTICO' or self.tipo.to_s == 'SANTA ELENA - DIAGNOSTICO'
      return '3'
    elsif self.tipo.to_s == 'ESTUDIO TECNICO' or self.tipo.to_s == 'ESTUDIO DE TITULOS' or self.tipo.to_s == 'CORRECCION ACTO ADMINISTRATIVO' or self.tipo.to_s == 'REVOCATORIA DE ACTO ADMINISTRATIVO' or self.tipo.to_s == 'NUEVA CESION'
      return '4'
    elsif self.tipo.to_s != ""
      return '1'
    end
  end

  def userprognombre
    return User.find(self.userprog_id).nombre rescue nil
  end

end

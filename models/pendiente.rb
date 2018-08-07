class Pendiente < ActiveRecord::Base
  has_many :dependencias
  has_many :pendientesnotas
  has_many :pendientesimagenes

  validates_presence_of :tarea, :fecha_asignacion, :fecha_vence, :estado
  validate :depend

  def depend
    if self.control_int.to_s == 'NO' and self.planeacion.to_s == 'NO' and self.administrativa.to_s == 'NO' and self.poblacional.to_s == 'NO' and self.juridica.to_s == 'NO' and self.dotacion.to_s == 'NO' and self.comunicaciones.to_s == 'NO' and self.direccion.to_s == 'NO'
      errors.add :depend, "* Debe seleccionar minimo una dependencia responsable"
    end
  end
  
  def self.search (estado,inicial,final,finicial,ffinal,control_int,planeacion,administrativa,poblacional,juridica,dotacion,comunicaciones,direccion)
    cadena = ""
    if estado.to_s != ""
      if cadena != ""
        cadena = cadena + ' and estado  = ' + "'#{estado}'"
      else
        cadena = cadena + ' estado  = ' + "'#{estado}'"
      end
    end
    if inicial.to_s != "" and final.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(fecha_asignacion) between ' + "'#{inicial}'" + ' and ' + "'#{final}'"
        else
          cadena = cadena + ' trunc(fecha_asignacion) between ' + "'#{inicial}'" + ' and ' + "'#{final}'"
        end
    end
    if finicial.to_s != "" and ffinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(fecha_solucion) between ' + "'#{finicial}'" + ' and ' + "'#{ffinal}'"
        else
          cadena = cadena + ' trunc(fecha_solucion) between ' + "'#{finicial}'" + ' and ' + "'#{ffinal}'"
        end
     end
    if control_int.to_s == "SI"
      if cadena.to_s != ""
        cadena = cadena +  " and control_int  = 'SI'" 
      else
        cadena = cadena + " control_int = 'SI'" 
      end
    end
    if planeacion.to_s == "SI"
      if cadena.to_s != ""
        cadena = cadena +  " and planeacion  = 'SI'" 
      else
        cadena = cadena + " planeacion = 'SI'" 
      end
    end
    if administrativa.to_s == "SI"
      if cadena != ""
        cadena = cadena + " and administrativa  = 'SI'"
      else
        cadena = cadena + "  administrativa  = 'SI'"
      end
    end
    if poblacional.to_s == "SI"
      if cadena != ""
        cadena = cadena + " and poblacional  = 'SI'"
      else
        cadena = cadena + "  poblacional  = 'SI'"
      end
    end
    if juridica.to_s == "SI"
      if cadena != ""
        cadena = cadena + " and juridica  = 'SI'"
      else
        cadena = cadena + "  juridica  = 'SI'"
      end
    end
    if dotacion.to_s == "SI"
      if cadena != ""
        cadena = cadena + " and dotacion  = 'SI'"
      else
        cadena = cadena + "  dotacion  = 'SI'"
      end
    end
    if comunicaciones.to_s == "SI"
      if cadena != ""
        cadena = cadena + " and comunicaciones  = 'SI'"
      else
        cadena = cadena + "  comunicaciones  = 'SI'"
      end
    end
    if direccion.to_s == "SI"
      if cadena != ""
        cadena = cadena + " and direccion  = 'SI'"
      else
        cadena = cadena + "  direccion  = 'SI'"
      end
    end
    #logger.error("Valor cadena........."+cadena.to_s)
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "fecha_asignacion asc")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "fecha_asignacion asc")
    end
  end

  def estado_pendiente
    if self.estado.to_s != 'FINALIZADO'
      segundos = (self.fecha_vence - Time.now).to_i
      minutos  = (segundos/60).to_i #es el nÃºmero total de minutos
      horas    = (minutos/60).to_i #nÃºmero total de horas
      dias     = (horas/24).to_i # nÃºmero total de dÃ­as
      dias = dias + 1
      if dias <= 0
         return "<img src='/images/rojo1.png' title='Tarea vencida'/>"
      elsif dias <= 3
         return "<img src='/images/amarillo1.png' title='Tarea a punto de vencer'/>"      
      else
         return "<img src='/images/verde1.png' title='Tema sin respuesta y con tiempo'/>"
      end 
    else
      return "<img src='/images/blanco1.png' title='Tema solucionado'/>"
    end
  end

  # def self.envio(pendiente)
  #   cadena = ""
  #   if pendiente.control_int.to_s == "SI"
  #     if cadena.to_s != ""
  #       cadena = cadena +  "," + Mensaje.find(78).asignadoscorreos.to_s
  #     else
  #       cadena = cadena + Mensaje.find(78).asignadoscorreos.to_s
  #     end
  #   end
  #   if pendiente.planeacion.to_s == "SI"
  #     if cadena.to_s != ""
  #       cadena = cadena +  "," + Mensaje.find(77).asignadoscorreos.to_s
  #     else
  #       cadena = cadena + Mensaje.find(77).asignadoscorreos.to_s
  #     end
  #   end  
  #    if pendiente.administrativa.to_s == "SI"
  #     if cadena.to_s != ""
  #       cadena = cadena +  "," + Mensaje.find(76).asignadoscorreos.to_s
  #     else
  #       cadena = cadena + Mensaje.find(76).asignadoscorreos.to_s
  #     end
  #   end
  #   if pendiente.poblacional.to_s == "SI"
  #     if cadena.to_s != ""
  #       cadena = cadena +  "," + Mensaje.find(101).asignadoscorreos.to_s
  #     else
  #       cadena = cadena + Mensaje.find(101).asignadoscorreos.to_s
  #     end
  #   end
  #   if pendiente.juridica.to_s == "SI"
  #     if cadena.to_s != ""
  #       cadena = cadena +  "," + Mensaje.find(74).asignadoscorreos.to_s
  #     else
  #       cadena = cadena + Mensaje.find(74).asignadoscorreos.to_s
  #     end
  #   end
  #   if pendiente.dotacion.to_s == "SI"
  #     if cadena.to_s != ""
  #       cadena = cadena +  "," + Mensaje.find(72).asignadoscorreos.to_s
  #     else
  #       cadena = cadena + Mensaje.find(72).asignadoscorreos.to_s
  #     end
  #   end
  #   if pendiente.comunicaciones.to_s == "SI"
  #     if cadena.to_s != ""
  #       cadena = cadena +  "," + Mensaje.find(71).asignadoscorreos.to_s
  #     else
  #       cadena = cadena + Mensaje.find(71).asignadoscorreos.to_s
  #     end
  #   end
  #   if pendiente.direccion.to_s == "SI"
  #     if cadena.to_s != ""
  #       cadena = cadena +  "," + Mensaje.find(70).asignadoscorreos.to_s
  #     else
  #       cadena = cadena + Mensaje.find(70).asignadoscorreos.to_s
  #     end
  #   end
  #   Notifier.deliver_pendiente_message(cadena,pendiente)
  # end  

  def self.search_pendiente(isadmin)
    cadena =""
    if Mensaje.find(78).asignadosid.to_s.include?("#{isadmin.to_s}")
      if cadena.to_s != ""
        cadena = cadena +  " or control_int  = 'SI'" 
      else
        cadena = cadena + " control_int = 'SI'" 
      end
    end
    if Mensaje.find(77).asignadosid.to_s.include?("#{isadmin.to_s}")
      if cadena.to_s != ""
        cadena = cadena +  " or planeacion  = 'SI'" 
      else
        cadena = cadena + " planeacion = 'SI'" 
      end
    end
    if Mensaje.find(76).asignadosid.to_s.include?("#{isadmin.to_s}")
      if cadena != ""
        cadena = cadena + " or administrativa  = 'SI'"
      else
        cadena = cadena + "  administrativa  = 'SI'"
      end
    end
    if Mensaje.find(101).asignadosid.to_s.include?("#{isadmin.to_s}")
      if cadena != ""
        cadena = cadena + " or poblacional  = 'SI'"
      else
        cadena = cadena + "  poblacional  = 'SI'"
      end
    end
    if Mensaje.find(74).asignadosid.to_s.include?("#{isadmin.to_s}")
      if cadena != ""
        cadena = cadena + " or juridica  = 'SI'"
      else
        cadena = cadena + "  juridica  = 'SI'"
      end
    end
    if Mensaje.find(72).asignadosid.to_s.include?("#{isadmin.to_s}")
      if cadena != ""
        cadena = cadena + " or dotacion  = 'SI'"
      else
        cadena = cadena + "  dotacion  = 'SI'"
      end
    end
    if Mensaje.find(71).asignadosid.to_s.include?("#{isadmin.to_s}")
      if cadena != ""
        cadena = cadena + " or comunicaciones  = 'SI'"
      else
        cadena = cadena + "  comunicaciones  = 'SI'"
      end
    end
    if Mensaje.find(70).asignadosid.to_s.include?("#{isadmin.to_s}")
      if cadena != ""
        cadena = cadena + " or direccion  = 'SI'"
      else
        cadena = cadena + "  direccion  = 'SI'"
      end
    end
    if cadena != ""
      cadena = cadena + " and estado in ('PENDIENTE','TRAMITE')"
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end    
  end

  def asignadoa
    cadena = ""
    if self.control_int.to_s == "SI"
      cadena = cadena +  "<br/><a title='#{Mensaje.find(78).asignadoscorreos.to_s}'>* CONTROL INTERNO</a>" 
    end
    if self.planeacion.to_s == "SI"
      cadena = cadena +  "<br/><a title='#{Mensaje.find(77).asignadoscorreos.to_s}'>* SUBDIRECCION DE PLANEACION</a>" 
    end  
     if self.administrativa.to_s == "SI"
      cadena = cadena +  "<br/><a title='#{Mensaje.find(76).asignadoscorreos.to_s}'>* SUBDIRECCION APOYO ADMINISTRATIVO Y FINANCIERO</a>" 
    end
    if self.poblacional.to_s == "SI"
      cadena = cadena +  "<br/><a title='#{Mensaje.find(101).asignadoscorreos.to_s}'>* SUBDIRECCION POBLACIONAL</a>" 
    end
    if self.juridica.to_s == "SI"
      cadena = cadena +  "<br/><a title='#{Mensaje.find(74).asignadoscorreos.to_s}'>* SUBDIRECCION APOYO JURIDICO</a>" 
    end
    if self.dotacion.to_s == "SI"
      cadena = cadena +  "<br/><a title='#{Mensaje.find(72).asignadoscorreos.to_s}'>* SUBDIRECCION DE DOTACION DE VIVIENDA Y HABITAT</a>" 
    end
    if self.comunicaciones.to_s == "SI"
      cadena = cadena +  "<br/><a title='#{Mensaje.find(71).asignadoscorreos.to_s}'>* COMUNICACIONES</a>" 
    end
    if self.direccion.to_s == "SI"
      cadena = cadena +  "<br/><a title='#{Mensaje.find(70).asignadoscorreos.to_s}'>* DIRECCION GENERAL</a>" 
    end
    return cadena
  end   

 end


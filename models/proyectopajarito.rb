class Proyectopajarito < ActiveRecord::Base

	def self.search (proyecto, unidad_gestion, fecha, escritura )
      cadena = ""
       if proyecto.to_s != ""
        if cadena != ""
          cadena = cadena + ' and proyecto  = ' + "'#{proyecto}'"
        else
          cadena = cadena + ' proyecto  = ' + "'#{proyecto}'"
        end
      end
      if unidad_gestion.to_s != ""
        if cadena != ""
          cadena = cadena + ' and unidad_gestion  = ' + "'#{unidad_gestion.to_s}'"
        else
          cadena = cadena + ' unidad_gestion  = ' + "'#{unidad_gestion.to_s}'"
        end
      end
      if fecha.to_s != ""
        if cadena != ""
          cadena = cadena + ' and fecha  = ' + "'#{fecha}'"
        else
          cadena = cadena + ' fecha  = ' + "'#{fecha}'"
        end
      end
      if escritura.to_s != ""
        if cadena != ""
          cadena = cadena + ' and escritura = '+ "'#{escritura.to_s}'"
        else
          cadena = cadena + ' escritura = '+ "'#{escritura.to_s}'"
        end
      end
      #logger.error ("ESTOY AQUI....-----------------------------------------------------------" + cadena.to_s)
      if cadena != ""
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end
end

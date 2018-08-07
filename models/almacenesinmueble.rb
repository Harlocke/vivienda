class Almacenesinmueble < ActiveRecord::Base

  def self.search (matricula , descripcion, lugar, estado)
      cadena = ""
      if matricula != ""
        if cadena != ""
          cadena = cadena + ' and matricula  = '+ "'#{matricula.strip}'"
        else
          cadena = cadena + ' matricula  = '+ "'#{matricula.strip}'"
        end
      end
      if descripcion != ""
        s = descripcion.upcase
        if cadena != ""
          cadena = cadena + ' and upper(descripcion) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = cadena + ' upper(descripcion) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if lugar != ""
        s = lugar.upcase
        if cadena != ""
          cadena = cadena + ' and upper(lugar) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = cadena + ' upper(lugar) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if estado != ""
        if cadena != ""
          cadena = cadena + ' and estado  = '+ "'#{estado}'"
        else
          cadena = cadena + ' estado  = '+ "'#{estado}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena])
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end


end


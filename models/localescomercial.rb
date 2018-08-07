class Localescomercial < ActiveRecord::Base
	def self.search (proyecto,fecha,escritura)
      cadena = ""
       if proyecto.to_s != ""
        if cadena != ""
          cadena = cadena + ' and proyecto  = ' + "'#{proyecto}'"
        else
          cadena = cadena + ' proyecto  = ' + "'#{proyecto}'"
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
          cadena = cadena + ' and escritura = '+ "'#{escritura}'"
        else
          cadena = cadena + ' escritura = '+ "'#{escritura}'"
        end
      end
      if cadena != ""
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end
end

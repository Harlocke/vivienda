class Comitesactividad < ActiveRecord::Base
  belongs_to :comite
  belongs_to :dependencia
  
  validates_presence_of :tarea, :fecha_limite, :estado

  def self.search (dependenciaid,estado,valor)
    cadena = ""
    if dependenciaid.to_s != ""
        if cadena != ""
          cadena = cadena + ' and dependencia_id = '+"'#{dependenciaid}'"
        else
          cadena = cadena + ' dependencia_id = '+"'#{dependenciaid}'"
        end
    end
    if estado.to_s != ""
      if cadena != ""
        cadena = cadena + ' and estado = ' + "'#{estado.to_s}'"
      else
        cadena = ' estado = ' + "'#{estado.to_s}'"
      end
    end
    if cadena != ""
      if valor.to_s == 'C'
        cadena = cadena + " and comite_id in (select id from comites where comitestipo_id in (select id from comitestipos where comision = 'S'))"
      end
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      if valor.to_s == 'C'
        find(:all, :conditions => ["trunc(created_at) = trunc(sysdate) and comite_id in (select id from comites where comitestipo_id in (select id from comitestipos where comision = 'S'))"], :order => "created_at")
      else
        find(:all, :conditions => ["trunc(created_at) = trunc(sysdate)"], :order => "created_at")
      end
    end
  end

end

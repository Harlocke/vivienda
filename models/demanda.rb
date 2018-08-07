class Demanda < ActiveRecord::Base
  has_many :demandascobamas, :dependent =>:destroy

  validates_presence_of :tipoproceso,:estado #:radicado,
  #validates_uniqueness_of :radicado

  def self.search (demanda, cobama)
      cadena = ""
      if demanda.id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id = ' + "#{demanda.id.to_s.strip}"
        else
          cadena = ' id = ' + "#{demanda.id.to_s.strip}"
        end
      end
      if demanda.tipoproceso.to_s != ""
        if cadena != ""
          cadena = cadena + ' and tipoproceso = ' + "'#{demanda.tipoproceso}'"
        else
          cadena = ' tipoproceso = ' + "'#{demanda.tipoproceso}'"
        end
      end
      if demanda.radicado.to_s != ""
        if cadena != ""
          cadena = cadena + ' and radicado = ' + "'#{demanda.radicado.to_s.strip}'"
        else
          cadena = ' radicado = ' + "'#{demanda.radicado.to_s.strip}'"
        end
      end
      if demanda.estado.to_s != ""
        if cadena != ""
          cadena = cadena + ' and estado = ' + "'#{demanda.estado}'"
        else
          cadena = ' estado = ' + "'#{demanda.estado}'"
        end
      end
      if demanda.notificado.to_s != ""
        if cadena != ""
          cadena = cadena + ' and notificado = ' + "'#{demanda.notificado}'"
        else
          cadena = ' notificado = ' + "'#{demanda.notificado}'"
        end
      end
      if cobama.to_s != ""
        if cadena != ""
          cadena = cadena + " and id in (select distinct demanda_id from demandascobamas where cobama = '#{cobama.to_s}')"
        else
          cadena = " id in (select distinct demanda_id from demandascobamas where cobama = '#{cobama.to_s}')"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end
end

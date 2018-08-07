class Personassesion < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user

  validates_presence_of :radicado_entrada, :radient_fecha, :motivo, :tipo, :respuesta

  def self.search (fchinicial, fchfinal, motivo, tipo, respuesta)
      cadena = ""
      if fchinicial.to_s != "" and fchfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(radient_fecha) between ' + "'#{fchinicial.to_s}'" + ' and ' + "'#{fchfinal.to_s}'"
        else
          cadena = ' trunc(radient_fecha) between ' + "'#{fchinicial.to_s}'" + ' and ' + "'#{fchfinal.to_s}'"
        end
      end
      if motivo.to_s != ""
        if cadena != ""
          cadena = cadena + ' and motivo = ' + "'#{motivo.to_s.strip}'"
        else
          cadena = ' motivo = ' + "'#{motivo.to_s.strip}'"
        end
      end
      if tipo.to_s != ""
        if cadena != ""
          cadena = cadena + ' and tipo = ' + "'#{tipo.to_s.strip}'"
        else
          cadena = ' tipo = ' + "'#{tipo.to_s.strip}'"
        end
      end
      if respuesta.to_s != ""
        if cadena != ""
          cadena = cadena + ' and respuesta = ' + "'#{respuesta.to_s.strip}'"
        else
          cadena = ' respuesta = ' + "'#{respuesta.to_s.strip}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end
end

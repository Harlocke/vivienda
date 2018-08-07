# encoding: utf-8
class Personasobservacion < ActiveRecord::Base
  belongs_to :user
  belongs_to :persona

  validates_presence_of :observacion, :tipo_atencion
  #validates_format_of :fecha, :with => /[0-9]{4}[-][0-9]{2}[-][0-9]{2}/, :message => " --> La Fecha debe ser con formato: AAAA-MM-DD"

  def dtipoatencion
     if self.tipo_atencion == "1"
       return "PERSONALIZADA"
     elsif self.tipo_atencion == "2"
       return "TELEFONICA"
     elsif self.tipo_atencion == "3"
       return "DOMICILIARIA"
     elsif self.tipo_atencion == "4"
       return "OTRA"
     end
  end

  def self.search (funcionario,fchinicial, fchfinal)
      cadena = ""
      if funcionario != ""
        if cadena != ""
          cadena = cadena + ' and user_id = '+ "'#{funcionario}'"
        else
          cadena = cadena + ' user_id  = '+ "'#{funcionario}'"
        end
      end
      if fchinicial.to_s != "" and fchfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(created_at) between ' + "'#{fchinicial.to_s}'" + ' and ' + "'#{fchfinal.to_s}'"
        else
          cadena = ' trunc(created_at) between ' + "'#{fchinicial.to_s}'" + ' and ' + "'#{fchfinal.to_s}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end
end

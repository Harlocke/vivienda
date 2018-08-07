class Observavivienda < ActiveRecord::Base
  belongs_to :user
  belongs_to :vivienda

  validates_presence_of :observacion, :tipo_atencion
  #validates_format_of :fecha, :with => /[0-9]{4}[-][0-9]{2}[-][0-9]{2}/, :message => " --> La Fecha debe ser con formato: AAAA-MM-DD"

  def after_create
    #Copia de la Observacion a PERSONAS..
    viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id(self.vivienda_id)
    viviendaspersonas.each do |viviendaspersona|
      p = Personasobservacion.new
      p.user_id = self.user_id
      p.tipo_atencion = self.tipo_atencion
      p.observacion = "OBSERVACION VIVIENDA NUEVA - " + self.observacion
      p.persona_id = viviendaspersona.persona_id
      p.created_at = self.created_at
      p.save
    end
  end
  
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

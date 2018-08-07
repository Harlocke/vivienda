class Valorizacionesnota < ActiveRecord::Base
  belongs_to :user
  belongs_to :valorizacion

  validates_presence_of :observacion, :tipo, :tipo_atencion

  def after_create
    #Copia de la Observacion a PERSONAS..
    valorizacionespersonas = Valorizacionespersona.find_all_by_valorizacion_id(self.valorizacion_id)
    valorizacionespersonas.each do |valorizacionespersona|
      p = Personasobservacion.new
      p.user_id = self.user_id
      p.tipo_atencion = self.tipo_atencion
      p.observacion = "OBSERVACION FONVALMED - " + self.observacion
      p.persona_id = valorizacionespersona.persona_id
      p.created_at = self.created_at
      p.save
    end
  end

  def dtipo
     if self.tipo == "1"
       return "TECNICA"
     elsif self.tipo == "2"
       return "JURIDICA"
     elsif self.tipo == "3"
       return "SOCIAL"
     elsif self.tipo == "4"
       return "OTRO"
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

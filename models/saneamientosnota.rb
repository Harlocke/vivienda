class Saneamientosnota < ActiveRecord::Base
  belongs_to :saneamiento
  belongs_to :user

  validates_presence_of :observacion, :tipo_atencion

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

end

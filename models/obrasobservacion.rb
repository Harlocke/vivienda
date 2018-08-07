class Obrasobservacion < ActiveRecord::Base
  belongs_to :obraspublica
  belongs_to :user

  validates_presence_of :observacion, :tipo_atencion

  def after_create
    #Copia de la Observacion a PERSONAS..
    @obraspublica = Obraspublica.find(self.obraspublica_id)
    p = Personasobservacion.new
    p.user_id = self.user_id
    p.tipo_atencion = self.tipo_atencion
    p.observacion = "OBSERVACION OBRA PUBLICA - " + self.observacion
    p.persona_id = @obraspublica.persona_id
    p.created_at = self.created_at
    p.save
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

end

class Mejoramientosnota < ActiveRecord::Base
  belongs_to :user
  belongs_to :mejoramiento

  validates_presence_of :observacion, :tipo_atencion

  def after_create
    #Copia de la Observacion a PERSONAS..
    @mejoramiento = Mejoramiento.find(self.mejoramiento_id)
    p = Personasobservacion.new
    p.user_id = self.user_id
    p.tipo_atencion = self.tipo_atencion
    p.observacion = "OBSERVACION MEJORAMIENTO - " + self.observacion
    p.persona_id = @mejoramiento.persona_id
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

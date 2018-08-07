class Proyectoscopnota < ActiveRecord::Base
  belongs_to :proyectoscopropiedad
  belongs_to :user

  validates_presence_of :tipo_atencion, :observacion

#
#  def after_create
#    #Copia de la Observacion a PERSONAS..
#    @proyectoscopropiedad = Proyectoscopropiedad.find(self.proyectoscopropiedad_id)
#    p = Personasobservacion.new
#    p.user_id = self.user_id
#    p.tipo_atencion = self.tipo_atencion
#    p.observacion = "OBSERVACION COPROPIEDADES - " + self.observacion
#    p.persona_id = @mejoramiento.persona_id
#    p.created_at = self.created_at
#    p.save
#  end


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

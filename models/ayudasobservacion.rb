class Ayudasobservacion < ActiveRecord::Base
  belongs_to :ayuda
  belongs_to :user

  validates_presence_of :observacion, :tipo_atencion
  #validates_format_of :fecha, :with => /[0-9]{4}[-][0-9]{2}[-][0-9]{2}/, :message => " --> La Fecha debe ser con formato: AAAA-MM-DD"

  def after_create
    #Copia de la Observacion a PERSONAS..
    @ayuda = Ayuda.find(self.ayuda_id)
    p = Personasobservacion.new
    p.user_id = self.user_id
    p.tipo_atencion = self.tipo_atencion
    p.observacion = "OBSERVACION ARRENDAMIENTO TEMPORAL - " + self.observacion
    p.persona_id = @ayuda.persona_id
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

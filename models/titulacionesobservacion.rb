class Titulacionesobservacion < ActiveRecord::Base
    belongs_to :titulacion
    belongs_to :user

  validates_presence_of :observacion, :tipo_atencion

  def after_create
    #Copia de la Observacion a PERSONAS..
    titulacionespersonas = Titulacionespersona.find_all_by_titulacion_id(self.titulacion_id)
    titulacionespersonas.each do |titulacionespersona|
      p = Personasobservacion.new
      p.user_id = self.user_id
      p.tipo_atencion = self.tipo_atencion
      p.observacion = "OBSERVACION TITULACION - " + self.observacion
      p.persona_id = titulacionespersona.persona_id
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

end

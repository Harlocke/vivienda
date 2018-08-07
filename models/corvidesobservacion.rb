class Corvidesobservacion < ActiveRecord::Base
  belongs_to :corvide
  belongs_to :user

  validates_presence_of :observacion, :tipo_atencion

  def after_create
    #Copia de la Observacion a PERSONAS..
    corvidespersonas = Corvidespersona.find_all_by_corvide_id(self.corvide_id)
    corvidespersonas.each do |corvidespersona|
      p = Personasobservacion.new
      p.user_id = self.user_id
      p.tipo_atencion = self.tipo_atencion
      p.observacion = "OBSERVACION CORVIDE - " + self.observacion
      p.persona_id = corvidespersona.persona_id
      p.created_at = self.created_at
      p.save
    end
    if self.corvide.persona_id.to_i > 0
      p = Personasobservacion.new
      p.user_id = self.user_id
      p.tipo_atencion = self.tipo_atencion
      p.observacion = "OBSERVACION CORVIDE - " + self.observacion
      p.persona_id = self.corvide.persona_id
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

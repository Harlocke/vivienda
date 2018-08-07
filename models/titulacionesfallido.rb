class Titulacionesfallido < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :user

  validates_presence_of :estado_visita
  validates_presence_of :nombre_fallido, :observacion_fallido, :if => :in_us1?

  def in_us1?
    self.estado_visita.to_s == "FALLIDO" or self.estado_visita.to_s == "INCOMPLETO"
  end

end

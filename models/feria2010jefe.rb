class Feria2010jefe < ActiveRecord::Base
  belongs_to :persona
  has_many :feria2010beneficiarios
  has_many :feria2010calificaciones
  has_many :feria2010calificacionrecursos
  has_many :feria2010rechazados
  has_many :feria2010observaciones
end

class Feria2009jefe < ActiveRecord::Base
  belongs_to :persona
  has_many :feria2009beneficiarios
  has_many :feria2009cruces
  has_many :feria2009calificaciones
  has_many :feria2009rechazados
end

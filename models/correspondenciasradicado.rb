class Correspondenciasradicado < ActiveRecord::Base
  belongs_to :correspondenciasenviada
  belongs_to :correspondenciasrecibida

  validates_presence_of :radicado
end

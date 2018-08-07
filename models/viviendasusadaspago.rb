class Viviendasusadaspago < ActiveRecord::Base
  belongs_to :viviendasusada
  validates_presence_of :fecha_pago
  validates_presence_of :tipo_pago
  validates_presence_of :descripcion
  validates_numericality_of :valor

end

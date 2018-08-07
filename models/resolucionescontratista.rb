class Resolucionescontratista < ActiveRecord::Base
  belongs_to :resolucion
  belongs_to :empleado

  validates_presence_of :empleado_id
end

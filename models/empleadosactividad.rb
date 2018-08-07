class Empleadosactividad < ActiveRecord::Base
  belongs_to :empleado

  validates_presence_of :fecha, :valor, :tipo_actividad, :observaciones
  validates_numericality_of :valor

end

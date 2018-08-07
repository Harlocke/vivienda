class Contratosvinculado < ActiveRecord::Base
  belongs_to :empleado

  validates_presence_of :nro_acto, :fecha_inicio, :salario, :nivel, :tipo_vinculacion
  validates_uniqueness_of :nro_acto
  validates_numericality_of :salario

end

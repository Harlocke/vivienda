class Mejoramientosobra < ActiveRecord::Base
  belongs_to :user
  belongs_to :mejoramiento

  validates_presence_of :identificacion, :nombre, :salario, :cargo, :contrato_activo
  validates_numericality_of :salario
  
end

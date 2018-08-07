class EstadosCivil < ActiveRecord::Base
  has_many :personas
  has_many :beneviviendas
end

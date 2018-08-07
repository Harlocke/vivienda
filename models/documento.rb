class Documento < ActiveRecord::Base
  has_many :personas
  has_many :beneviviendas
  has_many :empleados
end

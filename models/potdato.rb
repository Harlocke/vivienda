class Potdato < ActiveRecord::Base
  has_many :titulacionespoligonos
  has_many :titulacionessuenos
  has_many :titulacionesriesgos
  has_many :titulacionesespacios
  has_many :titulacionesafectas
end

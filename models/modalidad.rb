class Modalidad < ActiveRecord::Base
  has_many :contratos
  has_many :estudiosprevios
end

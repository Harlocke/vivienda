class Tiposcontrato < ActiveRecord::Base
  has_many :contratos
  has_many :estudiosprevios
end

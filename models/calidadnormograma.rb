class Calidadnormograma < ActiveRecord::Base
  has_many :calidadnormogramasprocesos
  has_many :calidadnormogramasimagenes

end

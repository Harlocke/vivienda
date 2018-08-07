class Ayudascontrato < ActiveRecord::Base
  belongs_to :ayuda
  belongs_to :user

  validates_numericality_of :valor_arriendo
end

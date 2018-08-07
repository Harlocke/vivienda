class Feriadocentejefe < ActiveRecord::Base
  belongs_to :persona
  has_many :feriadocentebeneficiarios
  has_many :feriadocentecalificaciones
  has_many :feriadocenterechazados
end

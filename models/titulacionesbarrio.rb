class Titulacionesbarrio < ActiveRecord::Base
  has_many :titulaciones
  validates_presence_of :descripcion
end

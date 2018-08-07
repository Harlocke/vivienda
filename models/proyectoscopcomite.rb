class Proyectoscopcomite < ActiveRecord::Base
  belongs_to :proyectoscopropiedad
  belongs_to :viviendaspersona

  validates_presence_of :fecha_inicio, :tipo
 
end

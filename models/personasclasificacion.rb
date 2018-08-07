class Personasclasificacion < ActiveRecord::Base
  belongs_to :persona
  belongs_to :clasificacion
  
  validates_presence_of :clasificacion_id, :descripcion
end

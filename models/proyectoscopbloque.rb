class Proyectoscopbloque < ActiveRecord::Base
  belongs_to :proyectoscopropiedad
  belongs_to :bloque

  validates_presence_of :bloque_id
end

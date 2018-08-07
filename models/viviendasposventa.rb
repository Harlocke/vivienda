class Viviendasposventa < ActiveRecord::Base
  belongs_to :vivienda

  validates_presence_of :tipo_posventa, :fecha_recibida, :observaciones
end

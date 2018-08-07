class Obrasdisponibilidad < ActiveRecord::Base
  belongs_to :obraspublica
  belongs_to :user

  validates_presence_of :nro_resolucion, :fecha_resolucion
end

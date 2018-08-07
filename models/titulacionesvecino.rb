class Titulacionesvecino < ActiveRecord::Base
  belongs_to :titulacion

  validates_presence_of :nombre, :direccion
end

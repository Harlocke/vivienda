class Legalizacionesmatricula < ActiveRecord::Base
  belongs_to :legalizacion
  belongs_to :legalizacionesproyecto
  belongs_to :legalizacionesreglamento
  belongs_to :user

  validates_presence_of :legalizacionesproyecto_id, :matricula, :legalizacionesreglamento_id
end

class Legalizazonasmatricula < ActiveRecord::Base
  belongs_to :legalizacion
  belongs_to :legalizacionesproyecto
  belongs_to :legalizazonasreglamento
  belongs_to :user

  validates_presence_of :matricula, :legalizazonasreglamento_id, :nombre

end

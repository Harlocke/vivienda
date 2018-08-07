class Seguimientosobservacion < ActiveRecord::Base
  belongs_to :seguimiento
  belongs_to :user

  validates_presence_of :observaciones
end

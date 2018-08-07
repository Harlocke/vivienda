class Licitacionesobservacion < ActiveRecord::Base
  belongs_to :licitacion
  belongs_to :user

  validates_presence_of :observaciones
end

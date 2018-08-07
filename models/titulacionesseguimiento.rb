class Titulacionesseguimiento < ActiveRecord::Base
  belongs_to :user
  belongs_to :titulacionesdemanda

  validates_presence_of :observacion, :fecha
end

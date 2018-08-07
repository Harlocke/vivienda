class Mejoramientoslista < ActiveRecord::Base
  belongs_to :mejoramiento
  belongs_to :listasverificacion

  validates_presence_of :estado, :folios
  validates_numericality_of :folios

end

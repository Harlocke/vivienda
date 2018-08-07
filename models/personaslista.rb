class Personaslista < ActiveRecord::Base
  belongs_to :persona
  belongs_to :listasverificacion

  validates_presence_of :estado
end

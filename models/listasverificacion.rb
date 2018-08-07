class Listasverificacion < ActiveRecord::Base
  has_many :mejoramientoslistas
  has_many :personaslistas
end

class Comuna < ActiveRecord::Base
  has_many :proyectosfichas
  has_many :personas
  has_many :inmobiliarios
  has_many :mejoramientos
  has_many :viviendasusadas
  has_many :convenios
  has_many :titulaciones
  has_many :quejas
  has_many :corvides
  has_many :ayudasviviendas
  has_many :ayudas
  
  validates_presence_of :descripcion2, :comuna, :barrio
  
end

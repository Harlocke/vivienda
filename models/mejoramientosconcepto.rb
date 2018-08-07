class Mejoramientosconcepto < ActiveRecord::Base
  belongs_to :mejoramiento
  belongs_to :user

  validates_presence_of :descripcion, :tipo
  
end

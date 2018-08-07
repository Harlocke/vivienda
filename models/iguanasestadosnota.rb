class Iguanasestadosnota < ActiveRecord::Base
  belongs_to :iguanasestado
  belongs_to :user

  validates_presence_of :proyecto, :observaciones
  
end

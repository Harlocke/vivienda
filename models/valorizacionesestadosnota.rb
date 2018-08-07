class Valorizacionesestadosnota < ActiveRecord::Base
  belongs_to :valorizacionesestado
  belongs_to :user

  validates_presence_of :proyecto, :observaciones
  
end

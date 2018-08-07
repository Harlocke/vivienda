class Valorizacionesestado < ActiveRecord::Base
  has_many :valorizacionesestadosnotas
  has_many :valorizaciones
end

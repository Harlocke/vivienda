class Titulacionesafecta < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :user
  belongs_to :potdato

  validates_presence_of :potdato_id, :observacion,:tipo
end

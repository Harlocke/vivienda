class Comitesobservacion < ActiveRecord::Base
  belongs_to :comite
  belongs_to :user

  validates_presence_of :observaciones
end

class Titulacionesprofesional < ActiveRecord::Base
  belongs_to :titulacion
  validates_presence_of :cargo,:user_id,:matricula_prof
end

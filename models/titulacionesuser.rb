class Titulacionesuser < ActiveRecord::Base
  belongs_to :titulacion

  validates_presence_of :user_id
end

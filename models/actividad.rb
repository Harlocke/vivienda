class Actividad < ActiveRecord::Base
  belongs_to :requerimiento
  belongs_to :user
end

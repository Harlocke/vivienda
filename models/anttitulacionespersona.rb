class Anttitulacionespersona < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :persona
  belongs_to :user
end

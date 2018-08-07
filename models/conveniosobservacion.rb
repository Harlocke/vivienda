class Conveniosobservacion < ActiveRecord::Base
  belongs_to :convenio
  belongs_to :user

  validates_presence_of :observacion

end

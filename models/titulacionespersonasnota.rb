class Titulacionespersonasnota < ActiveRecord::Base
  belongs_to :user
  belongs_to :titulacionespersona
  validates_presence_of :observaciones

end

class Proyfactnota < ActiveRecord::Base
	belongs_to :proyectosfactibilidad
	has_many :proyfactnotasimagenes, :dependent =>:destroy
  	belongs_to :user
  	
  	validates_presence_of :observaciones

end

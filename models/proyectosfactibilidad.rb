class Proyectosfactibilidad < ActiveRecord::Base
	belongs_to :user
	belongs_to :proyecto
	belongs_to :tiposfactibilidad
	has_many :proyfactnotas, :dependent =>:destroy

	validates_presence_of :tiposfactibilidad_id, :fecha 
end

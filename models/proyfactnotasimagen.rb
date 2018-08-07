class Proyfactnotasimagen < ActiveRecord::Base
	belongs_to :proyfactnota

	validates_presence_of :descripcion

	has_attached_file :factibilidad, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
	validates_attachment_presence :factibilidad, :message => 'Debe seleccionar un archivo valido!!'

end

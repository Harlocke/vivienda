class Pendientesnota < ActiveRecord::Base
	belongs_to :pendiente
	belongs_to :user

	has_many :pendientesimagenes, :dependent =>:destroy
	
	validates_presence_of :observacion
	

	def after_create
		revision = Pendientesnota.find(self.id)
		cadena = ""
		  if cadena.to_s != ""
			cadena = cadena +  "," + Mensaje.find(121).asignadoscorreos.to_s
		  else
			cadena = cadena + Mensaje.find(121).asignadoscorreos.to_s
		  end
		Notifier.deliver_pendientesnota_message(cadena,revision)
	 end
end

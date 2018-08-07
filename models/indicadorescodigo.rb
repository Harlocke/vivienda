class Indicadorescodigo < ActiveRecord::Base

	def descripcionindi
		return self.codigo.to_s + ' - ' + self.descripcion.to_s
	end
end

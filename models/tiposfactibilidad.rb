class Tiposfactibilidad < ActiveRecord::Base
	has_many :proyectosfactibilidades

	def descripcionfase
		return 'FASE ' + self.fase.to_s + ' - ' + self.descripcion_fase.to_s
	end

	def descripcioncompleta
		return self.descripcion_fase.to_s + ' - ' + self.actividad.to_s
	end

	def descripactividad
		return self.codigo.to_s + ' - ' + self.actividad.to_s
	end
end

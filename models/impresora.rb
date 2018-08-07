class Impresora < ActiveRecord::Base
	has_many :impresorasconsumos
	has_many :impresorasreportes, :dependent =>:destroy
	belongs_to :user

	def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
end

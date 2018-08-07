class Impresorasconsumo < ActiveRecord::Base
	belongs_to :impresora
	belongs_to :user
	belongs_to :dependencia

	def totalmesanterior
		return self.acum_ante_copias.to_i + self.acum_ante_impresion.to_i
    end

    def cargos
    	if self.cargo.to_s != 'CONTRATISTA'
    	 return 'VINCULADO'
    	else
    		return 'CONTRATISTA'
    	end
    end
end

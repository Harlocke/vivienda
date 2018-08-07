class Empleadobitacora < ActiveRecord::Base
  belongs_to :empleado
  belongs_to :user
  belongs_to :dependencia

  def contrato
  	if self.tipo.to_s == 'V'
  		return 'VINCULADO'
  	elsif self.tipo.to_s == 'C'
  		return 'CONTRATISTA'
  	else
  		return 'SIN DATO'
  	end
  end
end

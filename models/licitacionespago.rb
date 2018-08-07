class Licitacionespago < ActiveRecord::Base
  belongs_to :user
  belongs_to :mejoramiento

  validates_presence_of :porcentaje, :fecha_pago, :valor, :descripcion
  validate :validaingreso

  def validaingreso
    if self.id
        sumvalor = Licitacionespago.sum('valor', :conditions => ["licitacion_id = #{self.licitacion} and id != #{self.id}"])
        sumvalor = sumvalor + self.valor
        if sumvalor > self.licitacion.valor_resolucion
          errors.add :valor, "El valor del pago supera el valor del subsidio"
        end
    end
  end
end

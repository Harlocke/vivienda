class Licitacionesenlacespago < ActiveRecord::Base
  belongs_to :user
  belongs_to :licitacionesenlace

  validates_presence_of :fecha, :valor, :nro_factura
  validates_numericality_of :valor
  validate :validaingreso

  def validaingreso
    if self.id
      @licitacionesenlace = Licitacionesenlace.find(self.licitacionesenlace_id)
      sumvalor = 0
      sumvalor = Licitacionesenlacespago.sum('valor', :conditions => ["licitacionesenlace_id = #{self.licitacionesenlace_id} and id != #{self.id}"]) rescue 0
      sumvalor = sumvalor.to_i + self.valor.to_i
      if sumvalor > @licitacionesenlace.valortotal
        errors.add :valor, "El valor del pago supera el valor del Analisis"
      end
    end
  end
  
end

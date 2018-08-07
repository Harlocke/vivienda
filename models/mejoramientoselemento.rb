class Mejoramientoselemento < ActiveRecord::Base
  belongs_to :mejoramiento
  belongs_to :user
  belongs_to :mejoramientositem
  has_many :mejorainformeselementos
  has_many :mejoraelementosimagenes

  validates_presence_of :mejoramientositem_id, :cantidad
  validates_numericality_of :cantidad
  validate :validaingreso

  def validaingreso
    if self.id
      valorregmejora = Mejoramientoselemento.sum('valor_total', :conditions=>["mejoramiento_id = #{self.mejoramiento_id}
                                                                               and mejoramientositem_id != 10043
                                                                               and id != #{self.id}"])
      valordiag      = Mejoramientoselemento.sum('valor_total', :conditions=>["mejoramiento_id = #{self.mejoramiento_id}
                                                                               and mejoramientositem_id = 10043"])
      if self.mejoramientositem_id.to_i !=  10043
        valortotal = valorregmejora.to_i + self.valor_total.to_i
      else
        valortotal = valorregmejora.to_i
      end
      #logger.error("SIFI  self.valor_total ----- #{self.valor_total.to_s}")
      #logger.error("SIFI  valordiag ---- #{valordiag.to_s rescue nil}")
      #Calcula el 13%
      if self.mejoramiento.calculo.to_s == "SUBSIDIO"
        trece = ((self.mejoramiento.valor_resolucion.to_i*13)/100)
      elsif self.mejoramiento.calculo.to_s == "SIN ADMINISTRACION"
        trece = 0
      elsif self.mejoramiento.calculo.to_s == "EJECUCION 2015"
        valornormal = Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id not in (10043,2)"]).to_i
        trece = (valornormal.to_i*0.13).round
      else
        trece = ((valortotal.to_f * 13)/100)
      end
      if self.mejoramiento.calculo.to_s == "EJECUCION 2015"
        valortotal = valortotal.to_i
      else
        if self.mejoramientositem_id.to_i !=  10043
          valortotal = valortotal.to_i + trece.to_i + valordiag.to_i
        else
          valortotal = valortotal.to_i + trece.to_i + self.valor_total.to_i
        end
      end
      if valortotal.to_i > self.mejoramiento.valor_resolucion.to_i
        errors.add :cantidad, "Problemassss"
      end
    end
  end
end

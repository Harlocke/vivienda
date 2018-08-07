class Periodosliquidacion < ActiveRecord::Base
  #belongs_to :contratosretefuente
  has_many :contratosretefuentes
  belongs_to :nomina

  def nombreperiodo
    return 'NOMINA DEL '+self.fecha_inicial.to_s+ ' AL '+self.fecha_final.to_s
  end
end

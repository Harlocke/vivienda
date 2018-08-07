class Contratosretefuente < ActiveRecord::Base
  belongs_to :empleado
  belongs_to :periodosliquidacion

  validates_presence_of :periodosliquidacion_id, :valor_retencion
  validates_numericality_of :valor_retencion
end

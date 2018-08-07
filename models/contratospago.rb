class Contratospago < ActiveRecord::Base
  belongs_to :contrato
  belongs_to :rubro
  belongs_to :user

  validates_presence_of :nro_cuenta, :fecha_cuenta, :fecha_aprobacion, :valor, :rubro_id, :if => :in_us?
  validates_numericality_of :valor_total, :valor_amortizar, :valor_pagar, :if => :in_us?

  validates_presence_of :valor, :porcentaje_amorti, :if => :in_us2?
  validates_numericality_of :valor, :porcentaje_amorti, :if => :in_us2?

  def in_us?
    tipo_pago == 'P'
  end

  def in_us2?
    tipo_pago == 'A'
  end
  
end

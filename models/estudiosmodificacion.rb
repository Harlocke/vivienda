class Estudiosmodificacion < ActiveRecord::Base
  belongs_to :estudiosprevio
  belongs_to :user
  has_many :estudiosmrubros, :dependent =>:destroy

  validates_presence_of :tipo_modificacion
  validates_presence_of :valor, :cdp1, :fecha_cdp1, :if => :in_u?
  validates_presence_of :plazo_mes, :unless=> :valor?
  validates_presence_of :plazo_dias, :unless=> :plazo_mes?
  validates_numericality_of :valor, :allow_nil => true
  #validates_presence_of :cdp1, :fecha_cdp1, :if => :in_u?

  def in_u?
    self.tipo_modificacion.to_s == "V" or self.tipo_modificacion.to_s == "PV" or self.tipo_modificacion.to_s == "PVC" or self.tipo_modificacion.to_s == "VC"
  end

  def dtipomodificacion
     if (self.tipo_modificacion == 'P')
       return 'PLAZO'
     elsif (self.tipo_modificacion == 'V')
       return 'VALOR'
     elsif (self.tipo_modificacion == 'C')
       return 'CLAUSULAS'
     elsif (self.tipo_modificacion == 'PV')
       return 'PLAZO - VALOR'
     elsif (self.tipo_modificacion == 'PC')
       return 'PLAZO - CLAUSULAS'
     elsif (self.tipo_modificacion == 'PVC')
       return 'PLAZO - VALOR - CLAUSULAS'
     elsif (self.tipo_modificacion == 'VC')
       return 'VALOR - CLAUSULAS'
     end
  end
end

class Iguanaspago < ActiveRecord::Base
  belongs_to :iguana
  belongs_to :persona

  require 'number_to_words'
  
  validates_presence_of :tipo, :fecha_solicitud, :valor, :estado
  #, :fecha_desembolso, :rubro, :convenio
  validates_numericality_of :valor

  def tipopago
     if self.tipo == "A"
       return "COMPENSACION POR AVALUO"
     elsif self.tipo == "E"
       return "COMPENSACION ECONOMICA"
     elsif self.tipo == "T"
       return "COMPENSACION DE TRASLADO"
     elsif self.tipo == "L"
       return "COMPENSACION POR TRAMITES LEGALES"
     elsif self.tipo == "R"
       return "COMPENSACION POR ARRENDATARIO"
     elsif self.tipo == "V"
       return "COMPENSACION POR TRAMITES LEGALES POR VIVIENDA REPOSICION"
     elsif self.tipo == "I"
       return "COMPENSACION IMPACTO ECONOMICO"
     elsif self.tipo == "G"
       return "COMPENSACION GASTOS ESCOLARIZACION"
     elsif self.tipo == "P"
       return "COMPENSACION EXPENSAS CURADURIA INTERVENCIONES PARCIALES"
     elsif self.tipo == "S"
       return "COMPENSACION TRASLADO ESPECIAL"
     end
  end

  def valoravaluo(valor, idiguana)
    sumvalor = Iguanaspago.sum('valor', :conditions => ["iguana_id = ? and tipo = ?", idiguana, 'A'])
    valortotal = valor - sumvalor
    return valortotal
  end

#  def valorcompensacion(valor, idiguana)
#    sumvalor = Iguanaspago.sum('valor', :conditions => ["iguana_id = ? and tipo in (?,?,?)", idiguana, 'E','T','L'])
#    valortotal = valor - sumvalor
#    return valortotal
#  end

  def valorcompensacion(idiguana, tipo)
    sumvalor = Iguanaspago.sum('valor', :conditions => ["iguana_id = ? and tipo = ?", idiguana, tipo])
    return sumvalor.to_i
  end

  def valor_pago
    v = 0
    v = self.iguana.valor_avaluo_catrastral.to_i * 0.98
    return v
  end

end
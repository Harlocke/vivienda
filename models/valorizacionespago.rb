class Valorizacionespago < ActiveRecord::Base
  belongs_to :valorizacion
  belongs_to :persona

  require 'number_to_words'
  
  validates_presence_of :tipo, :fecha_solicitud, :valor, :estado
  #, :fecha_desembolso, :rubro, :convenio
  validates_numericality_of :valor

#  def valoravaluo(valor, idvalorizacion)
#    sumvalor = Valorizacionespago.sum('valor', :conditions => ["valorizacion_id = ? and tipo = ?", idvalorizacion, 'A'])
#    valortotal = valor - sumvalor
#    return valortotal
#  end
#
##  def valorcompensacion(valor, idvalorizacion)
##    sumvalor = Valorizacionespago.sum('valor', :conditions => ["valorizacion_id = ? and tipo in (?,?,?)", idvalorizacion, 'E','T','L'])
##    valortotal = valor - sumvalor
##    return valortotal
##  end
#
#  def valorcompensacion(idvalorizacion, tipo)
#    sumvalor = Valorizacionespago.sum('valor', :conditions => ["valorizacion_id = ? and tipo = ?", idvalorizacion, tipo])
#    return sumvalor.to_i
#  end

end
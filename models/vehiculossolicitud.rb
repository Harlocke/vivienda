class Vehiculossolicitud < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :fecha, :vehiculoshorarioinicio, :vehiculoshorariofin, :nro_pasajeros, :destino

  def vehiculoshorarioinicio_descripcion
    return Vehiculoshorario.find(self.vehiculoshorarioinicio).descripcion rescue nil
  end

  def vehiculoshorariofin_descripcion
    return Vehiculoshorario.find(self.vehiculoshorariofin).descripcion rescue nil
  end

  def estsol
    if self.estado.to_s == 'PENDIENTE'
       return "<img src='/images/blanco1.png' title='PENDIENTE'/>"
    elsif self.estado.to_s == 'ACEPTADO'
       return "<img src='/images/verde1.png' title='ACEPTADO'/>"
    elsif self.estado.to_s == 'RECHAZADO'
       return "<img src='/images/rojo1.png' title='RECHAZADO'/>"
    elsif self.estado.to_s == 'CANCELADO'
       return "<img src='/images/amarillo1.png' title='CANCELADO'/>"
    end
  end
end

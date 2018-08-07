class Analisisprecioselemento < ActiveRecord::Base
  belongs_to :analisisprecio
  belongs_to :user
  belongs_to :precioselemento

  #validates_presence_of :cantidad, :elemento_autobuscar
  #validates_presence_of :porc_desperdicio, :if => :in_us1?
  #validates_presence_of :porc_rendimiento, :if => :in_us2?

  def precioselemento_autobuscar
    precioselemento.autobuscar if precioselemento
  end

  def precioselemento_autobuscar=(autobuscar)
    self.precioselemento = Precioselemento.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def after_save
    ActiveRecord::Base.connection.execute(
      "update analisisprecios set valor = (select sum(valortotal+herramienta) from analisisprecioselementos where analisisprecio_id = #{self.analisisprecio_id})
       where  id = #{self.analisisprecio_id}")
  end

#  def in_us1?
#    if self.elemento_id
#      self.elemento.clasificacion.to_s == 'MATERIALES EN OBRA'
#    end
#  end
#
##  def in_us2?
##    if self.elemento_id
##      self.elemento.clasificacion.to_s == 'EQUIPO' or self.elemento.clasificacion.to_s == 'MANO DE OBRA'
##    end
##  end
#
#  def in_us2?
#    if self.elemento_id
#      self.elemento.clasificacion.to_s == 'MANO DE OBRA'
#    end
#  end
end

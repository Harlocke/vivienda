class Interactividad < ActiveRecord::Base
  belongs_to :interventoria
  has_many :interactimagenes, :dependent =>:destroy
  has_many :interactobservaciones, :dependent =>:destroy
  belongs_to :user

  def siguiente
    if Interactividad.exists?(["interventoria_id = #{self.interventoria_id} and consecutivo = #{self.consecutivo.to_i + 1}"])
      return self.consecutivo.to_i + 1
    else
      return 0
    end
  end

  def atras
    if Interactividad.exists?(["interventoria_id = #{self.interventoria_id} and consecutivo = #{self.consecutivo.to_i - 1}"])
      return self.consecutivo.to_i - 1
    else
      return 0
    end
  end

  def autorizaobservaciones
    if self.actividad.include?("PAGOS DE SEGURIDAD SOCIAL")
      return 'S'
    else
      return 'N'
    end
  end

  def interobsant
    if Interactobservacion.exists?(["interactividad_id in (select id from interactividades where estudiosactividad_id = #{self.estudiosactividad_id})"])
      return 'S'
    else
      return 'N'
    end
  end
end

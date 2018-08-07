class Conveniosresolmejoramiento < ActiveRecord::Base
  belongs_to :conveniosresolintencion
  belongs_to :mejoramiento
  validate :observacionesrechazo

  def observacionesrechazo
    if self.estado.to_s == 'NO' and self.observacion.to_s == ""
        errors.add :observacion, "* Debe indicar la observacion de la cancelacion"
    end
  end

  def destado
    if self.estado.to_s == "SI"
      return "OK"
    elsif self.estado.to_s == "NO"
      return "NO OK"
    end
  end

end

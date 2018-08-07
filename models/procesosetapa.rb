class Procesosetapa < ActiveRecord::Base
  belongs_to :procesosjuridico
  belongs_to :etapasproceso
  validates_presence_of :etapasproceso_id, :observaciones
  validate :estadofallo

  def estadofallo
    if self.etapasproceso_id.to_s == "10012" or self.etapasproceso_id.to_s == "10013" and self.firmeza_fallo.to_s == ""
        errors.add :firmeza_fallo, "SANTIAGO!!! Debe registrar la firmesa del fallo..."
    end
    if self.etapasproceso_id.to_s == "10012" or self.etapasproceso_id.to_s == "10013" and self.estado.to_s == ""
        errors.add :estado, "SANTIAGO!!! Debe registrar el resultado del fallo..."
    end
  end

  def destado
     if self.estado == "1"
       return "ABSUELVE"
     elsif self.estado == "2"
       return "CONDENA TOTAL"
     elsif self.estado == "3"
      return "CONDENA PARCIAL"
     elsif self.estado == "4"
      return "SE CONCILIA"
     elsif self.estado == "5"
      return "NO SE CONCILIA"
     end
  end

  def dfirmeza
     if self.firmeza_fallo == "1"
       return "ANULADO"
     elsif self.firmeza_fallo == "2"
       return "EN EJECUCION"
     end
  end

end

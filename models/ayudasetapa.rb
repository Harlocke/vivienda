class Ayudasetapa < ActiveRecord::Base
  belongs_to :ayuda
  belongs_to :user

  def clasificaciondesc
    return Aclasificacion.find(self.aclasificacion.to_i).descripcion.to_s rescue nil
  end

  def etapasdesc
    return Aetapa.find(self.aetapa.to_i).descripcion.to_s rescue nil
  end
end

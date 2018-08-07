class Legalizacionesproyecto < ActiveRecord::Base
  belongs_to :legalizacion
  belongs_to :user

  validates_presence_of :proyecto
  
  def proyectodesc
    return Proyecto.find(self.proyecto.to_i).descripcion.to_s rescue nil
  end

  def bloquedesc
    return Bloque.find(self.bloque.to_i).descripcion.to_s rescue nil
  end

  def completo
    if self.bloquedesc
      return self.proyectodesc.to_s + ' - BLOQUE: ' + self.bloquedesc.to_s
    else
      return self.proyectodesc.to_s
    end
  end

  def eliminar
    if Legalizacionesmatricula.exists?(["legalizacionesproyecto_id = #{self.id}"]) == true
      return 'N'
    else
      return 'S'
    end
  end

end

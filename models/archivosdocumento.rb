class Archivosdocumento < ActiveRecord::Base
  has_many :archivosimagenes
  has_many :archivosseriesdocs

  validates_presence_of :descripcion

  def actualizacion(userid)
    arc = Archivosactualizacion.new
    arc.archivo_id = self.archivo_id
    arc.user_id = userid
    arc.save
  end
end

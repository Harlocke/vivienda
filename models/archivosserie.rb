class Archivosserie < ActiveRecord::Base
  has_many :archivos
  has_many :archivosseriesdocs


  def actualizacion(userid)
    arc = Archivosactualizacion.new
    arc.archivo_id = self.archivo_id
    arc.user_id = userid
    arc.save
  end

end

class Proyectoscopropiedad < ActiveRecord::Base
  belongs_to :proyecto
  has_many :proyectoscopdocumentos
  has_many :proyectoscopcomites
  has_many :proyectoscopbloques
  has_many :proyectoscopnotas

  validates_presence_of :nombre

  def inforph
    dato = ""
    legalizacionesproyecto = Legalizacionesproyecto.find(:first, :conditions=>["proyecto = #{self.proyecto_id}"])
    legalizacion = Legalizacion.find(legalizacionesproyecto.legalizacion_id)
    legalizacion.legalizacionesreglamentos.each do |legalizacionesreglamento|
      dato = dato + ' RPH: ' + legalizacionesreglamento.rph.to_s + ' Fecha: ' +legalizacionesreglamento.fecharph.strftime("%Y-%m-%d").to_s + '<br/>'
    end
    return dato
  end



end

class Dato < ActiveRecord::Base
  validates_presence_of :identificacion, :nombre,:comuna,:fecha_nacimiento,:genero,:nivel_educativo,:grupo_poblacional,:tipo_contrato,:regimen,:fondo,:tipoafiliacion,:fechainicio,:fechafinal,:dependencia,:nro_contrato,:linea, :vehiculo, :estado_civil
  validates_presence_of :placa, :if => :in_us1?

  def in_us1?
    self.vehiculo.to_s == "SI"
  end
end

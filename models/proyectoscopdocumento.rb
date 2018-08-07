class Proyectoscopdocumento < ActiveRecord::Base
  belongs_to :proyectoscopropiedad
  belongs_to :proyectostipo
  belongs_to :user
  
  has_attached_file :copropiedad
  validates_attachment_presence :copropiedad, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :copropiedad, :less_than => 20000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 20 Megabytes!!!'
end
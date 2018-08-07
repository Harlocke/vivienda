class Proyectosdocumento < ActiveRecord::Base
  belongs_to :proyecto
  belongs_to :proyectostipo
  belongs_to :user

  has_attached_file :prodocumento
  validates_attachment_presence :prodocumento, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :prodocumento, :less_than => 20000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 20 Megabytes!!!'
end

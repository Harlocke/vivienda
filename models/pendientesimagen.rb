class Pendientesimagen < ActiveRecord::Base
  belongs_to :pendientesnota
  belongs_to :pendiente
  belongs_to :user
  
  has_attached_file :pendiente
  validates_presence_of :descripcion
  validates_attachment_presence :pendiente, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :pendiente, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

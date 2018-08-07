class Corresinternasimagen < ActiveRecord::Base
  belongs_to :correspondenciasinterna
  belongs_to :user

  has_attached_file :corresinterna
  validates_presence_of :descripcion
  validates_attachment_presence :corresinterna, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :corresinterna, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

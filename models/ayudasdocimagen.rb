class Ayudasdocimagen < ActiveRecord::Base
  belongs_to :ayudasdocumento
  belongs_to :user

  #validates_presence_of :descripcion
  #validates_attachment_presence :ayudasdoc, :message => 'Debe seleccionar un archivo valido!!'
  #validates_attachment_size :ayudasdoc, :less_than => 4000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 4 Megabytes!!!'

  validates_presence_of :descripcion
  has_attached_file :ayudasimagen
  validates_attachment_presence :ayudasimagen, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :ayudasimagen, :less_than => 4000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 4 Megabytes!!!'
end

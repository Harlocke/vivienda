class Legalizacionesimagen < ActiveRecord::Base
  belongs_to :legalizacion
  belongs_to :user

  has_attached_file :legalizacion, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :legalizacion, :message => 'Debe seleccionar un archivo valido!!'
  #validates_attachment_size :legalizacion, :less_than => 10000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 10 Megabytes!!!'

end

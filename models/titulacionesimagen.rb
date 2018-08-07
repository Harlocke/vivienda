class Titulacionesimagen < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :user

  has_attached_file :titulacion, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion, :fecha_doc
  validates_attachment_presence :titulacion, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :titulacion, :less_than => 25000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 25 Megabytes!!!'

end

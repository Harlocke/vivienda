class Resolucionesimagen < ActiveRecord::Base
  belongs_to :resolucion

  has_attached_file :resolucion, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :resolucion, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_content_type :resolucion, :content_type => ['application/pdf','application/x-pdf'], :message => 'El formato del archivo debe ser PDF!!'
  #validates_attachment_size :resolucion, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

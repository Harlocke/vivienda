class Archivosimagen < ActiveRecord::Base
  belongs_to :archivo
  belongs_to :user
  belongs_to :archivosdocumento
  
  has_attached_file :archivo, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :archivosdocumento_id, :fecha_doc
  validates_attachment_presence :archivo, :message => 'Debe seleccionar un archivo valido!!'
  #validates_attachment_content_type :archivo, :content_type => ['application/pdf'], :message => 'El formato del archivo debe ser PDF!!'
  #validates_attachment_size :archivo, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

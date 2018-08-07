class Inmobiliariosimagen < ActiveRecord::Base
  belongs_to :inmobiliario
  belongs_to :user

  validates_presence_of :descripcion
  has_attached_file :inmobiliario, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :inmobiliario, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_content_type :inmobiliario, :content_type => ['application/pdf'], :message => 'El formato del archivo debe ser PDF!!'
  validates_attachment_size :inmobiliario, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

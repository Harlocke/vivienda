class Valorizacionesimagen < ActiveRecord::Base
  belongs_to :valorizacion

  has_attached_file :valorizacion, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :valorizacion, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_content_type :valorizacion, :content_type => ['application/pdf'], :message => 'El formato del archivo debe ser PDF!!'
  validates_attachment_size :valorizacion, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'


end

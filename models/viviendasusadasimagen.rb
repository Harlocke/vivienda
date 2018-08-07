class Viviendasusadasimagen < ActiveRecord::Base
  belongs_to :viviendasusada
  
  has_attached_file :viviendasusada, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :viviendasusada, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_content_type :viviendasusada, :content_type => ['application/pdf'], :message => 'El formato del archivo debe ser PDF!!'
  validates_attachment_size :viviendasusada, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

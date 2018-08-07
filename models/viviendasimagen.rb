class Viviendasimagen < ActiveRecord::Base
  belongs_to :vivienda
  has_attached_file :foto, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :foto, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :foto, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

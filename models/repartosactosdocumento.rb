class Repartosactosdocumento < ActiveRecord::Base
  belongs_to :repartosacto
  belongs_to :tiposactosdocumento
  belongs_to :user

  has_attached_file :reparto, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :reparto, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :reparto, :less_than => 15000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 15 Megabytes!!!'

end

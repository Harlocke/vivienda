class Impresorasimagen < ActiveRecord::Base
  belongs_to :impresorasreporte
  belongs_to :user
  
  has_attached_file :impresora, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :impresora, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :impresora, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

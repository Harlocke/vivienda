class Mejorainformesimagen < ActiveRecord::Base
  belongs_to :mejorainformeselemento
  has_attached_file :mejorainforme, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false 
  
  validates_presence_of :descripcion
  validates_attachment_presence :mejorainforme, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :mejorainforme, :less_than => 4000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 4 Megabytes!!!'
end

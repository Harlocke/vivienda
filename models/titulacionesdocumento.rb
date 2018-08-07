class Titulacionesdocumento < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :titulacionesdoctipo
  belongs_to :user
  belongs_to :persona

  has_attached_file :titudocumento, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :titudocumento, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :titudocumento, :less_than => 25000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 25 Megabytes!!!'

end

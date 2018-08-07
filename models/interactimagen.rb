class Interactimagen < ActiveRecord::Base
  belongs_to :interactividad
  belongs_to :user

  validates_presence_of :descripcion
  has_attached_file :interactividad, :styles => { :medium => "300x300>", :thumb => "100x100>"}, :whiny => false
  validates_attachment_presence :interactividad, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :interactividad, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

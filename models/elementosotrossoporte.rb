class Elementosotrossoporte < ActiveRecord::Base
  belongs_to :elementosotro
  belongs_to :user

  has_attached_file :eleotrossoporte, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :eleotrossoporte, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :eleotrossoporte, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

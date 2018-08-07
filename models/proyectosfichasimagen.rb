class Proyectosfichasimagen < ActiveRecord::Base
  belongs_to :proyectosficha

  has_attached_file :proyectosficha, :styles => { :medium => "300x300!", :thumb => "100x100!" }
  validates_presence_of :descripcion
  validates_attachment_presence :proyectosficha, :message => 'Debe seleccionar un archivo valido!!'

end

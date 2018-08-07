class Lotesimagen < ActiveRecord::Base
  belongs_to :lote

  has_attached_file :lote, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :lote, :message => 'Debe seleccionar un archivo valido!!'

end

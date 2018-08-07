class Calidadnormogramasimagen < ActiveRecord::Base
  belongs_to :calidadnormograma
  belongs_to :user

  has_attached_file :calidadnormograma, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :calidadnormograma, :message => 'Debe seleccionar un archivo valido!!'
  
end

class Licitacionesimagen < ActiveRecord::Base
  belongs_to :licitacion
  validates_presence_of :descripcion

  has_attached_file :licitacion, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :licitacion, :message => 'Debe seleccionar un archivo valido!!'
end

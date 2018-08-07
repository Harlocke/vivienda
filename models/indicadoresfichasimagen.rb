class Indicadoresfichasimagen < ActiveRecord::Base
  belongs_to :indicadoresficha
  belongs_to :user

  validates_presence_of :descripcion

  has_attached_file :indicadoresficha
  validates_attachment_presence :indicadoresficha, :message => 'Debe seleccionar un archivo valido!!'
end


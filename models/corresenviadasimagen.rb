class Corresenviadasimagen < ActiveRecord::Base
  belongs_to :correspondenciasenviada
  belongs_to :user

  validates_presence_of :descripcion
  has_attached_file :enviada, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :enviada, :message => 'Debe seleccionar un archivo valido!!'
  
#  def before_save
#    s = self.enviada_file_name
#    self.enviada_file_name = s.downcase
#  end
end

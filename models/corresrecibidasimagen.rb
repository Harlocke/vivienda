class Corresrecibidasimagen < ActiveRecord::Base
  belongs_to :correspondenciasrecibida
  belongs_to :user

  validates_presence_of :descripcion
  has_attached_file :recibida, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :recibida, :message => 'Debe seleccionar un archivo valido!!'

#  def before_save
#    s = self.recibida_file_name
#    self.recibida_file_name = s.downcase
#  end
  
end

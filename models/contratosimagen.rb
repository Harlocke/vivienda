class Contratosimagen < ActiveRecord::Base
  belongs_to :contrato
  belongs_to :user

  #has_attached_file :contrato, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  has_attached_file :contrato
  validates_presence_of :descripcion
  validates_attachment_presence :contrato, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_content_type :contrato, :content_type => ['application/pdf'], :message => 'El formato del archivo debe ser PDF!!'
  validates_attachment_size :contrato, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

end

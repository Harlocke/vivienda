class Quejasimagen < ActiveRecord::Base
  belongs_to :queja
  belongs_to :user
  
  has_attached_file :queja, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :queja, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_content_type :queja, :content_type => ['application/pdf'], :message => 'El formato del archivo debe ser PDF!!'
  validates_attachment_size :queja, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'	
end

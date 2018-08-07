class Empleadosimagen < ActiveRecord::Base
  belongs_to :empleado
  belongs_to :user
  belongs_to :empleadostipo
  
  has_attached_file :empleado
  validates_attachment_presence :empleado, :message => 'Debe seleccionar un archivo valido!!'
  #validates_attachment_content_type :empleado, :content_type => ['application/pdf'], :message => 'El formato del archivo debe ser PDF!!'
  validates_attachment_size :empleado, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'



end

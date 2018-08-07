class Conveniosimagen < ActiveRecord::Base
  belongs_to :convenio
  belongs_to :user

  has_attached_file :convenio, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :convenio, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_content_type :convenio, :content_type => ['application/pdf'], :message => 'El formato del archivo debe ser PDF!!'
  validates_attachment_size :convenio, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'
end

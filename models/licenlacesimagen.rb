class Licenlacesimagen < ActiveRecord::Base
  belongs_to :licitacionesenlace
  has_attached_file :licenlace, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false

  validates_presence_of :descripcion
  validates_attachment_content_type :licenlace, :content_type => ['image/jpeg', 'image/png','image/pjpeg'], :message => 'El formato del archivo debe ser (PNG,JPG,JPEG)!!'
  validates_attachment_size :licenlace, :less_than => 1500.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 1.5 Megabytes!!!'
  validates_attachment_presence :licenlace, :message => 'Debe seleccionar un archivo valido!!'
  validate :descripcions

  def descripcions
    if Licenlacesimagen.exists?(["licitacionesenlace_id = #{self.licitacionesenlace_id} and descripcion = '#{self.descripcion.to_s}'"]) == true
      errors.add :descripcion, "Ya existe documento digital para el '#{self.descripcion.to_s}', Verifique!!!"
    end
  end  
end

class Iguanasimagen < ActiveRecord::Base
  belongs_to :iguana

  validates_presence_of :descripcion, :if => :in_us1?
  validates_presence_of :iguanastipo_id, :if => :in_us2?

  def in_us1?
    Iguana.find(self.iguana_id).clasereasentamiento.to_s != 'SANLUIS'
  end

  def in_us2?
    Iguana.find(self.iguana_id).clasereasentamiento.to_s == 'SANLUIS'
  end

  has_attached_file :iguana, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :iguana, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_content_type :iguana, :content_type => ['application/pdf','image/jpeg', 'image/png','image/pjpeg'], :message => 'El formato del archivo debe ser PDF - JPG - PNG!!'
  validates_attachment_size :iguana, :less_than => 8000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 8 Megabytes!!!'

end

class Mejoraelementosimagen < ActiveRecord::Base
  belongs_to :mejoramientoselemento
  has_attached_file :mejoraelemento, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false

  validates_presence_of :cuando
  validates_attachment_content_type :mejoraelemento, :content_type => ['image/jpeg', 'image/png','image/pjpeg'], :message => 'El formato del archivo debe ser (PNG,JPG,JPEG)!!'
  validates_attachment_size :mejoraelemento, :less_than => 4000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 4 Megabytes!!!'
  validates_attachment_presence :mejoraelemento, :message => 'Debe seleccionar un archivo valido!!'
  validate :cuandos

  def cuandos
    if Mejoraelementosimagen.exists?(["mejoramientoselemento_id = #{self.mejoramientoselemento_id} and cuando = '#{self.cuando.to_s}'"]) == true
      errors.add :cuando, "Ya existe documento digital para el '#{self.cuando.to_s}', Verifique!!!"
    end
  end
end

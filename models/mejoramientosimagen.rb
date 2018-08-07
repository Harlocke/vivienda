class Mejoramientosimagen < ActiveRecord::Base
  belongs_to :mejoramiento
  validates_presence_of :descripcion
  has_attached_file :mejoramiento, :styles => { :medium => "300x300>", :thumb => "100x100>"}, :whiny => false
  validates_attachment_presence :mejoramiento, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_size :mejoramiento, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'
  validate :cuandos

  def cuandos
    if self.cuando.to_s != ""
      if self.cuando.to_s == "ANTES" or self.cuando.to_s == "DURANTE" or self.cuando.to_s == "DESPUES"
        if Mejoramientosimagen.exists?(["mejoramiento_id = #{self.mejoramiento_id} and cuando = '#{self.cuando.to_s}'"]) == true
          errors.add :cuando, "Ya existe documento digital para el '#{self.cuando.to_s}', Verifique!!!"
        end
      end
    end
  end

  def in_us1?
    self.cuando.to_s == "EXPEDIENTE DE DIAGNOSTICO" or self.cuando.to_s == "EXPEDIENTE DE CIERRE"
  end

  def in_us2?
    self.cuando.to_s != "EXPEDIENTE DE DIAGNOSTICO" and self.cuando.to_s != "EXPEDIENTE DE CIERRE"
  end
  

    def is_image?
        attachment.instance.attachment_content_type =~ %r(image)
    end
end


class Crucesimagen < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user

  has_attached_file :cruce
  validates_attachment_presence :cruce, :message => 'Debe seleccionar un archivo valido!!'
  validates_attachment_content_type :cruce, :content_type => ['application/pdf'], :message => 'El formato del archivo debe ser PDF!!'
  validates_attachment_size :cruce, :less_than => 7000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 7 Megabytes!!!'

=begin
  def before_create
  	dato = self.cruce_file_name
    dato = dato.gsub(".pdf","")
    dato = dato.gsub(".PDF","")
    dato = dato.gsub("_","")
    dato = dato.gsub("ZR","")
    dato = dato.gsub("zr","")
    if Persona.exists?(["identificacion = '#{dato}'"])
      self.persona_id = Persona.find_by_identificacion(dato).id
    end
  end
=end

end

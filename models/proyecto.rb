class Proyecto < ActiveRecord::Base
  has_many :bloques
  has_many :viviendas
  has_many :fichas
  has_many :proyectosfichas
  has_many :proyectoscopropiedades, :dependent =>:destroy
  has_many :proyectosdocumentos, :dependent =>:destroy
  has_many :proyectosfactibilidades, :dependent =>:destroy
  belongs_to :user

  validates_presence_of :descripcion

  has_attached_file :foto, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_attachment_presence :foto, :message => 'Debe seleccionar un archivo valido!!'
                  
  def name
    self.descripcion
  end

  acts_as_chainable :to => :bloque,
                    :root => true,
                    :order => :descripcion

  after_create :crear_ficha
  #after_save :crear_ficha

  def crear_ficha
    # Cuando se va a crear
    id_proyecto     = Proyecto.maximum('id')
    r = Proyectosficha.new
    r.proyecto_id = id_proyecto
    r.save
    # cuando es update id_proyecto     = self.id
#    fichaselementos = Fichaselemento.find(:all)
#    fichaselementos.each do |data|
#      r = Ficha.new
#      r.proyecto_id = id_proyecto
#      r.fichaselemento_id = data.id
#      r.save
#    end
  end

end

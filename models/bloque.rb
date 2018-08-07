class Bloque < ActiveRecord::Base
  belongs_to :proyecto
  has_many :pisos
  has_many :viviendas
  has_many :proyectoscopbloques
  
  validates_presence_of :descripcion

   def name
    self.descripcion
  end
  
  acts_as_chainable :select_label => 'Bloque',
                    :to => :piso,
                    :from => :proyecto,
                    :order => :descripcion
end

class Piso < ActiveRecord::Base
  belongs_to :bloque
  has_many :aptos
  has_many :locales
  has_many :viviendas

  validates_presence_of :descripcion

  def name
    self.descripcion
  end
  
  acts_as_chainable :select_label => 'Piso',
                    :to => :apto,
                    :from => :bloque,
                    :order => :descripcion
end

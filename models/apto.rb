class Apto < ActiveRecord::Base
  belongs_to :piso
  has_many :viviendas

  validates_presence_of :descripcion

  def name
    self.descripcion
  end
  

  acts_as_chainable :select_label => 'Apartamento',
                    :from => :piso,
                    :order => :descripcion
end

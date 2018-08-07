class Aclasificacion < ActiveRecord::Base
	has_many :aetapas
  
  def name
    self.descripcion
  end

  acts_as_chainable :select_label => 'Clasificación',
                    :to => :aetapa,
                    :root => true,
                    :order => :descripcion
end

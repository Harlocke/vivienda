class Aetapa < ActiveRecord::Base
  belongs_to :aclasificacion

  def name
    self.descripcion
  end
  
  acts_as_chainable :select_label => 'Etapa',
                    :from => :aclasificacion,
                    :order => :descripcion
end

class Local < ActiveRecord::Base
  belongs_to :piso

  validates_presence_of :descripcion

  def name
    self.descripcion
  end
 

  acts_as_chainable :select_label => 'Locales',
                    :from => :piso,
                    :order => :descripcion

end

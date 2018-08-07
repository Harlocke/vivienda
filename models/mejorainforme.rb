class Mejorainforme < ActiveRecord::Base
  has_many :mejorainformeslistas, :dependent =>:destroy
  belongs_to :resolucion
  belongs_to :convenio
  belongs_to :user

end

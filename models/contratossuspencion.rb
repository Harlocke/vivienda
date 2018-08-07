class Contratossuspencion < ActiveRecord::Base
  belongs_to :contrato
  belongs_to :user

  validates_presence_of :nro_suspension, :fecha_suspension
  validates_numericality_of :nro_suspension

end

class Conveniospago < ActiveRecord::Base
  belongs_to :convenio
  belongs_to :user
  validates_presence_of :tipopago, :valor, :fecha
  validates_numericality_of :valor

end

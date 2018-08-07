class Conveniosmejoramiento < ActiveRecord::Base
  belongs_to :convenio
  belongs_to :user
  belongs_to :mejoramientositem
  
  validates_presence_of :mejoramientositem_id, :valor_unitario
  validates_numericality_of :valor_unitario

end

class Contratosrubro < ActiveRecord::Base
  belongs_to :contrato
  belongs_to :rubro
  belongs_to :user

  validates_presence_of :rubro_id, :valor
  validates_numericality_of :valor
  
end

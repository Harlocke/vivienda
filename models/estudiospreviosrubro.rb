class Estudiospreviosrubro < ActiveRecord::Base
  belongs_to :estudiosprevio
  belongs_to :rubro
  validates_presence_of :rubro_id, :valor
end

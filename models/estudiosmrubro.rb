class Estudiosmrubro < ActiveRecord::Base
  belongs_to :estudiosmodificacion
  belongs_to :rubro

  validates_presence_of :rubro_id, :valor

end

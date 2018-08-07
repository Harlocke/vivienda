class Elementoscaracteristica < ActiveRecord::Base
  belongs_to :elemento
  belongs_to :tiposcaracteristica

  validates_presence_of :tiposcaracteristica_id, :descripcion
end

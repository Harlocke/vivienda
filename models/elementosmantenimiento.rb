class Elementosmantenimiento < ActiveRecord::Base
  belongs_to :elemento
  belongs_to :user
  has_many :elementosimagenes, :dependent =>:destroy

  validates_presence_of :tipo, :fecha_mantenimiento, :descripcion

end

class Impresorasreporte < ActiveRecord::Base
  belongs_to :impresora
  belongs_to :user
  has_many :impresorasimagenes, :dependent =>:destroy

  validates_presence_of :fecha_solicitud, :fecha_atencion, :observacion

end

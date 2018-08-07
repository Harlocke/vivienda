class Titulacionesdemanda < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :user

  has_many :titulacionesseguimientos, :dependent =>:destroy

  validates_presence_of :tipoproceso, :radicado, :fecha_radicado, :juzgado, :estado
  
end

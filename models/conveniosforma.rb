class Conveniosforma < ActiveRecord::Base
  belongs_to :convenio
  belongs_to :user
  belongs_to :resolucion
  has_many :mejoramientospagos
  has_many :conveniosresolintenciones

  validates_presence_of :porcentaje, :clase, :porc_avance, :resolucion_id
  validates_numericality_of :porcentaje, :porc_avance
end

class Repartosacto < ActiveRecord::Base
  belongs_to :reparto
  belongs_to :tiposacto
  belongs_to :user
  has_many :repartosactosdocumentos

  validates_presence_of :tiposacto_id, :valor
  validates_numericality_of :valor

end

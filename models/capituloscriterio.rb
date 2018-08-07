class Capituloscriterio < ActiveRecord::Base
  belongs_to :capitulo
  belongs_to :mejorainformescriterio
  has_many :mejorainformescriterios
end

class Capitulo < ActiveRecord::Base
  has_many :mejoramientositems
  has_many :capituloscriterios
end

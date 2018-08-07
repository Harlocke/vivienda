class Gruposactividad < ActiveRecord::Base
  has_many :analisisprecios
  belongs_to :grupo
end

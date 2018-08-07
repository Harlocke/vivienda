class Familiar < ActiveRecord::Base
  has_many :personas
  has_many :viviendasusadas
end

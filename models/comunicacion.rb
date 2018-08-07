class Comunicacion < ActiveRecord::Base
  has_many :comunicacionesusers
  validates_presence_of :fecha, :url
  validates_uniqueness_of :fecha
end

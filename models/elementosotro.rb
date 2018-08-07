class Elementosotro < ActiveRecord::Base
  belongs_to :elemento
  belongs_to :user
  has_many :elementosotrossoportes

  validates_presence_of :fecha, :observaciones
end

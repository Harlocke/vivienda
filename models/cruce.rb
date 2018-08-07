class Cruce < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user
  has_many :crucesdatos
end

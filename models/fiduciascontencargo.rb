class Fiduciascontencargo < ActiveRecord::Base
  belongs_to :fiduciascontrato
  belongs_to :user
end

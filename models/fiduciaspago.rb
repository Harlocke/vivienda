class Fiduciaspago < ActiveRecord::Base
  belongs_to :fiducia
  belongs_to :user
end

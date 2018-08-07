class Crucessolicitud < ActiveRecord::Base
  belongs_to :user
  belongs_to :persona
end

class Antbenevivienda < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user
end

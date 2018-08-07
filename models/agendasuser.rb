class Agendasuser < ActiveRecord::Base
  belongs_to :agenda
  belongs_to :user
end

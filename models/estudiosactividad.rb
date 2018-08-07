class Estudiosactividad < ActiveRecord::Base
  belongs_to :estudiosprevio
  belongs_to :user
  validates_presence_of :observaciones

end

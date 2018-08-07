class Calidaddocnota < ActiveRecord::Base
  belongs_to :user
  belongs_to :calidaddocumento
  validates_presence_of :observaciones

end

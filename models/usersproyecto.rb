class Usersproyecto < ActiveRecord::Base
  belongs_to :user
  belongs_to :proyecto

  validates_presence_of :proyecto_id
  validates_uniqueness_of :proyecto_id, :scope => :user_id
end

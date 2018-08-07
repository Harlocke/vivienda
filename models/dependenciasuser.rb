class Dependenciasuser < ActiveRecord::Base
  belongs_to :dependencia
  belongs_to :user

  validates_presence_of :user_id
end

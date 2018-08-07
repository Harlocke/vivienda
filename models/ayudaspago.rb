class Ayudaspago < ActiveRecord::Base
  belongs_to :ayuda
  belongs_to :user
end

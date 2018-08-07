class Mensajesuser < ActiveRecord::Base
  belongs_to :user
  belongs_to :mensaje
end

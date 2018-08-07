class Ayudasficha < ActiveRecord::Base
  belongs_to :ayuda
  belongs_to :user
  belongs_to :ayudastiposevento
end

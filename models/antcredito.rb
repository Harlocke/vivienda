class Antcredito < ActiveRecord::Base
  belongs_to :persona
  belongs_to :entidad
  belongs_to :user
end

class Mejoramientosinforme < ActiveRecord::Base
  belongs_to :user
  has_many :mejorainformeselementos, :dependent =>:destroy
  belongs_to :mejoramientosinterventoria

end

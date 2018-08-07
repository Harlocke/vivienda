class Lote < ActiveRecord::Base

  has_many :lotesobservaciones, :dependent =>:destroy
  has_many :lotesimagenes, :dependent =>:destroy
  
end

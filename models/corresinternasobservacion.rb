class Corresinternasobservacion < ActiveRecord::Base
  belongs_to :correspondenciasinterna
  belongs_to :user
end

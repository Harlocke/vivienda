class Iguanasmejora < ActiveRecord::Base
  belongs_to :user
  belongs_to :iguana
  validates_presence_of :encuesta, :direccion
end

class Personasarrendamiento < ActiveRecord::Base
#  belongs_to :persona
  belongs_to :user

  #has_many :arrendamientossoportes
  has_many :arrendamientoscontratos
  
end

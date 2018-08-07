class Arrendamientoscontrato < ActiveRecord::Base
  belongs_to :personasarrendamieno
  belongs_to :user
end

class Fiduciascontrato < ActiveRecord::Base
  belongs_to :user
  belongs_to :fiducia
  has_many :fiduciascontencargos
  has_many :fiduciasconmodificaciones
  has_many :fiduciasimagenes, :dependent =>:destroy
end



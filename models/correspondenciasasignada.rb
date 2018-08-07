class Correspondenciasasignada < ActiveRecord::Base
  belongs_to :correspondenciasrecibida
  belongs_to :user
end

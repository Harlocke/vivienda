class Correspondenciasrecibidasuser < ActiveRecord::Base
    belongs_to :user
    belongs_to :correspondenciasrecibida

  validates_presence_of :user_id

end

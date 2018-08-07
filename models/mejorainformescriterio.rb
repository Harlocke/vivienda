class Mejorainformescriterio < ActiveRecord::Base
  belongs_to :user
  belongs_to :mejorainformeselemento
  belongs_to :capituloscriterio
  validates_presence_of :capituloscriterio_id
end

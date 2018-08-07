class Crucesdato < ActiveRecord::Base
  belongs_to :cruce
  validates_presence_of :ratifica_observaciones, :if => :us_01?

  def us_01?
    self.ratifica.to_s == "NO"
  end
end

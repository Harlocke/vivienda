class Lotesobservacion < ActiveRecord::Base
  belongs_to :user
  belongs_to :lote

  validates_presence_of :observacion, :tipo

  def dtipo
     if self.tipo == "1"
       return "OBSERVACION"
     elsif self.tipo == "2"
       return "ACTUACION"
     end
  end
  
end

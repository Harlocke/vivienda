class Ficha < ActiveRecord::Base
  
    belongs_to :fichaselemento
    belongs_to :proyecto

end

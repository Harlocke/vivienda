class Personastramite < ActiveRecord::Base
   belongs_to :persona
   belongs_to :viviendastipostramite

   validates_presence_of :viviendastipostramite_id, :fecha_inicio
end

class Viviendasusadastramite < ActiveRecord::Base
   belongs_to :viviendasusada
   belongs_to :tipostramite
   validates_presence_of :tipostramite_id
   validates_presence_of :fecha_solicitud
end

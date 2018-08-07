class Calidadnormogramasproceso < ActiveRecord::Base
  belongs_to :calidadnormograma
  belongs_to :calidadproceso
  validates_presence_of :calidadproceso_id


end

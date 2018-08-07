class Conveniosetapa < ActiveRecord::Base
  belongs_to :convenio
  belongs_to :user

  validates_presence_of :etapa, :fechainicio, :finaliza, :persona_id

end

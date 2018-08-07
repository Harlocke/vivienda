class Proyectosficha < ActiveRecord::Base
  belongs_to :proyecto
  belongs_to :comuna
  has_many :proyectosfichasimagenes

  def instrumentogestion
     if self.instrumento_gestion == "1"
       return "MACROPROYECTO"
     elsif self.instrumento_gestion == "2"
       return "PLAN PARCIAL"
     elsif self.instrumento_gestion == "3"
       return "REGULARIZACION URBANISTICA"
     elsif self.instrumento_gestion == "4"
       return "PLANES DE SOLUCIONES DE VIVIENDA"
     end
  end
end
class Empleadoscapacitacion < ActiveRecord::Base
  belongs_to :empleado
  
  def dpriorizacion
     if self.priorizacion == "1"
       return "ALTA"
     elsif self.priorizacion == "2"
       return "MEDIA"
     elsif self.priorizacion == "3"
       return "BAJA"
     else
       return "----"
     end
  end

  def dpoblacionobjeto
     if self.poblacion_objeto == "1"
       return "DIRECTIVO"
     elsif self.poblacion_objeto == "2"
       return "ASESOR"
     elsif self.poblacion_objeto == "3"
       return "PROFESIONAL"
     elsif self.poblacion_objeto == "4"
       return "TECNICO"
     elsif self.poblacion_objeto == "5"
       return "ASISTENCIAL"
     elsif self.poblacion_objeto == "6"
       return "TODOS"
     else
       return "----"
     end
  end
  
  def dsedicto
     if self.se_dicto == "S"
       return "SI"
     elsif self.se_dicto == "N"
       return "NO"
     else
       return "----"
     end
  end
  
  
  def dmetodos
     if self.metodos == "I"
       return "INTERNO"
     elsif self.metodos == "E"
       return "EXTERNO"
     else
       return "----"
     end
  end

  def drecursos
     if self.recursos == "E"
       return "DE EQUIPO"
     elsif self.recursos == "P"
       return "DE PERSONAL"
     else
       return "----"
     end
  end

  def devaluacioneficacia
     if self.evaluacion_eficacia == "S"
       return "SI"
     elsif self.evaluacion_eficacia == "N"
       return "NO"
     else
       return "----"
     end
  end

end

class Antsubsidio < ActiveRecord::Base
  belongs_to :persona
  belongs_to :tipos_subsidio
  belongs_to :user

  def tipocobro
     if self.tipo_cobro == "1"
       return "COBRO ANTICIPADO CON POLIZA"
     elsif self.tipo_cobro == "2"
       return "COBRO ANTICIPADO CON AVAL BANCARIO"
     elsif self.tipo_cobro == "3"
       return "CONTRAESCRITURA"
     elsif self.tipo_cobro == "4"
       return "LEGALIZACION 20% FINAL"
     end  
  end

  def estadoantsubsidio
     if self.estado == "1"
       return "COBRO ANTICIPADO"
     elsif self.estado == "2"
       return "LEGALIZADO"
     elsif self.estado == "3"
       return "RENUNCIA O REVOCADO"
     elsif self.estado == "4"
       return "PERDIDA DE VIGENCIA"
     elsif self.estado == "5"
       return "SIN COBRO VIGENTE"
     elsif self.estado == "6"
       return "RESTITUIDO"
     elsif self.estado == "7"
       return "COBRADO E SIN LEGALIZAR"
     elsif self.estado == "8"
       return "ARRIENDO PARCIAL"
     elsif self.estado == "9"
       return "ARRIENDO 100%"
     end
  end

  def entidadotorga
     if self.entidad_otorga == "1"
       return "FONVIVIENDA"
     elsif self.entidad_otorga == "2"
       return "COMFAMA"
     elsif self.entidad_otorga == "3"
       return "COMFENALCO"
     elsif self.entidad_otorga == "4"
       return "COMFAMILIAR CAMACOL"
     elsif self.entidad_otorga == "5"
       return "ISVIMED"
     end
  end

  def entidadadmin
     if self.entidad_admin == "1"
       return "COMFAMA"
     elsif self.entidad_admin == "2"
       return "COMFENALCO"
     elsif self.entidad_admin == "3"
       return "COMFAMILIAR CAMACOL"
     end
  end

end

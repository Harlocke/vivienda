class Subsidio < ActiveRecord::Base
  belongs_to :persona
  belongs_to :tipos_subsidio
  belongs_to :user
  
  validates_presence_of :tipos_subsidio_id, :resolucion, :fecha_asig
  validates_numericality_of :valor, :resolucion
  validates_numericality_of :valor_utilizado, :allow_nil => true, :if =>:valor_utilizado?

  def respaldo(userid)
    antsubsidio = Antsubsidio.new
    antsubsidio.persona_id = self.persona_id
    antsubsidio.consecutivo_viv = self.consecutivo_viv
    antsubsidio.tipos_subsidio_id = self.tipos_subsidio_id
    antsubsidio.valor = self.valor
    antsubsidio.resolucion = self.resolucion
    antsubsidio.fecha_asig = self.fecha_asig
    antsubsidio.entidad_otorga = self.entidad_otorga
    antsubsidio.fecha_cobro = self.fecha_cobro
    antsubsidio.tipo_cobro = self.tipo_cobro
    antsubsidio.fecha_subsidio = self.fecha_subsidio
    antsubsidio.estado = self.estado
    antsubsidio.entidad_admin = self.entidad_admin
    antsubsidio.fecha_pago = self.fecha_pago
    antsubsidio.solicitud_pago = self.solicitud_pago
    antsubsidio.modalidad = self.modalidad
    antsubsidio.fecha_vigencia = self.fecha_vigencia
    antsubsidio.estado_int = self.estado_int
    antsubsidio.valor_utilizado = self.valor_utilizado
    antsubsidio.bolsa = self.bolsa
    antsubsidio.user_id = userid
    antsubsidio.save
  end

  def tipocobro
    return self.tipo_cobro.to_s rescue nil
#     if self.tipo_cobro == "1"
#       return "COBRO ANTICIPADO CON POLIZA"
#     elsif self.tipo_cobro == "2"
#       return "COBRO ANTICIPADO CON AVAL BANCARIO"
#     elsif self.tipo_cobro == "3"
#       return "CONTRAESCRITURA"
#     elsif self.tipo_cobro == "4"
#       return "LEGALIZACION 20% FINAL"
#     end
  end

  def estadosubsidio
    return self.estado.to_s rescue nil
#     if self.estado == "1"
#       return "COBRO ANTICIPADO"
#     elsif self.estado == "2"
#       return "LEGALIZADO"
#     elsif self.estado == "3"
#       return "RENUNCIA O REVOCADO"
#     elsif self.estado == "4"
#       return "PERDIDA DE VIGENCIA"
#     elsif self.estado == "5"
#       return "SIN COBRO VIGENTE"
#     elsif self.estado == "6"
#       return "RESTITUIDO"
#     elsif self.estado == "7"
#       return "COBRADO E SIN LEGALIZAR"
#     elsif self.estado == "8"
#       return "ARRIENDO PARCIAL"
#     elsif self.estado == "9"
#       return "ARRIENDO 100%"
#     elsif self.estado == "10"
#       return "ASIGNADO CON APLICADO EN VG"
#     end
  end

  def entidadotorga
    return self.entidad_otorga.to_s rescue nil
#     if self.entidad_otorga == "1"
#       return "FONVIVIENDA"
#     elsif self.entidad_otorga == "2"
#       return "COMFAMA"
#     elsif self.entidad_otorga == "3"
#       return "COMFENALCO"
#     elsif self.entidad_otorga == "4"
#       return "COMFAMILIAR CAMACOL"
#     elsif self.entidad_otorga == "5"
#       return "ISVIMED"
#     elsif self.entidad_otorga == "6"
#       return "CCF CALDA"
#     end
  end

  def entidadadmin
    return self.entidad_admin.to_s rescue nil
#     if self.entidad_admin == "1"
#       return "COMFAMA"
#     elsif self.entidad_admin == "2"
#       return "COMFENALCO"
#     elsif self.entidad_admin == "3"
#       return "COMFAMILIAR CAMACOL"
#     end
  end
end

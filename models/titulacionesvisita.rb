class Titulacionesvisita < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :user

  validates_presence_of :clase, :tipo_atencion
  validates_presence_of :soc_estado,:soc_observaciones,:unidades, :if => :in_usa?
  validates_presence_of :soc_fecha_agenda, :if => :in_usa_1?
  validates_presence_of :soc_motivo, :if => :in_usa_2?

  validates_presence_of :lev_situacion,:lev_observaciones, :if => :in_usb?
  validates_presence_of :lev_fecha, :if => :in_usb_1?
  validates_presence_of :lev_motivo, :if => :in_usb_2?

  def after_create
    #Copia de la Observacion
    titulacionesobservacion = Titulacionesobservacion.new
    titulacionesobservacion.titulacion_id = self.titulacion_id
    titulacionesobservacion.user_id = self.user_id
    if self.clase.to_s == "VISITA DE SOCIALIZACION"
      titulacionesobservacion.observacion = self.soc_observaciones
    elsif self.clase.to_s == "VISITA DE LEVANTAMIENTO"
      titulacionesobservacion.observacion = self.lev_observaciones
    end
    titulacionesobservacion.tipo_atencion = self.tipo_atencion
    titulacionesobservacion.save
  end

  def in_usa?
    self.clase.to_s == "VISITA DE SOCIALIZACION"
  end

  def in_usa_1?
    self.clase.to_s == "VISITA DE SOCIALIZACION" and self.soc_estado.to_s == 'AGENDADA'
  end

  def in_usa_2?
    self.clase.to_s == "VISITA DE SOCIALIZACION" and self.soc_estado.to_s == 'NO APLICA'
  end

  def in_usb?
    self.clase.to_s == "VISITA DE LEVANTAMIENTO"
  end

  def in_usb_1?
    self.clase.to_s == "VISITA DE LEVANTAMIENTO" and self.lev_situacion.to_s == 'EFECTIVA'
  end

  def in_usb_2?
    self.clase.to_s == "VISITA DE LEVANTAMIENTO" and self.lev_situacion.to_s == 'FALLIDA'
  end

  def dtipoatencion
     if self.tipo_atencion == "1"
       return "PERSONALIZADA"
     elsif self.tipo_atencion == "2"
       return "TELEFONICA"
     elsif self.tipo_atencion == "3"
       return "DOMICILIARIA"
     elsif self.tipo_atencion == "4"
       return "OTRA"
     end
  end
end

class Quejasobservacion < ActiveRecord::Base
  belongs_to :user
  belongs_to :queja
  has_many :quejassoportes

  validates_presence_of :observacion, :tipo_atencion

  def after_create
    #Copia de la Observacion a PERSONAS..
    queja = Queja.find(self.queja_id)
    if queja.persona_id
      p = Personasobservacion.new
      p.user_id = self.user_id
      p.tipo_atencion = self.tipo_atencion
      p.observacion = "OBSERVACION PQRS - " + self.observacion
      p.persona_id = queja.persona_id
      p.created_at = self.created_at
      p.save
    end
    ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{queja.id} and fin is null")
    quejasbitacora = Quejasbitacora.new
    quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{queja.id}"]).to_i + 1
    quejasbitacora.queja_id = queja.id
    quejasbitacora.actividad = "REGISTRO DE ATENCION #{self.dtipoatencion.to_s} DEL PQRS: " + self.observacion.to_s
    quejasbitacora.inicio = Time.now
    quejasbitacora.user_id = self.user_id
    quejasbitacora.quejasobservacion_id = self.id
    quejasbitacora.save
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
     elsif self.tipo_atencion == "5"
       return "CIERRE PQRS"
     end
  end

end

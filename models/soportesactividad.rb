class Soportesactividad < ActiveRecord::Base
  belongs_to :user
  belongs_to :soporte

  #validates_presence_of :solucionado, :observacion

  def after_create
    if self.solucionado == 1
      soporte = Soporte.find(self.soporte_id)
      cadena = "SR(A) "
      cadena = cadena + soporte.user.nombre.to_s
      cadena = cadena + ". EL TICKET NRO. "
      cadena = cadena + soporte.id.to_s
      cadena = cadena + ' ('+ soporte.descripcion.to_s+'). HA SIDO SOLUCIONADO.'
      ActiveRecord::Base.connection.execute(
        "insert into mensajesenvios (id,user_id,descripcion,estado,soporte_id,created_at,updated_at)
         values (mensajesenvios_seq.nextval,#{soporte.user_id},'#{cadena}','A',#{soporte.id},sysdate,sysdate)")
      Notifier.deliver_notificajefe_message(soporte)
    end
  end

  def estadosolicitud
     if self.solucionado == 1
       return "SI"
     elsif self.solucionado == 2
       return "NO"
     end
  end

end

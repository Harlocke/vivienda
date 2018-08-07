class Vehiculosprogramacion < ActiveRecord::Base
  belongs_to :vehiculo
  belongs_to :vehiculoshorario
  belongs_to :user
  validates_presence_of :horafinal, :user_id, :destino, :nro_pasajeros
  validates_numericality_of :nro_pasajeros
  validate :repeticion
  
  def after_save
      if self.horafinal_ant.to_i > 0
        ActiveRecord::Base.connection.execute("update vehiculosprogramaciones set user_id = null,
                                                                                  destino = null,
                                                                                  programainicial = null,
                                                                                  horafinal_ant = null,
                                                                                  horafinal = null
                                               where  fecha = '#{self.fecha.to_date}'
                                               and vehiculo_id = #{self.vehiculo_id}
                                               and vehiculoshorario_id between #{self.vehiculoshorario_id.to_i + 1} and #{self.horafinal_ant}")
      end
      ActiveRecord::Base.connection.execute("update vehiculosprogramaciones set user_id = #{self.user_id},
                                                                                destino = '#{self.destino}',
                                                                                programainicial = #{self.id}
                                             where  fecha = '#{self.fecha.to_date}'
                                             and vehiculo_id = #{self.vehiculo_id}
                                             and vehiculoshorario_id between #{self.vehiculoshorario_id.to_i + 1} and #{self.horafinal}")
  end

  def repeticion
    @vehiculosprogramacion = Vehiculosprogramacion.find(self.id)
    #logger.error("Error ....."+@vehiculosprogramacion.user_id.to_s)
    if @vehiculosprogramacion.user_id.to_s != ""
      #logger.error("Ingreso")
      if @vehiculosprogramacion.horafinal.to_i < self.horafinal.to_i
        if Vehiculosprogramacion.exists?(["fecha = '#{self.fecha.to_date}'
                                           and vehiculo_id = #{self.vehiculo_id}
                                           and vehiculoshorario_id between #{@vehiculosprogramacion.horafinal.to_i + 1} and #{self.horafinal}
                                           and user_id is not null"])
          #Se coloca esta regla porque cuando intenta guardar el sistema inexplicablemente almacena un dato en una variable de control
          ActiveRecord::Base.connection.execute("update vehiculosprogramaciones set horafinal_ant = null, horafinal = null
                                                 where  id = '#{self.id}'")
          errors.add :horafinal, "El rango de tiempo solicitado ya esta en uso1. Verifique!!"
        end
      end
    else
      logger.error("Ingreso2")
      if Vehiculosprogramacion.exists?(["fecha = '#{self.fecha.to_date}'
                                         and vehiculo_id = #{self.vehiculo_id}
                                         and vehiculoshorario_id between #{self.vehiculoshorario_id.to_i + 1} and #{self.horafinal}
                                         and user_id is not null"])
          #Se coloca esta regla porque cuando intenta guardar el sistema inexplicablemente almacena un dato en una variable de control
        errors.add :horafinal, "El rango de tiempo solicitado ya esta en uso2. Verifique!!"
      end
    end
  end

  def permiteactualizar
    if self.fecha <= Time.now
      return 'N'
    else
      return 'S'
    end
  end

  def responsable
    return self.user.responsable rescue nil
  end

  def responsablenombre
    cadena = self.user.responsablenombre.to_s + " Tel: " + self.user.telefonos.to_s
    return cadena rescue nil
  end

  def responsabledependencia
    return self.user.dependencia.descripcion rescue nil
  end

  def solicitante
    return User.find(self.user_actualiza).responsable rescue nil
  end

  def horafinvehiculo
    return Vehiculoshorario.find(self.horafinal).descripcion rescue nil
  end

end

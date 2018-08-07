class Agenda < ActiveRecord::Base
  belongs_to :persona
  belongs_to :propietario

  validates_presence_of :agendasproceso,:agendasfecha,:agendashorario

  validate :yasignados,:validadiayhora

  def validadiayhora
    if self.id.to_i == 0
      begin
        if self.agendasfecha and self.agendashorario
          dia = Agendasfecha.find(self.agendasfecha).fecha.strftime("%Y-%m-%d").to_s
          hoy = Time.now.strftime("%Y-%m-%d").to_s
          hora = Agendashorario.find(self.agendashorario).hora.strftime("%X").to_s rescue nil
          horaya = Time.now.strftime("%X").to_s
          if (dia == hoy) and (hora <= horaya)
            errors.add :agendashorario, "* Este horario ya no es valido para Solicitar la Cita, ya paso el tiempo..."
          end
        end
      rescue
        logger.error("No hay datos")
        #errors.add :agendashorario, "* Formato Invalido"
      end
    end
  end

  def yasignados
    if self.id.to_i == 0
      @cantidadhabilitada = Agendashorario.find(self.agendashorario.to_i).cantidad.to_i rescue 0
      @cantidadreg = Agenda.count("id", :conditions=>["agendashorario = #{self.agendashorario.to_i}"]).to_i + 1
      if @cantidadreg.to_i > @cantidadhabilitada.to_i
        errors.add :agendashorario, "* El horario ya fue asignado, escoje otro..."
      end
    end
  end

  def after_create
    #Gestion automatica de creacion
    ayudasobs = Ayudasobservacion.new
    ayudasobs.tipo_atencion = '1'
    ayudasobs.observacion = self.registrogestion
    ayudasobs.ayuda_id = self.ayuda_id
    ayudasobs.user_id = self.user_id
    ayudasobs.save
  end 

  def lugaragenda
    @agendasproceso = Agendasproceso.find(self.agendasproceso)
    return @agendasproceso.descripcion.to_s rescue nil
  end

  def fechaagenda
    return Agendasfecha.find(self.agendasfecha).fecha.strftime("%Y-%m-%d").to_s rescue nil
  end

  def horaagenda
    return Agendashorario.find(self.agendashorario).horario.to_s rescue nil
  end

  def datouseratencion
    return User.find(self.useratencion_id).username.to_s
  end

  def registrogestion
    dato = "CITA REGISTRADA PARA EL PROCESO #{self.lugaragenda.to_s}, PARA EL DIA #{self.fechaagenda.to_s} A LAS #{self.horaagenda.to_s}"
  end

  def registrogestion_atencion
    dato = "CITA ATENDIDA PARA EL PROCESO #{self.lugaragenda.to_s}, PARA EL DIA #{self.fechaagenda.to_s} A LAS #{self.horaagenda.to_s}"
  end  

  def registrogestion_cancelada
    dato = "CITA CANCELADA PARA EL PROCESO #{self.lugaragenda.to_s}, PARA EL DIA #{self.fechaagenda.to_s} A LAS #{self.horaagenda.to_s}"
  end  

  def registrogestion_noasistio
    dato = "CITA INCUMPLIDA PARA EL PROCESO #{self.lugaragenda.to_s}, PARA EL DIA #{self.fechaagenda.to_s} A LAS #{self.horaagenda.to_s}"    
  end


  def self.searchidentifi(search, page)
    cadena = ""
    if search.to_s == ""
      paginate :per_page => 10, :page => page, :conditions => ["persona_id = '-1'"]
    else
      cadena = "persona_id in (select distinct persona_id from relaciones where identificacion = '#{search.to_s}')
               and agendasfecha in (select id from agendasfechas where fecha = trunc(sysdate))"
      paginate :per_page => 10, :page => page, :conditions => [cadena], :order=>'persona_id'
    end
  end
end





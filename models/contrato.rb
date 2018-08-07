class Contrato < ActiveRecord::Base
  belongs_to :empleado
  belongs_to :tiposcontrato
  belongs_to :modalidad
  has_many :convenioscontratos
  has_many :seguimientos
  has_many :estudiosprevios

  require 'number_to_words'

  has_many :contratosmodificaciones, :dependent =>:destroy
  has_many :contratosrubros, :dependent =>:destroy
  has_many :contratosimagenes, :dependent =>:destroy
  has_many :contratospagos, :dependent =>:destroy
  has_many :contratossuspenciones, :dependent =>:destroy
  has_many :contratosobservaciones, :dependent =>:destroy
  has_many :interventorias, :dependent =>:destroy
  has_many :contratosinterventorias, :dependent =>:destroy

  validates_presence_of :fecha_firma, :objeto, :valor_contrato, :poliza, :modalidad_id, :interventorempleado_id
  validates_numericality_of :valor_contrato
  validates_numericality_of :valor_mes, :if => :in_usarl?
  validates_presence_of :plazo_mes, :if => :in_us?
  validates_presence_of :plazo_dias, :if => :in_us2?
  validates_numericality_of :plazo_mes, :if => :in_us?
  validates_numericality_of :plazo_dias, :if => :in_us2?
  validate :fechaarl, :if => :in_usarl?

  def fechaarl
    if self.fecha_arl.to_s != "" and self.fecha_inicio.to_s != ""
      #logger.error("Error de fecha arl")
      if self.fecha_inicio.to_date < self.fecha_arl.to_date
        errors.add :fecha_arl, "* La fecha de inicio del contrato no puede ser inferior a la fecha de vinculacion inicial de la ARL"
        errors.add :fecha_inicio, "* La fecha de inicio del contrato no puede ser inferior a la fecha de vinculacion inicial de la ARL"
      end
    end
  end

  def in_us2?
    plazo_dias.to_s  == ""
  end

  def in_usarl?
    fecha_inicio.to_date <= '01-01-2016'.to_date
  end

  def in_us?
    plazo_mes.to_s  == ""
  end


  def destado
    if self.estado == "P"
     return "PERFECCIONADO"
    elsif self.estado == "E"
     return "EN EJECUCION"
    elsif self.estado == "L"
     return "EN LIQUDIACION"
    elsif self.estado == "I"
     return "LIQUIDADO"
    elsif self.estado == "A"
     return "ANULADO"
    elsif self.estado == "T"
     return "TERMINADO"
    else
     return "----"
    end
  end

  def namesdatehoy
    return namedate(Time.now)
  end

  def namedatefchdispo
    return namedate(self.fecha_disponibilidad)
  end

  def namedatefchinicio
    return namedate(self.fecha_inicio)
  end

  def dpublicaciongazeta
     if self.publicacion_gazeta == "S"
       return "SI"
     elsif self.publicacion_gazeta == "N"
       return "NO"
     elsif self.publicacion_gazeta == "NA"
       return "NO APLICA"
     else
       return "----"
     end
  end

  def dpublicacionsecop
     if self.publicacion_secop == "S"
       return "SI"
     elsif self.publicacion_secop == "N"
       return "NO"
     elsif self.publicacion_secop == "NA"
       return "NO APLICA"
     else
       return "----"
     end
  end

  def dpublicacioncc
     if self.publicacion_cc == "S"
       return "SI"
     elsif self.publicacion_cc == "N"
       return "NO"
     elsif self.publicacion_cc == "NA"
       return "NO APLICA"
     else
       return "----"
     end
  end  

  def dpoliza
     if self.poliza == "S"
       return "SI"
     elsif self.poliza == "N"
       return "NO"
     elsif self.poliza == "NA"
       return "NO APLICA"
     else
       return "----"
     end
  end

  def valoradiciones(id_contrato)
    valor = Contratosmodificacion.sum('valor',:conditions=>["contrato_id = ?", id_contrato])
    return valor
  end

  def valorpagado(id_contrato)
    valor = Contratospago.sum('valor_total',:conditions=>["contrato_id = ?", id_contrato])
    return valor
  end

   def namedate(fecha)
     day_names = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"]
     month_names = ["","Enero","Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Setiembre", "Octubre", "Noviembre", "Diciembre"]
     dia = fecha.strftime("%w").to_i
     ndia = day_names[dia]
     mes = fecha.strftime("%m").to_i
     nmes = month_names[mes]
     fchcompleta = ndia + ' ' + fecha.strftime("%d") + ' de ' + nmes + ' del ' + fecha.strftime("%Y")
     return fchcompleta
   end

   def fechafinalreal
     if self.fecha_masmodi.to_s != ""
       return self.fecha_masmodi rescue nil
     else
       return self.fecha_final rescue nil
     end
   end

   def valorreal
     if self.valor_masmodi.to_s != ""
       return self.valor_masmodi.to_s
     else
       return self.valor_contrato.to_s
     end
   end

  def valormes
   if self.valor_mes.to_i > 0
      return self.valor_mes.to_i
   else
      @diasm = 0
      @mesdiasm = 0
      if self.plazo_dias.to_i > 0
        @dias = (self.plazo_dias.to_f / 30.to_f).to_f
        #logger.error("valorbasecotizacion 0 ---- "+@dias.to_s)
        @mesdias = self.plazo_mes.to_f + @dias.to_f
        #logger.error("valorbasecotizacion 1 ---- "+@mesdias.to_s)
      else
        @mesdias = self.plazo_mes.to_f
      end
      if Contratosmodificacion.exists?(["contrato_id = #{self.id}"]) == true
        contratosmodificaciones = Contratosmodificacion.find(:all, :conditions=>["contrato_id = #{self.id}"])
        contratosmodificaciones.each do |contratosmodificacion|
          if contratosmodificacion.plazo_dias.to_i > 0
            @diasm = @diasm.to_f + (contratosmodificacion.plazo_dias.to_f / 30.to_f).to_f
            #logger.error("valorbasecotizacion 0 ---- "+@dias.to_s)
            @mesdiasm = @mesdiasm.to_f + contratosmodificacion.plazo_mes.to_f + @diasm.to_f
            #logger.error("valorbasecotizacion 1 ---- "+@mesdias.to_s)
          else
            @mesdiasm = @mesdiasm.to_f + contratosmodificacion.plazo_mes.to_f
          end
        end
      end
      @mesdias = @mesdias.to_f + @mesdiasm.to_f
      #logger.error("valorbasecotizacion 1 ---- "+self.valorreal.to_s)
      #logger.error("valorbasecotizacion 2 ---- "+@sss.to_s)
      return (self.valorreal.to_f/@mesdias.to_f.round(2)) rescue 0
    end
  end
  
  def existeinterventoria(anno, mes)
    if Interventoria.exists?(["contrato_id = #{self.id} and anno = '#{anno}' and mes = #{mes}"]) == true
      interventoria = Interventoria.find_by_contrato_id_and_anno_and_mes(self.id,anno,mes)
      if interventoria.estado.to_s == 'PENDIENTE'
         if interventoria.interactividades.count(:all, :conditions=>["desarrollo is null"]) == 0
           return "<img src='/images/blanco1.png' title='Informe con actividades listas y pendiente de envio a revision'/>"
         else
           return "<img src='/images/info1.png' title='Informe con actividades pendientes'/>"
         end
      elsif interventoria.estado.to_s == 'REVISION'
         return "<img src='/images/amarillo1.png' title='Informe enviado para revisión del Interventor'/>"
      elsif interventoria.estado.to_s == 'RECHAZADO'
         return "<img src='/images/rojo1.png' title='Informe rechazado y pendiente de revisar'/>"
      elsif interventoria.estado.to_s == 'APROBADO'
         return "<img src='/images/verde1.png' title='Informe Aprobado por interventor y en validación de SGSST'/>"
      elsif interventoria.estado.to_s == 'APROBADOGH'
         return "<img src='/images/asistente.png' title='Informe Aprobado por interventor y por el SGSST'/>"
      elsif interventoria.estado.to_s == 'RECHAZADOGH'
         return "<img src='/images/rojo1.png' title='Informe rechazado por el SGSST y pendiente de revisar'/>"
      elsif interventoria.estado.to_s == 'APROBADOCONT'
         return "<img src='/images/connect.png' title='Informe Contabilizado'/>"
      elsif interventoria.estado.to_s == 'RECHAZADOCONT'
         return "<img src='/images/rojo1.png' title='Informe rechazado por Contabilidad y pendiente de revisar'/>"
      end
    else
      return "<img src='/images/nogenerado.png' title='Periodo no generado'/>"
    end
  end

  def existeinterventoriainforme(anno, mes)
    if Interventoria.exists?(["contrato_id = #{self.id} and anno = '#{anno}' and mes = #{mes}"]) == true
      interventoria = Interventoria.find_by_contrato_id_and_anno_and_mes(self.id,anno,mes)
      return interventoria.estado.to_s
    end
  end

  def nombreinterventor
    return Empleado.find(self.interventorempleado_id).autobuscar rescue nil
  end

  def nombresinterventor
    return Empleado.find(self.interventorempleado_id).nombres rescue nil
  end

  def cargointerventor
    return Empleado.find(self.interventorempleado_id).cargo rescue nil
  end

  def valor_pagadointer
    valor = Interventoria.sum("to_number(valor_mes)", :conditions=>["contrato_id = #{self.id} and total is not null"])
    return valor
  end

  def valor_saldo
    saldo = (self.valorreal.to_i - self.valor_pagadointer.to_i)
    return saldo
  end

  def porcentaje_eje
    porcentaje = ((self.valor_pagadointer.to_i * 100)/self.valorreal.to_i)
    return porcentaje
  end

  def adiciones
    valor = self.contratosmodificaciones.sum('valor')
    return valor
  end

  def after_save
    if self.id
      ActiveRecord::Base.connection.execute("begin prc_check; end;")
    end
  end 
end

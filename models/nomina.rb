class Nomina < ActiveRecord::Base
  belongs_to :empleado
  belongs_to :periodosliquidacion

  def self.proceso (periodosliquidacion_id)
    @dn = Sifi.find(16).valor.to_i
    nominas = Nomina.find_all_by_periodosliquidacion_id(periodosliquidacion_id)
    nominas.each do |data|
      data.destroy
    end
    periodosliquidacion = Periodosliquidacion.find(periodosliquidacion_id)
    empleados = Empleado.find_all_by_tipo('V')
    empleados.each do |emp|
      #contratosvinculados = Contratosvinculado.find_all_by_empleado_id(emp.id)
      if Contratosvinculado.exists?(['empleado_id = ?',emp.id])
        contratosvinculados = Contratosvinculado.find(:all, :conditions => ['empleado_id = ? and (fecha_final is null or fecha_final between ? and ?)',emp.id, periodosliquidacion.fecha_inicial, periodosliquidacion.fecha_final])
        contratosvinculados.each do |con|
          u = Nomina.new
          calculodias    = 0
          valornovedad   = 0
          calculodiaslab = 0
          segundos = 0
          minutos  = 0
          horas    = 0
          valdiasalario = 0
          if (con.fecha_inicio > periodosliquidacion.fecha_inicial) and (con.fecha_inicio < periodosliquidacion.fecha_final)
            segundos = (periodosliquidacion.fecha_final - con.fecha_inicio).to_i
            minutos  = (segundos/60).to_i #es el nÃºmero total de minutos
            horas    = (minutos/60).to_i #nÃºmero total de horas
            calculodiaslab     = (horas/24).to_i # nÃºmero total de dÃ­as
            calculodiaslab = calculodiaslab + 1
          elsif con.fecha_final.to_s != ""
            if (con.fecha_final > periodosliquidacion.fecha_inicial) and (con.fecha_final < periodosliquidacion.fecha_final)
              segundos = (con.fecha_final - periodosliquidacion.fecha_inicial).to_i
              minutos  = (segundos/60).to_i #es el nÃºmero total de minutos
              horas    = (minutos/60).to_i #nÃºmero total de horas
              calculodiaslab = (horas/24).to_i # nÃºmero total de dÃ­as
              calculodiaslab = calculodiaslab + 1
            end
          else
            calculodiaslab = @dn
          end
          valdiasalario = (con.salario.to_f / 30).round
          valorincapacidad = 0
          valornovedadDev = 0
          valornovedadDevVac = 0
          nominasnovedades = Nominasnovedad.find_all_by_empleado_id(emp.id)
          nominasnovedades.each do |nov|
            if nov.fecha_novedad >= periodosliquidacion.fecha_inicial and nov.fecha_novedad <= periodosliquidacion.fecha_final
              if nov.tipo_novedad == "1" #Deduccion
                if (nov.dias.to_s != "")
                  calculodias = calculodiaslab - nov.dias
                  calculodiaslab = calculodias
                elsif (nov.valor.to_s != "")
                  valornovedad = valornovedad + nov.valor
                end
              elsif (nov.tipo_novedad == "2") #Incapacidad
                if (nov.dias.to_s != "" and nov.porcentaje.to_s != "")
                  if nov.dias.to_s == @dn.to_s
                    calculodias = @dn
                  else
                    calculodias = calculodiaslab - nov.dias
                  end
                  valorincapacidad = valorincapacidad + ((valdiasalario.round * nov.dias) * nov.porcentaje.to_f)/100
                  #(((valdiasalario * nov.dias) * nov.porcentaje.to_f) / 100).to_f
                end
              elsif (nov.tipo_novedad == "3") #Devengo
                if (nov.valor.to_s != "")
                  valornovedadDev = valornovedadDev + nov.valor;
                end
              elsif (nov.tipo_novedad == "4") #Vacaciones.
                if (nov.valor.to_s != "")
                  valornovedadDev = valornovedadDev + nov.valor;
                end
              elsif (nov.tipo_novedad == "5" or nov.tipo_novedad == "6") #VacacionesAdicional
                if (nov.valor.to_s != "")
                  valornovedadDevVac = valornovedadDevVac + nov.valor;
                end
              elsif (nov.tipo_novedad == "7") #Prima de Navidad
                if (nov.valor.to_s != "")
                  valornovedadDevVac = valornovedadDevVac + nov.valor;
                end
              elsif (nov.tipo_novedad == "9") #Prima de Servicios
                if (nov.valor.to_s != "")
                  valornovedadDevVac = valornovedadDevVac + nov.valor;
                end
              elsif (nov.tipo_novedad == "8") #Prima de Navidad
                if (nov.valor.to_s != "")
                  valornovedadDevVac = valornovedadDevVac + nov.valor;
                end
              end
            end
          end
          existeretefuente = Contratosretefuente.exists?(["empleado_id= ? and periodosliquidacion_id = ?", emp.id, periodosliquidacion.id])
          if existeretefuente
            contratosretefuente = Contratosretefuente.find_by_empleado_id_and_periodosliquidacion_id(emp.id, periodosliquidacion.id)
            if contratosretefuente.valor_retencion.to_s != ""
              u.retefuente = contratosretefuente.valor_retencion
            else
              u.retefuente = 0
            end
          else
            u.retefuente = 0
          end
          u.empleado_id = emp.id
          u.periodosliquidacion_id = periodosliquidacion.id
          u.salario = con.salario
          if calculodias == 0
            u.dias = calculodiaslab
            u.subtotal = valdiasalario.to_f * calculodiaslab
          elsif calculodias == @dn
            u.dias = calculodias
            u.subtotal = 0
          else
            u.dias = calculodias
            u.subtotal = valdiasalario.to_f * calculodias
          end
#          u.salud    = (((valdiasalario * calculodiaslab) * 4)/100)
#          u.pension  = (((valdiasalario * calculodiaslab) * 4)/100)
          u.salud    = ((((valdiasalario * calculodiaslab) + valornovedadDev) * 4)/100)
          u.pension  = ((((valdiasalario * calculodiaslab) + valornovedadDev) * 4)/100)
          if (con.salario >= 10013000)
           u.solidaridad = ((((valdiasalario * calculodiaslab) + valornovedadDev) * 1.4)/100)
          elsif (con.salario >= 2577400)
            u.solidaridad = ((((valdiasalario * calculodiaslab) + valornovedadDev) * 1)/100)
          else
            u.solidaridad = 0
          end
          u.novedades = valornovedad
          u.total_deducciones = (u.novedades + u.retefuente + u.solidaridad + u.pension + u.salud)
          u.total = u.subtotal - u.total_deducciones + valorincapacidad + valornovedadDev + valornovedadDevVac
          u.total_incapacidad = valorincapacidad
          u.otros_devengados  = valornovedadDev + valornovedadDevVac
          u.save
        end
      end
    end
  end

  def self.comprobante(periodosliquidacion)
    #periodosliquidacion = Periodosliquidacion.find(periodosliquidacion)
    nominas = Nomina.find_all_by_periodosliquidacion_id(periodosliquidacion)
    nominas.each do |x|
      if Contratosvinculado.exists?(['empleado_id = ? and fecha_final is null', x.empleado_id])
        periodosliquidacion = Periodosliquidacion.find(periodosliquidacion)
        @nominasnovedades = Nominasnovedad.find(:all, :conditions => ["empleado_id = #{x.empleado_id} and fecha_novedad between '#{periodosliquidacion.fecha_inicial.to_date}' and '#{periodosliquidacion.fecha_final.to_date}'"])
        infonomina =  'SIFI - Comprobante de Nomina periodo '+ x.periodosliquidacion.fecha_inicial.to_s+' y '+x.periodosliquidacion.fecha_final.to_s
        @empleado = Empleado.find(x.empleado_id)
        if @empleado.email.to_s != ""
          Notifier.deliver_nomina_message(x, @empleado, infonomina,@nominasnovedades)
        end
      end
    end
  end

  def self.comprobantepersona(periodosliquidacion, idempleado)
    periodosliquidacion = Periodosliquidacion.find(periodosliquidacion)
    nomina = Nomina.find_by_empleado_id_and_periodosliquidacion_id(idempleado, periodosliquidacion)
    @nominasnovedades = Nominasnovedad.find(:all, :conditions => ["empleado_id = #{nomina.empleado_id} and fecha_novedad between '#{periodosliquidacion.fecha_inicial.to_date}' and '#{periodosliquidacion.fecha_final.to_date}'"])
    infonomina =  'SIFI - Comprobante de Nomina periodo '+ periodosliquidacion.fecha_inicial.to_s+' y '+ periodosliquidacion.fecha_final.to_s
    @empleado = Empleado.find(idempleado)
    if @empleado.email != ""
      Notifier.deliver_nomina_message(nomina, @empleado, infonomina,@nominasnovedades)
    end
  end

  def nombreperiodo
    return self.periodosliquidacion.nombreperiodo
  end

  def nominassubtotal
    
  end

end

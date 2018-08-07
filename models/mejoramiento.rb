class Mejoramiento < ActiveRecord::Base
  belongs_to :user
  belongs_to :persona
  belongs_to :mejoramientosestado
  belongs_to :convenio
  belongs_to :resolucion
  belongs_to :comuna
  has_many :mejoramientosinterventorias, :dependent =>:destroy
  has_many :mejoramientoselementos, :dependent =>:destroy
  has_many :mejoramientosimagenes, :dependent =>:destroy
  has_many :mejoramientosconceptos, :dependent =>:destroy
  has_many :mejoramientosnotas, :dependent =>:destroy
  has_many :mejoramientospagos, :dependent =>:destroy
  has_many :mejoramientosobras, :dependent =>:destroy
  has_many :mejoramientoslistas, :dependent =>:destroy
  has_many :conveniosresolmejoramientos
  has_many :mejorainformeslistas

  validates_presence_of :persona_autobuscar
  validate_on_update :mejora

  def permisomej(objeto, evento,userid) #Evento debe ser A:Actualiza, E:Elimina, C:Crea
    objetoid = Objeto.find_by_descripcion(objeto)
    if objetoid.to_s != ""
     userspermisos = Userspermiso.find(:all, :conditions =>['user_id = ? and objeto_id = ?', userid, objetoid])
     userspermisos.each do |data|
       if evento == "A"
         return data.actualiza
       elsif evento == "E"
         return data.elimina
       elsif evento == "C"
         return data.crea
       end
     end
    end
  end

  def mejora
    @mejoramiento = Mejoramiento.find(self.id)
    if @mejoramiento.mejoramientosestado_id > self.mejoramientosestado_id
      if permisomej("mejoramientosespecial","A",self.user_actualiza).to_s == "S"
        @mejoramientosnota = Mejoramientosnota.new
        @mejoramientosnota.tipo_atencion='4'
        @mejoramientosnota.user_id = self.user_actualiza
        @mejoramientosnota.mejoramiento_id = self.id
        @mejoramientosnota.observacion ="SE REGISTRA CAMBIO DE ESTADO DE " + @mejoramiento.mejoramientosestado.descripcion.to_s + " A "+ self.mejoramientosestado.descripcion.to_s
        @mejoramientosnota.save
      else
        errors.add :mejoramientosestado_id, "* El Estado no puede ser anterior al actual."
      end
    elsif @mejoramiento.mejoramientosestado_id < self.mejoramientosestado_id
      @mejoramientosnota = Mejoramientosnota.new
      @mejoramientosnota.tipo_atencion='4'
      @mejoramientosnota.user_id = self.user_actualiza
      @mejoramientosnota.mejoramiento_id = self.id
      @mejoramientosnota.observacion ="SE REGISTRA CAMBIO DE ESTADO DE " + @mejoramiento.mejoramientosestado.descripcion.to_s + " A "+ self.mejoramientosestado.descripcion.to_s
      @mejoramientosnota.save
    end
  end

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def self.search (convenio,conveniosresolucion,identificacion,usercoordinador,userprofesional,usertecnologo,userinterventor,mejoramientosestadoid,page,perpage)
    cadena = ""
    if convenio != ""
      if cadena != ""
        cadena = cadena + ' and convenio_id = ' + "#{convenio.to_i}"
      else
        cadena = ' convenio_id = ' + "#{convenio.to_i}"
      end
    end
    if conveniosresolucion != ""
      if cadena != ""
        cadena = cadena + ' and resolucion_id = (select resolucion_id from conveniosresoluciones where id = ' + "#{conveniosresolucion.to_i}"+")"
      else
        cadena = ' resolucion_id = (select resolucion_id from conveniosresoluciones where id = ' + "#{conveniosresolucion.to_i}"+")"
      end
    end
    if identificacion != ""
      if cadena != ""
        cadena = cadena + ' and persona_id in (select id from personas where identificacion = '+ "'#{identificacion.strip}'" +')'
      else
        cadena = cadena + ' persona_id in (select id from personas where identificacion = '+ "'#{identificacion.strip}'" +')'
      end
    end
    if usercoordinador != ""
      if cadena != ""
        cadena = cadena + ' and user_coordinador = ' + "#{usercoordinador.to_i}"
      else
        cadena = ' user_coordinador = ' + "#{usercoordinador.to_i}"
      end
    end
    if userprofesional != ""
      if cadena != ""
        cadena = cadena + ' and user_profesional = ' + "#{userprofesional.to_i}"
      else
        cadena = ' user_profesional = ' + "#{userprofesional.to_i}"
      end
    end
    if usertecnologo != ""
      if cadena != ""
        cadena = cadena + ' and user_tecnologo = ' + "#{usertecnologo.to_i}"
      else
        cadena = ' user_tecnologo = ' + "#{usertecnologo.to_i}"
      end
    end
    if userinterventor != ""
      if cadena != ""
        cadena = cadena + ' and user_interventor = ' + "#{userinterventor.to_i}"
      else
        cadena = ' user_interventor = ' + "#{userinterventor.to_i}"
      end
    end
    if mejoramientosestadoid != ""
      if cadena != ""
        cadena = cadena + ' and mejoramientosestado_id = ' + "#{mejoramientosestadoid.to_i}"
      else
        cadena = ' mejoramientosestado_id = ' + "#{mejoramientosestadoid.to_i}"
      end
    end
    if cadena != ""
      paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "created_at"
    else
      paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at"
    end
  end

  def self.search99 (convenio,conveniosresolucion)
    cadena = ""
    if convenio != ""
      if cadena != ""
        cadena = cadena + ' and convenio_id = ' + "#{convenio.to_i}"
      else
        cadena = ' convenio_id = ' + "#{convenio.to_i}"
      end
    end
    if conveniosresolucion != ""
      if cadena != ""
        cadena = cadena + ' and resolucion_id = (select resolucion_id from conveniosresoluciones where id = ' + "#{conveniosresolucion.to_i}"+")"
      else
        cadena = ' resolucion_id = (select resolucion_id from conveniosresoluciones where id = ' + "#{conveniosresolucion.to_i}"+")"
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end

  def valoradmin
    #logger.error("calculo .." + self.calculo.to_s)
    if self.calculo.to_s == "SUBSIDIO"
      @valoradmin1 = (self.valor_resolucion.to_i * 0.13).round
    elsif self.calculo.to_s == "SUBSIDIO-DIAGNOSTICO"
      @valoradmin1 = ((self.valor_resolucion.to_i - self.valordiag.to_i) * 0.13).round
    elsif self.calculo.to_s == "EJECUCION"
      @valoradmin1 = (self.vlrejecutado.to_f * 0.13).round
    elsif self.calculo.to_s == "SIN ADMINISTRACION"
      @valoradmin1 = 0
    elsif self.calculo.to_s == "EJECUCION 2015"
      if self.convenio_id.to_s == '264' or self.convenio_id.to_s == '302'
        @valornormal = Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id not in (10043,2)"]).to_i
        @valornormal = @valornormal.to_i + self.valortransporte.to_i + self.valortransporteadd.to_i
        @valoradmin1 = (@valornormal.to_i*0.13).round
      else
        @valornormal = Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id not in (10043,2)"]).to_i
        @valoradmin1 = (@valornormal.to_i*0.13).round
      end
    else
      @valornormal = Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id !=  10043"]).to_i
      @valoradmin1 = (@valornormal.to_i*0.13).round
    end
#    logger.error("Valoress...."+@valornormal.to_s)
#    logger.error("Valoress...."+@valoradmin1.to_s)
    return @valoradmin1
  end

  def valoradmineje
    #logger.error("calculo .." + self.calculo.to_s)
    if self.calculo.to_s == "SUBSIDIO"
      @valoradmin1 = (self.valor_resolucion.to_i * 0.13).round
    elsif self.calculo.to_s == "SUBSIDIO-DIAGNOSTICO"
      @valoradmin1 = ((self.valor_resolucion.to_i - self.valordiag.to_i) * 0.13).round
    elsif self.calculo.to_s == "EJECUCION"
      @valoradmin1 = (self.vlrejecutado.to_f * 0.13).round
    elsif self.calculo.to_s == "SIN ADMINISTRACION"
      @valoradmin1 = 0
    elsif self.calculo.to_s == "EJECUCION 2015"
      if self.convenio_id.to_s == '264' or self.convenio_id.to_s == '302' or self.convenio_id.to_s == '265' or self.convenio_id.to_s == '444'
        vlr1 = self.vlracum.to_i + self.valortransporte_eje.to_i + self.valortransporteadd_eje.to_i
        @valoradmin1 = (vlr1.to_i*0.13).round
      elsif self.valortransporte_eje > 0 or self.valortransporteadd_eje > 0 then
        #2016-09-21 Se adicionan los valores de transporte
        vlr1 = self.vlracum.to_i + self.valortransporte_eje.to_i + self.valortransporteadd_eje.to_i
        @valoradmin1 = (vlr1.to_i*0.13).round
      else
        @valoradmin1 = (self.vlracum.to_i*0.13).round
      end
    else
      @valoradmin1 = (self.vlracum.to_i*0.13).round
      #@valornormal = Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id !=  10043"]).to_i
      @valoradmin1 = (@valornormal.to_i*0.13).round
    end
    #logger.error("Valoress...."+@valoradmin1.to_s)
    return @valoradmin1
  end

  def valor10ejecucion
    #logger.error("calculo .." + self.calculo.to_s)
    if self.especial.to_s == 'SI'
      @valorejec = (self.vlracum.to_f * 0.10).to_i rescue 0
      return @valorejec
    else
      return 0
    end
  end

  def valordiag
    if self.incluye_diagnostico.to_s == 'SI'
      return Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id =  10043"]).to_i  rescue 0
    else
      return 0
    end
  end

  def vlrtotal
    if self.calculo.to_s == "EJECUCION 2015"
      @valornormal = Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id not in (10043,2)"]).to_i  rescue 0
    else
      @valornormal = Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id !=  10043"]).to_i  rescue 0
    end
    if self.calculo.to_s == "SIN ADMINISTRACION"
      @tot = @valornormal + self.valoradmin + self.valordiag + 530550.to_i + 800000.to_i
    elsif self.calculo.to_s == "EJECUCION 2015"
      @tot = @valornormal + self.valoradmin + self.valordiag + self.valortransporte.to_i + self.valortransporteadd.to_i + self.valor4pormil.to_i
    else
      @tot = @valornormal + self.valoradmin + self.valordiag + self.valortransporte.to_i + self.valortransporteadd.to_i
    end
    return @tot
  end

  def vlrtotaleje
    if self.calculo.to_s == "EJECUCION 2015"
#      logger.error("vlracum------"+self.vlracum.to_s);
#      logger.error("valordiag------"+self.valordiag.to_s);
#      logger.error("valoradmineje------"+self.valoradmineje.to_s);
#      logger.error("valor10ejecucion------"+self.valor10ejecucion.to_s);
#      logger.error("valortransporte_eje------"+self.valortransporte_eje.to_s);
#      logger.error("valortransporteadd_eje------"+self.valortransporteadd_eje.to_s);
#      logger.error("valor4pormileje------"+self.valor4pormileje.to_s);
      return self.vlracum + self.valordiag + self.valoradmineje + self.valor10ejecucion + self.valortransporte_eje.to_i + self.valortransporteadd_eje.to_i + self.valor4pormileje.to_i
    else
      return self.vlracum + self.valordiag + self.valoradmineje + self.valor10ejecucion + self.valortransporte_eje.to_i + self.valortransporteadd_eje.to_i
    end
  end
  
  def porcentajeeje
    if self.calculo.to_s == "EJECUCION 2015"
#      logger.error("------------------------");
#      logger.error("a----vlrtotaleje------"+self.vlrtotaleje.to_s);
#      logger.error("a----valor4pormileje------"+self.valor4pormileje.to_s);
#      logger.error("a----valor_resolucion------"+self.valor_resolucion.to_s);
      return ( (self.vlrtotaleje.to_i * 100 )/self.valor_resolucion).floor
    else
      return ((self.vlrtotaleje * 100 )/self.valor_resolucion).floor
    end
  end

  def vlracum
    if self.calculo.to_s == "EJECUCION 2015"
      @vlr = 0.0
      @vlr = Mejorainformeselemento.sum('trunc(valor_total)',:conditions => ["mejoramientoselemento_id in (select id from mejoramientoselementos where mejoramiento_id = #{self.id} and mejoramientositem_id not in (10043,2))"]).to_f
      return @vlr.to_f
    else
      @vlr = 0.0
      @vlr = Mejorainformeselemento.sum('trunc(valor_total)',:conditions => ["mejoramientoselemento_id in (select id from mejoramientoselementos where mejoramiento_id = #{self.id} and mejoramientositem_id !=  10043)"]).to_f
      return @vlr.to_f
    end
  end

  def vlrejecutado
    if self.calculo.to_s == "EJECUCION 2015"
      @vlr = 0.0
      @vlr = Mejorainformeselemento.sum('trunc(valor_total)',:conditions => ["mejoramientoselemento_id in (select id from mejoramientoselementos
                                                                                                           where mejoramiento_id = #{self.id} and mejoramientositem_id not in (10043,2))"]).to_f rescue 0
      return @vlr.to_f
    else
      @vlr = 0.0
      @vlr = Mejorainformeselemento.sum('trunc(valor_total)',:conditions => ["mejoramientoselemento_id in (select id from mejoramientoselementos
                                                                                                           where mejoramiento_id = #{self.id} and mejoramientositem_id !=  10043)"]).to_f rescue 0
      return @vlr.to_f
    end
  end

  def vlrejecutadoporc
    return ((self.vlrejecutado * 100 )/self.valor_resolucion)
  end

  def pendientecierre
    vlr = (self.valor_resolucion - self.vlrtotaleje) rescue 0
    if vlr == -1
      return 0
    else
      return vlr
    end
  end

  def vlrejecutadoextra
    @vlr = 0.0
    @vlr = Mejorainformeselemento.sum('trunc(valor_total)',:conditions => ["mejoramientoselemento_id in (select id from mejoramientoselementos where mejoramiento_id = #{self.id}"])
    return @vlr.to_f
  end

  def vlrejecutadoextraporc
    return ((self.vlrejecutadoextra* 100 )/self.valor_resolucion)
  end

  def vlrnormal
    #Creado 2015-08-03
    if self.calculo.to_s == "EJECUCION 2015"
      return Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id not in (10043,2)"]).to_i
    else
      return Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id not in (10043)"]).to_i
    end
  end

  def valortransporte
    #Creado 2015-08-03
    if self.incremento_corregimiento.to_s == 'SI' and self.calculo.to_s == "EJECUCION 2015"
      return (self.vlrnormal * 3)/100 rescue 0
    else
      return 0
    end
  end

  def valortransporteadd
    #Creado 2015-08-03
    if self.incremento_adicional.to_s == 'SI' and self.calculo.to_s == "EJECUCION 2015"
      return (self.valortransporte * 50)/100 rescue 0
    else
      return 0
    end
  end

  def valortransporte_eje
    #Creado 2015-08-03
    if self.incremento_corregimiento.to_s == 'SI' and self.calculo.to_s == "EJECUCION 2015"
      return (self.vlracum * 3)/100 rescue 0
    else
      return 0
    end
  end

  def valortransporteadd_eje
    #Creado 2015-08-03
    if self.incremento_adicional.to_s == 'SI' and self.calculo.to_s == "EJECUCION 2015"
      return (self.valortransporte_eje * 50)/100 rescue 0
    else
      return 0
    end
  end

  def valor4pormil
    if self.calculo.to_s == "EJECUCION 2015"
      vlr = self.vlrnormal.to_i + self.valortransporte.to_i + self.valortransporteadd.to_i
      return ((vlr * 4)/1000).to_i rescue 0
    else
      return Mejoramientoselemento.sum("trunc(valor_total)", :conditions=>["mejoramiento_id = #{self.id} and mejoramientositem_id = 2"]).to_i
    end
  end

  def valor4pormileje
    if self.calculo.to_s == "EJECUCION 2015"
      vlr = self.vlracum.to_i + self.valortransporte_eje.to_i + self.valortransporteadd_eje.to_i
      return (vlr * 4)/1000 rescue 0
    elsif self.calculo.to_s == "SUBSIDIO-DIAGNOSTICO"
      return 0
    else
      return Mejorainformeselemento.sum('trunc(valor_total)',:conditions => ["mejoramientoselemento_id in (select id from mejoramientoselementos where mejoramiento_id = #{self.id} and mejoramientositem_id = 2)"]).to_f
    end
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
  
end

class Correspondenciasrecibida < ActiveRecord::Base
  belongs_to :persona
  belongs_to :benevivienda
  belongs_to :user
  belongs_to :correspondenciasremitente
  belongs_to :correspondenciasclase
  belongs_to :dependencia
  has_many :correspondenciasrecibidas
  has_many :correspondenciasdependencias, :dependent =>:destroy
  has_many :corresrecibidasimagenes, :dependent =>:destroy
  has_many :correspondenciasasignadas, :dependent =>:destroy
  has_many :correspondenciasrecibidasusers, :dependent =>:destroy
  has_many :quejas
  #belongs_to :queja
  
  #validates_presence_of :fecha_elaboracion, :asunto, :dependencia_id, :correspondenciasclase_id
  validates_presence_of :fecha_elaboracion, :asunto
  #validates_presence_of :persona_autobuscar, :if => :in_us?
  #validates_presence_of :correspondenciasremitente_id, :if => :in_us2?
  #validates_uniqueness_of :nro_radicado, :scope => :anno
  validates_numericality_of :nro_radicado
  #validates_presence_of :respuestaobs, :if => :in_us33?

  def in_us33?
    self.respuesta.to_s  == "SI"
  end

  def before_save
    dias = Correspondenciasclase.find(self.correspondenciasclase_id).dias rescue nil
    begin
      festivos = Festivo.find_by_sql("select fnc_dias(to_date('#{self.fecha_recibido}','dd/mm/yyyy'),#{dias}) fch from dual")
      festivos.each do |festivo|
        self.fecha_limite = festivo.fch
      end
    rescue
      self.fecha_limite = ""
    end
  end

  def self.search (nroradicado, identificacion, identificacionb, correspondenciasremitenteid, fchelainicial, fchelafinal, fchrecinicial, fchrecfinal, dependenciaid, correspondenciasclase_id, asunto, observacion, nro_externo, empresa, empresar, recibidoemail, clase, page)
    cadena = ""
    if nroradicado.to_s != ""
      if cadena != ""
        cadena = cadena + ' and nro_radicado = '+ "'#{nroradicado.strip}'"
      else
        cadena = cadena + ' nro_radicado = '+ "'#{nroradicado.strip}'"
      end
    end
    if nro_externo.to_s != ""
      if cadena != ""
        cadena = cadena + ' and numero_externo = '+ "'#{nro_externo.strip}'"
      else
        cadena = cadena + ' numero_externo = '+ "'#{nro_externo.strip}'"
      end
    end
    if identificacion.to_s != ""
      if cadena != ""
        cadena = cadena + ' and persona_id in (select id from personas where identificacion = '+ "'#{identificacion.strip}'" +')'
      else
        cadena = cadena + ' persona_id in (select id from personas where identificacion = '+ "'#{identificacion.strip}'" +')'
      end
    end
    if identificacionb.to_s != ""
      if cadena != ""
        cadena = cadena + ' and benevivienda_id in (select id from beneviviendas where identificacion is not null and identificacion = '+ "'#{identificacionb.strip}'" +')'
      else
        cadena = cadena + ' benevivienda_id in (select id from beneviviendas where identificacion is not null and identificacion = '+ "'#{identificacionb.strip}'" +')'
      end
    end
    if correspondenciasremitenteid.to_s != ""
      if cadena != ""
        cadena = cadena + ' and correspondenciasremitente_id = '+ "'#{correspondenciasremitenteid}'"
      else
        cadena = cadena + ' correspondenciasremitente_id = '+ "'#{correspondenciasremitenteid}'"
      end
    end
    if fchelainicial.to_s != "" and fchelafinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and fecha_elaboracion between ' + "'#{fchelainicial}'" + ' and ' + "'#{fchelafinal}'"
      else
        cadena = cadena + ' fecha_elaboracion between ' + "'#{fchelainicial}'" + ' and ' + "'#{fchelafinal}'"
      end
    end
    if fchrecinicial.to_s != "" and fchrecfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and trunc(created_at) between ' + "'#{fchrecinicial}'" + ' and ' + "'#{fchrecfinal}'"
      else
        cadena = cadena + ' trunc(created_at) between ' + "'#{fchrecinicial}'" + ' and ' + "'#{fchrecfinal}'"
      end
    end
    if dependenciaid.to_s != ""
      if cadena != ""
        cadena = cadena + ' and dependencia_id = '+ "'#{dependenciaid}'"
      else
        cadena = cadena + ' dependencia_id = '+ "'#{dependenciaid}'"
      end
    end
    if correspondenciasclase_id.to_s != ""
      if cadena != ""
        cadena = cadena + ' and correspondenciasclase_id = '+ "'#{correspondenciasclase_id}'"
      else
        cadena = cadena + ' correspondenciasclase_id = '+ "'#{correspondenciasclase_id}'"
      end
    end
    if asunto.to_s != ""
      s = asunto.upcase
      if cadena != ""
        cadena = cadena + ' and upper(asunto) like '+ "'%%#{s.to_s.strip}%%'"
      else
        cadena = ' upper(asunto) like '+ "'%%#{s.to_s.strip}%%'"
      end
    end
    if observacion.to_s != ""
      s = observacion.upcase
      if cadena != ""
        cadena = cadena + ' and upper(observacion) like '+ "'%%#{s.to_s.strip}%%'"
      else
        cadena = ' upper(observacion) like '+ "'%%#{s.to_s.strip}%%'"
      end
    end
    if empresa.to_s != ""
      s = empresa.upcase
      if cadena != ""
        cadena = cadena + ' and correspondenciasremitente_id in (select id from correspondenciasremitentes where entidad like '+ "'%%#{s.to_s.strip}%%'"+')'
      else
        cadena = cadena + ' correspondenciasremitente_id in (select id from correspondenciasremitentes where entidad like '+ "'%%#{s.to_s.strip}%%'"+')'
      end
    end
    if empresar.to_s != ""
      s = empresar.upcase
      if cadena != ""
        cadena = cadena + ' and correspondenciasremitente_id in (select id from correspondenciasremitentes where nombre like '+ "'%%#{s.to_s.strip}%%'"+')'
      else
        cadena = cadena + ' correspondenciasremitente_id in (select id from correspondenciasremitentes where nombre like '+ "'%%#{s.to_s.strip}%%'"+')'
      end
    end
    if recibidoemail.to_s != ""
      if cadena != ""
        cadena = cadena + ' and recibidoemail = '+ "'#{recibidoemail}'"
      else
        cadena = cadena + ' recibidoemail = '+ "'#{recibidoemail}'"
      end
    end
    if clase.to_s != ""
      if cadena != ""
        cadena = cadena + ' and clase = '+ "'#{clase.strip}'"
      else
        cadena = cadena + ' clase = '+ "'#{clase.strip}'"
      end
    end
    if cadena != ""
      #find(:all, :conditions => [cadena], :order => "to_number(nro_radicado), created_at desc")
      paginate :per_page => 10, :page => page, :conditions => [cadena], :order=>'to_number(nro_radicado), created_at desc'
    else
      paginate :per_page => 10, :page => page, :conditions => ["id = '-1'"]
    end 
  end

  def self.searchconsolidado (identificacion, correspondenciasremitenteid, fchelainicial, fchelafinal, fchrecinicial, fchrecfinal, dependenciaid, correspondenciasclase_id,entregafchelainicial,entregafchelafinal,userentregado_id,userasignado_id, asunto, recibidoemail)
      cadena = ""
      if identificacion != ""
        if cadena != ""
          cadena = cadena + ' and persona_id in (select id from personas where identificacion = '+ "'#{identificacion}'" +')'
        else
          cadena = cadena + ' persona_id in (select id from personas where identificacion = '+ "'#{identificacion}'" +')'
        end
      end
      if correspondenciasremitenteid.to_s != ""
        if cadena != ""
          cadena = cadena + ' and correspondenciasremitente_id = '+ "'#{correspondenciasremitenteid}'"
        else
          cadena = cadena + ' correspondenciasremitente_id = '+ "'#{correspondenciasremitenteid}'"
        end
      end
      if fchelainicial.to_s != "" and fchelafinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and fecha_elaboracion between ' + "'#{fchelainicial}'" + ' and ' + "'#{fchelafinal}'"
        else
          cadena = cadena + ' fecha_elaboracion between ' + "'#{fchelainicial}'" + ' and ' + "'#{fchelafinal}'"
        end
      end
      if fchrecinicial.to_s != "" and fchrecfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and fecha_recibido between ' + "'#{fchrecinicial}'" + ' and ' + "'#{fchrecfinal}'"
        else
          cadena = cadena + ' fecha_recibido between ' + "'#{fchrecinicial}'" + ' and ' + "'#{fchrecfinal}'"
        end
      end
      if dependenciaid.to_s != ""
        if cadena != ""
          cadena = cadena + ' and dependencia_id = '+ "'#{dependenciaid}'"
        else
          cadena = cadena + ' dependencia_id = '+ "'#{dependenciaid}'"
        end
      end
      if correspondenciasclase_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and correspondenciasclase_id = '+ "'#{correspondenciasclase_id}'"
        else
          cadena = cadena + ' correspondenciasclase_id = '+ "'#{correspondenciasclase_id}'"
        end
      end
      if entregafchelainicial.to_s != "" and entregafchelafinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and fecha_recibida between ' + "'#{entregafchelainicial}'" + ' and ' + "'#{entregafchelafinal}'"
        else
          cadena = cadena + ' fecha_recibida between ' + "'#{entregafchelainicial}'" + ' and ' + "'#{entregafchelafinal}'"
        end
      end
      if userentregado_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and userrecibida_id = '+ "'#{userentregado_id}'"
        else
          cadena = cadena + ' userrecibida_id = '+ "'#{userentregado_id}'"
        end
      end
      if userasignado_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id in (select correspondenciasrecibida_id from correspondenciasrecibidasusers where user_id = '+ "'#{userasignado_id}'" +')'
        else
          cadena = cadena + ' id in (select correspondenciasrecibida_id from correspondenciasrecibidasusers where user_id = '+ "'#{userasignado_id}'" +')'
        end
      end
      if asunto.to_s != ""
        s = asunto.upcase
        if cadena != ""
          cadena = cadena + ' and upper(asunto) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(asunto) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if recibidoemail.to_s != ""
        if cadena != ""
          cadena = cadena + ' and recibidoemail = '+ "'#{recibidoemail}'"
        else
          cadena = cadena + ' recibidoemail = '+ "'#{recibidoemail}'"
        end
      end      
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "to_number(nro_radicado), created_at desc")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "to_number(nro_radicado), created_at desc")
      end
  end

  def self.searchpendiente (creainicial,creafinal,page,perpage)
    cadena = ""
    if creainicial.to_s != "" and creafinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and trunc(created_at) between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
      else
        cadena = cadena + ' trunc(created_at) between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
      end
    end
     if cadena != ""
      paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "created_at"
    else
      paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at"
    end
  end


  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def benevivienda_autobuscar
    benevivienda.autobuscar if benevivienda
  end

  def benevivienda_autobuscar=(autobuscar)
    self.benevivienda = Benevivienda.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def correspondenciasremitente_autobuscar
    correspondenciasremitente.autobuscar if correspondenciasremitente
  end

  def correspondenciasremitente_autobuscar=(autobuscar)
    self.correspondenciasremitente = Correspondenciasremitente.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def dclase
     if self.clase == "DP"
       return "DERECHO DE PETICION"
     elsif self.clase == "T"
       return "TUTELA"
     elsif self.clase == "Q"
       return "QUEJA"
     elsif self.clase == "RR"
       return "RECURSO REPOSICION"
     elsif self.clase == "AP"
       return "ACCION POPULAR"
     elsif self.clase == "O"
       return "OTROS"
     end
  end

  def bandejacorrespondencia
    last_id = Correspondenciasrecibida.last("id")
    ccorrespondenciasrecibida = Correspondenciasrecibida.find(last_id)
    @dependenciasusers = Dependenciasuser.find_all_by_dependencia_id(ccorrespondenciasrecibida.dependencia_id)
    @dependenciasusers.each do |dependenciasuser|
      correspondenciasasignada = Correspondenciasasignada.new
      correspondenciasasignada.correspondenciasrecibida_id = ccorrespondenciasrecibida.id
      correspondenciasasignada.user_id = dependenciasuser.user_id
      correspondenciasasignada.tipo_asignacion = '1'
      correspondenciasasignada.estado = 'A'
      #dias = Correspondenciasclase.find(ccorrespondenciasrecibida.correspondenciasclase_id).dias rescue nil
      #correspondenciasasignada.fecha_limite = fechaprogcorrespondencia(ccorrespondenciasrecibida.fecha_elaboracion, dias)
      correspondenciasasignada.save
    end
  end

##  def enviorecordaciones
##    @dependencias = Dependencia.all
##    @dependencias.each do |dependencia|
##      @correspondenciasrecibidas = Correspondenciasrecibida.find_by_sql(" select distinct r.correspondenciasclase_id,
#                                                                                 r.nro_radicado,
#                                                                                 r.asunto,
#                                                                                 r.created_at,
#                                                                                 r.fecha_limite,
#                                                                                 r.CORRESPONDENCIASREMITENTE_ID,
#                                                                                 r.persona_id,
#                                                                                 (select nombre from users where id in (select user_id from correspondenciasrecibidasusers where correspondenciasrecibida_id = r.id and rownum = 1)) usuarioasignado
#                                                                          from   correspondenciasasignadas c, correspondenciasrecibidas r
#                                                                          where  c.user_id in (select user_id from dependenciasusers where dependencia_id = #{dependencia.id})
#                                                                          and    c.correspondenciasrecibida_id = r.id
#                                                                          and    r.fecha_limite <= (trunc(sysdate)+4)
#                                                                          -- and    r.fecha_limite >= '01-01-2013'
#                                                                          and    r.id not in (select correspondenciasrecibida_id from correspondenciasradicados)
#                                                                          and    r.respuesta = 'NO'
#                                                                          order by r.correspondenciasclase_id#")
##      if @correspondenciasrecibidas.count > 0
##        @correos = dependencia.depcorreo rescue nil
##        begin
##          @correos = @correos.to_s + Sifi.find(23).valor.to_s
##          Notifier.deliver_correspondencia_message(@correos, @correspondenciasrecibidas, dependencia)
##          #logger.error("SIFI correspondencia_message - Correo enviado a #{@correos}")
##          rescue Exception => exc
##             logger.error("SIFI correspondencia_message - Correo No enviado a #{@correos}")
##        end
##      end
##    end
##  end
##
##  def enviocorrespondenciamasiva
##    @dependencias = Dependencia.all
##    @dependencias.each do |dependencia|
##      @correos = dependencia.depcorreo rescue nil
##      if @correos.to_s != ""
##        @correspondenciasrecibidas = Correspondenciasrecibida.find(:all, :conditions=>["dependencia_id = #{dependencia.id} and user_envio is null and trunc(created_at) >= '03-03-2015'"])
##        @correspondenciasrecibidas.each do |correspondenciasrecibida|
##          if correspondenciasrecibida.corresrecibidasimagenes.exists? == true
##            begin
##              Notifier.deliver_correspondenciasrecibida_message(correspondenciasrecibida, @correos)
##              ActiveRecord::Base.connection.execute("update correspondenciasrecibidas set fechaenvio = sysdate, user_envio = #{is_admin} where id = #{correspondenciasrecibida.id}")
##              sleep 8
##              rescue Exception => exc
##                logger.error("************* SIFI ERROR correspondenciasrecibida - Correo NO enviado a #{@correos}")
##            end
##          end
##        end
##        @correos = ""
##      end
##    end
##  end

  def c_diferenciadias
    fechasolicitud = self.fecha_limite
    if fechasolicitud.to_s != ""
      fechawork = fechasolicitud.to_time
      festivos = Festivo.find_by_sql("select trunc(sysdate) - to_date('#{fechasolicitud}','dd/mm/yyyy') resta from dual")
      dias = 0
      festivos.each do |festivo|
        dias = festivo.resta
      end
      cantidad = Festivo.count(:conditions =>['fecha between ? and trunc(sysdate)', fechawork])
      if cantidad > 0
        dias = dias - cantidad
      end
    end
    if dias
      return dias
    else
      return 0
    end
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end  
end
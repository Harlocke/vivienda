class ApplicationController < ActionController::Base
  #include Authentication
  helper :all
  helper_method :current_user_session, :current_user#, :require_user
  filter_parameter_logging :password, :password_confirmation
  before_filter :check_expire, :except => [:new]
  include ActionView::Helpers::NumberHelper

  
  def check_expire
    if session[:expire_time] and session[:expire_time] < Time.now
        #your code to logout the user
        current_user_session.destroy
        #flash[:notice] = "La sesión ha expirado por Inactividad. Debes iniciar sesión nuevamente"
        redirect_back_or_default new_user_session_url
    else
      session[:expire_time] = 60.minutes.since
      return true
    end
     rescue
      session[:expire_time] = 60.minutes.since
      return true
  end

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
      valor = current_user.id rescue nil
      if valor
        @usersmodulos = Usersmodulo.find_all_by_user_id(is_admin, :order => "modulo_id")
      else
        #flash[:notice] = "Usted debe iniciar sesión antes de Acceder al Sistema.{d}"
        redirect_to new_user_session_url
      end
    end

    def require_user
      if Rails.env.production?
        if current_user.id.to_s == "4"
          #flash[:notice] = "Usted debe iniciar sesión antes de Acceder al Sistema.{c}"
          redirect_back_or_default root_path
#        elsif User.find(current_user.id).activo == 'N'
#          current_user_session.destroy
#          redirect_to new_user_session_url
#          return false
        end
      end
      unless current_user
        store_location
        #flash[:notice] = "Usted debe iniciar sesión antes de Acceder al Sistema. {b}"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        #flash[:notice] = "Usted debe iniciar sesión antes de Acceder al Sistema.{a}"
        #redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    helper_method :is_admin
    def is_admin
      return current_user.id
   end

   helper_method :is_usuario
   def is_usuario
       return current_user.nombre
   end

   helper_method :is_username
   def is_username
       return current_user.username
   end
   
   helper_method :permiso
   def permiso(objeto, evento) #Evento debe ser A:Actualiza, E:Elimina, C:Crea
     objetoid = Objeto.find_by_descripcion(objeto)
     if objetoid.to_s != ""
       userspermisos = Userspermiso.find(:all, :conditions =>['user_id = ? and objeto_id = ?', is_admin, objetoid])
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

   helper_method :permisoespecial
   def permisoespecial(id) #Evento debe ser N:No, S:Si
     if Resolucionespersona.exists?(["persona_id = ?", id]) == false
       return 'S' #No esta
     else
       if Resolucion.exists?(["id in (select resolucion_id from resolucionespersonas where persona_id = ?) and modalidad != 'ARRENDAMIENTO'", id]) == false
         return 'S'
       else
         if permiso("subsidioespecial","A").to_s == "S"
           return 'S' #Permiso especial de modificaciones
         else
           return 'N' #NO esta y no tiene permiso especial
         end
       end
     end
   end

   helper_method :permisomejoramiento
   def permisomejoramiento(id) #Evento debe ser N:No, S:Si - id = mejoramientoId
     @mejoramiento = Mejoramiento.find(id)
     #logger.error("error desde mejoramiento....." + @mejoramiento.mejoramientosestado_id.to_s)
     #if @mejoramiento.mejoramientosestado_id.to_i >= 7
     if @mejoramiento.mejoramientosestado_id.to_i >= 10
       if permiso("mejoramientosespecial","A").to_s == "S"
         return 'S' #Permiso especial de modificaciones
       else
         return 'N' #NO esta y no tiene permiso especial
       end
     else
       if @mejoramiento.user_coordinador.to_i == is_admin or @mejoramiento.user_profesional.to_i == is_admin
         return 'S'
       else
         if permiso("mejoramientosespecial","A").to_s == "S"
           return 'S' #Permiso especial de modificaciones
         else
           return 'N' #NO esta y no tiene permiso especial
         end
       end
     end
   end

   helper_method :permisobloqueomejoramiento
   def permisobloqueomejoramiento(mejorid) #Evento debe ser N:No, S:Si - id = mejoramientoId
     @mejoramiento = Mejoramiento.find(mejorid.to_i)
     #if @mejoramiento.mejoramientosestado_id.to_i >= 7
     if @mejoramiento.mejoramientosestado_id.to_i >= 10
       if permiso("mejoramientosespecial","A").to_s == "S"
         return 'S' #Permiso especial de modificaciones
       else
         return 'N' #NO esta y no tiene permiso especial
       end
     else
       return 'S'
     end
   end

   helper_method :descmes
   def descmes(mes)
     if mes.to_s == '1'
       return 'ENERO'
     elsif mes.to_s == '2'
       return 'FEBRERO'
     elsif mes.to_s == '3'
       return 'MARZO'
     elsif mes.to_s == '4'
       return 'ABRIL'
     elsif mes.to_s == '5'
       return 'MAYO'
     elsif mes.to_s == '6'
       return 'JUNIO'
     elsif mes.to_s == '7'
       return 'JULIO'
     elsif mes.to_s == '8'
       return 'AGOSTO'
     elsif mes.to_s == '9'
       return 'SEPTIEMBRE'
     elsif mes.to_s == '10'
       return 'OCTUBRE'
     elsif mes.to_s == '11'
       return 'NOVIEMBRE'
     elsif mes.to_s == '12'
       return 'DICIEMBRE'
     else
       return '------'
     end
   end

   helper_method :descmesmin
   def descmesmin(mes)
     if mes.to_i == 1
       return 'Enero'
     elsif mes.to_i == 2
       return 'Febrero'
     elsif mes.to_i == 3
       return 'Marzo'
     elsif mes.to_i == 4
       return 'Abril'
     elsif mes.to_i == 5
       return 'Mayo'
     elsif mes.to_i == 6
       return 'Junio'
     elsif mes.to_i == 7
       return 'Julio'
     elsif mes.to_i == 8
       return 'Agosto'
     elsif mes.to_i == 9
       return 'Septiembre'
     elsif mes.to_i == 10
       return 'Octubre'
     elsif mes.to_i == 11
       return 'Noviembre'
     elsif mes.to_i == 12
       return 'Diciembre'
     else
       return '------'
     end
   end

   helper_method :fechaprog
   def fechaprog(fechainicial, dias)  
     if fechainicial.to_s != "" and dias.to_s != ""
       @objetos = Objeto.find_by_sql(["select fnc_fecha('#{fechainicial.to_date}',#{dias.to_i}) fch from dual"])
       @objetos.each do |objeto|
         return objeto.fch
       end
     end
   end

   helper_method :fechaprogx
   def fechaprogx(fechainicial, dias)
     if fechainicial.to_s != "" and dias.to_s != ""
       @objetos = Objeto.find_by_sql(["select fnc_fecha('#{fechainicial.to_date}',#{dias.to_i}) fch from dual"])
       @objetos.each do |objeto|
         return objeto.fch
       end
     end
   end
   
   helper_method :diferenciadias
   def diferenciadias(fechasolicitud)
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
     if dias > 0
       return dias
     else
       return (dias * -1)
     end
   end

   helper_method :cruzadoper
   def cruzadoper(personaid)
      last_id = Cruce.maximum('id',:conditions=>["persona_id = #{personaid}"])
      if last_id
        if Crucesdato.exists?(["cruce_id = ?", last_id]) == false
          return 'N' #No esta
        else
          return 'S' #esta
        end
      else
        return 'N'
      end
   end

   helper_method :cruzadoben
   def cruzadoben(beneviviendaid)
      last_id = Cruce.maximum('id',:conditions=>["benevivienda_id = #{beneviviendaid}"])
      if last_id
        if Crucesdato.exists?(["cruce_id = ?", last_id]) == false
          return 'N' #No esta
        else
          return 'S' #esta
        end
      else
        return 'N'
      end
   end

   helper_method :namedate
   def namedate(fecha)
     day_names = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"]
     month_names = ["","Enero","Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
     dia = fecha.strftime("%w").to_i
     ndia = day_names[dia]
     mes = fecha.strftime("%m").to_i
     nmes = month_names[mes]
     fchcompleta = ndia + ' ' + fecha.strftime("%d") + ' de ' + nmes + ' del ' + fecha.strftime("%Y")
     return fchcompleta
   end

   helper_method :camponumerico
   def camponumerico(campo)
     campo1 = campo.to_i
     if campo1 == 0
       campo1 = campo
     else
       campo1 = number_to_currency(campo, :precision => 0, :unit=>"", :delimiter =>".")
       #campo1 = number_to_currency( campo.to_i, :precision => 0, :unit=>"", :delimiter =>".")
     end
     return campo1
   end

   helper_method :replaceenter
   def replaceenter(campo)
     b = campo.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     b = b.sub("\n","<br/>")
     return b
   end
#
#   rescue_from CanCan::AccessDenied do |exception|
#    flash[:warning] = "Usted no tiene acceso a este Modulo"
#    redirect_to menus_url
#  end

  helper_method :is_host
  def is_host
    ip = request.env['REMOTE_ADDR'].to_s
    #logger.error("1sifiiiii conexion - #{ip2}")
    if ip == '127.0.0.1'
      #@objeto = Objeto.find_by_sql("SELECT valor FROM (SELECT valor FROM sifis where descripcion = 'HOST BALANCE LOCAL'
      #                              ORDER BY dbms_random.value) WHERE rownum = 1")
      @objeto = Objeto.find_by_sql("SELECT valor FROM (SELECT valor FROM sifis where descripcion = 'HOST BALANCE'
                                      ORDER BY dbms_random.value) WHERE rownum = 1")
      @objeto.each do |objeto|
        return objeto.valor
      end
    else
      if ip[0,10] == '192.168.1.'
        @objeto = Objeto.find_by_sql("SELECT valor FROM (SELECT valor FROM sifis where descripcion = 'HOST BALANCE LOCAL'
                                      ORDER BY dbms_random.value) WHERE rownum = 1")
        @objeto.each do |objeto|
          return objeto.valor
        end
      else
        @objeto = Objeto.find_by_sql("SELECT valor FROM (SELECT valor FROM sifis where descripcion = 'HOST BALANCE'
                                      ORDER BY dbms_random.value) WHERE rownum = 1")
        @objeto.each do |objeto|
          return objeto.valor
        end
      end
    end
  end

  helper_method :numero_a_palabras
  def numero_a_palabras(numero)
    de_tres_en_tres = numero.to_i.to_s.reverse.scan(/\d{1,3}/).map{|n| n.reverse.to_i}

    millones = [
      {true => nil, false => nil},
      {true => 'MILLÓN', false => 'MILLONES'},
      {true => "BILLÓN", false => "BILLONES"},
      {true => "TRILLÓN", false => "TRILLONES"}
    ]

    centena_anterior = 0
    contador = -1
    palabras = de_tres_en_tres.map do |numeros|
      contador += 1
      if contador%2 == 0
        centena_anterior = numeros
        [centena_a_palabras(numeros), millones[contador/2][numeros==1]].compact if numeros > 0
      elsif centena_anterior == 0
        [centena_a_palabras(numeros), "MIL", millones[contador/2][false]].compact if numeros > 0
      else
        [centena_a_palabras(numeros), "MIL"] if numeros > 0
      end
    end

    palabras.compact.reverse.join(' ')
  end

  helper_method :centena_a_palabras
  def centena_a_palabras(numero)
    especiales = {
      11 => 'ONCE', 12 => 'DOCE', 13 => 'TRECE', 14 => 'CATORCE', 15 => 'QUINCE',
      10 => 'DIEZ', 20 => 'VEINTE', 100 => 'CIEN'
    }
    if especiales.has_key?(numero)
      return especiales[numero]
    end
    centenas = [nil, 'CIENTO', 'DOSCIENTOS', 'TRESCIENTOS', 'CUATROCIENTOS', 'QUINIENTOS', 'SEISCIENTOS', 'SETECIENTOS', 'OCHOCIENTOS', 'NOVECIENTOS']
    decenas = [nil, 'DIECI', 'VEINTI', 'TREINTA', 'CUARENTA', 'CINCUENTA', 'SESENTA', 'SETENTA', 'OCHENTA', 'NOVENTA']
    unidades = [nil, 'UN', 'DOS', 'TRES', 'CUATRO', 'CINCO', 'SEIS', 'SIETE', 'OCHO', 'NUEVE']
    centena, decena, unidad = numero.to_s.rjust(3,'0').scan(/\d/).map{|i| i.to_i}
    palabras = []
    palabras << centenas[centena]
    if especiales.has_key?(decena*10 + unidad)
      palabras << especiales[decena*10 + unidad]
    else
      tmp = "#{decenas[decena]}#{' Y ' if decena > 2 && unidad > 0}#{unidades[unidad]}"
      palabras << (tmp.blank? ? nil : tmp)
    end
    palabras.compact.join(' ')
  end

  helper_method :is_trigger_mej
  def is_trigger_mej(id,userid,blo,tipo)
    mej = Mejoramientosactualizacion.new
    mej.mejoramiento_id = id
    mej.bloque = blo
    mej.tipo_transaccion = tipo
    mej.user_id = userid
    mej.save
  end

  helper_method :is_trigger_tit
  def is_trigger_tit(id,userid,blo,tipo)
    obj = Titulacionesactualizacion.new
    obj.titulacion_id = id
    obj.bloque = blo
    obj.tipo_transaccion = tipo
    obj.user_id = userid
    obj.save
  end

  helper_method :is_trigger_tite
  def is_trigger_tite(id,userid,blo,tipo,obs)
    obj = Titulacionesactualizacion.new
    obj.titulacion_id = id
    obj.bloque = blo
    obj.tipo_transaccion = tipo
    obj.user_id = userid
    obj.observacion = obs
    obj.save
  end

  helper_method :is_trigger_iguana
  def is_trigger_iguana(id,userid,blo,tipo,idbloque)
    obj = Iguanasactualizacion.new
    obj.iguana_id = id
    obj.bloque = blo
    obj.tipo_transaccion = tipo
    obj.user_id = userid
    obj.tabla_id = idbloque
    obj.save
  end  

  helper_method :is_consecutivocero
   def is_consecutivocero(campo)
     @objetos = Objeto.find_by_sql("select lpad(#{campo},5,'0') fact from dual")
     @objetos.each do |objeto|
       return objeto.fact
     end
   end

   helper_method :permisoferia
   def permisoferia
     if Userspermiso.exists?(["user_id = #{is_admin} and objeto_id = 10501"]) == true
       return 'S'
     else
       return 'N'
     end
   end

  helper_method :is_horahabilitadaferia
  def is_horahabilitadaferia
    @horaabre = "07:00:00"
    @horacierre = "19:00:00"
    @hora = Time.now.strftime("%X")
    if @hora <= @horaabre or @hora >= @horacierre
      return 'S'
    else
      return 'N'
    end
  end

  helper_method :is_asigreconocimiento
  def is_asigreconocimiento(titulacionid)
    if titulacionid.to_i > 0
      if Titulacionesasignacion.exists?(["titulacion_id = #{titulacionid} and user_id = #{is_admin} and tipo in ('VISITA DE RECOLECCION DE INFORMACION Y DOCUMENTOS','LEVANTAMIENTO ARQUITECTONICO','ELABORACION DE PLANO ARQUITECTONICO','CALCULO Y REVISION ESTRUCTURAL Y GEOTECNICA DEL PROYECTO','ELABORACION PLANO ESTRUCTURAL','ASIGNACION LIDER SOCIAL','ASIGNACION PERITAJE TECNICO') and fecha_fin is null"]) == true
        return 'S'
      else
        if permiso("asigtemporal","C").to_s == "S"
          return 'S'
        else
          return 'N'
        end
      end
    else
      return 'N'
    end
  end

  helper_method :is_asigdemanda
  def is_asigdemanda(titulacionid)
    if titulacionid.to_i > 0
      if Titulacionesasignacion.exists?(["titulacion_id = #{titulacionid} and user_id = #{is_admin} and tipo in ('PROCESO DE PROYECCION DE DEMANDA','NOTIFICACION AL USUARIO','REASIGNACION AL EQUIPO DE CAMPO') and fecha_fin is null"]) == true
        return 'S'
      else
        if permiso("asigdemanda","C").to_s == "S"
          return 'S'
        else
          return 'N'
        end
      end
    else
      return 'N'
    end
  end

  helper_method :is_asigsantaelena
  def is_asigsantaelena(titulacionid)
    if titulacionid.to_i > 0
      if Titulacionesasignacion.exists?(["titulacion_id = #{titulacionid} and user_id = #{is_admin} and tipo in ('SANTA ELENA - PREDIAGNOSTICO','SANTA ELENA - DIAGNOSTICO') and fecha_fin is null"]) == true
        return 'S'
      else
        if permiso("asigsantaelena","C").to_s == "S"
          return 'S'
        else
          return 'N'
        end
      end
    else
      return 'N'
    end
  end

  helper_method :is_asignacion
  def is_asignacion(titulacion_id)
    if titulacion_id.to_i > 0
      if Titulacionesasignacion.exists?(["titulacion_id = #{titulacion_id} and user_id = #{is_admin} and fecha_fin is null"]) == true
        return 'S'
      else
        if permiso("asigsantaelena","C").to_s == "S" or permiso("asigdemanda","C").to_s == "S" or permiso("asigtemporal","C").to_s == "S"
          return 'S'
        else
          return 'N'
        end
      end
    else
      return 'N'
    end
  end

  helper_method :is_select_user
  def is_select_user
    @users = User.find(:all,:conditions=>["activo = 'S'"], :order=>"nombre")
    return @users
  end

  helper_method :is_select_correspondenciasclase
  def is_select_correspondenciasclase
    @correspondenciasclases = Correspondenciasclase.find(:all, :conditions=>["id not in (10020,10021,10022)"],:order => 'descripcion')
    return @correspondenciasclases
  end

  helper_method :is_select_dependencia
  def is_select_dependencia
    @dependencias = Dependencia.find(:all, :conditions=>["id not in (10010,10004,10041,10040,10043,10060)"], :order=>'descripcion')
    return @dependencias
  end

  helper_method :is_select_correspondenciasremitente
  def is_select_correspondenciasremitente
    @correspondenciasremitentes = Correspondenciasremitente.find(:all, :order => 'entidad,nombre')
    return @correspondenciasremitentes
  end

  helper_method :is_select_especial
  def is_select_especial
    @especiales = Especial.find(:all, :order=>['descripcion'])
    return @especiales
  end

  helper_method :is_select_familiar
  def is_select_familiar
    @familiares = Familiar.find(:all, :order=>['descripcion'])
    return @familiares

  end

  helper_method :is_select_sisben
  def is_select_sisben
    @sisbenes = Sisben.find(:all, :order=>['descripcion'])
    return @sisbenes
  end

  helper_method :is_select_caja
  def is_select_caja
    @cajas = Caja.find(:all, :order=>['descripcion'])
    return @cajas
  end

  helper_method :is_select_comuna
  def is_select_comuna
    @comunas = Comuna.find(:all, :order=>['descripcion2'])
    return @comunas
  end

  helper_method :is_select_resolucionesclase
  def is_select_resolucionesclase
    @resolucionesclases = Resolucionesclase.find(:all, :order =>'descripcion')
    return @resolucionesclases
  end

  helper_method :is_select_empleado
  def is_select_empleado
    @empleados = Empleado.find(:all, :order=>['nombre'])
    return @empleados
  end

  helper_method :is_select_empleado_act
  def is_select_empleado_act
    #@empleados = Empleado.find(:all,:conditions=>["id in (select empleado_id from contratos where to_char(fecha_inicio,'YYYY') = to_char(trunc(sysdate),'YYYY'))"], :order=>['nombre'])
    @empleados = Empleado.find(:all,:conditions=>["abogado = 'SI'"], :order=>['nombre'])
    return @empleados
  end

  helper_method :is_select_empleadointerventor
  def is_select_empleadointerventor
    @empleados = Empleado.find(:all,:conditions=>["cargo is not null"], :order=>['cargo'])
    return @empleados
  end

  helper_method :is_select_empleadointerventor_act
  def is_select_empleadointerventor_act
    @empleados = Empleado.find(:all,:conditions=>["cargo is not null and id in (select empleado_id from contratosvinculados where fecha_final is null)"], :order=>['cargo'])
    return @empleados
  end

  helper_method :is_select_tiposcontrato
  def is_select_tiposcontrato
    @tiposcontratos = Tiposcontrato.find(:all, :order=>['descripcion'])
    return @tiposcontratos
  end

  helper_method :is_select_modalidad
  def is_select_modalidad
    @modalidades = Modalidad.find(:all, :order=>['descripcion'])
    return @modalidades
  end
#Archivo
  helper_method :is_select_archivosserie
  def is_select_archivosserie
    @archivosseries = Archivosserie.find(:all,:order=>"subserie")
    return @archivosseries
  end

  helper_method :is_select_archivosserie_actual
  def is_select_archivosserie_actual(annoselect)
  #  @archivosseries = Archivosserie.find(:all,:conditions=>["anno=?",params[:annoselect]], :order=>"anno")
    @archivosseries = Archivosserie.find(:all, :conditions => "anno = 2018", :order => "anno ASC")
    return @archivosseries
  end

  helper_method :is_help_lastresol
  def is_help_lastresol
    last_id = Resolucion.maximum('id')
    resolucion = Resolucion.find(last_id)
    ultimares  = resolucion.nro_resolucion.to_i
    fecharesol = resolucion.fecha.strftime("%Y-%m-%d")
    return ultimares.to_s+ " del " + fecharesol.to_s
  end

  helper_method :is_help_lastcont
  def is_help_lastcont
    last_id = Contrato.maximum('id')
    contrato = Contrato.find(last_id)
    ultimacon = contrato.nro_contrato.to_i
    fecharesol = contrato.fecha_firma.strftime("%Y-%m-%d")
    return ultimacon.to_s+ " del " + fecharesol.to_s
  end

  helper_method :is_usernameuser
  def is_usernameuser(userid)
    return User.find(userid).username rescue nil
  end

  helper_method :is_select_valorizacionesestado
  def is_select_valorizacionesestado
    @valorizacionesestados = Valorizacionesestado.find(:all, :order=>"descripcion")
    return @valorizacionesestados
  end
  
  helper_method :is_select_valorizacionesobra
  def is_select_valorizacionesobra
    @valorizacionesobras = Valorizacionesobra.find(:all, :order=>"descripcion")
    return @valorizacionesobras
  end
  
  helper_method :is_base384
  def is_base384(vlr) #Evento debe ser A:Actualiza, E:Elimina, C:Crea
    if vlr.to_f <= 128.96
      return 0
    elsif vlr.to_f > 128.96 and vlr.to_f  <= 142.54
      return 0.09
    elsif vlr.to_f > 142.54 and vlr.to_f <= 145.93
      return 0.1
    elsif vlr.to_f > 145.93 and vlr.to_f <= 152.72
      return 0.2
    elsif vlr.to_f > 152.72 and vlr.to_f <= 156.11
      return 0.21
    elsif vlr.to_f > 156.11 and vlr.to_f <= 159.51
      return 0.4
    elsif vlr.to_f > 159.51 and vlr.to_f <= 166.29
      return 0.41
    elsif vlr.to_f > 166.29 and vlr.to_f <= 169.69
      return 0.7
    elsif vlr.to_f > 169.69 and vlr.to_f <= 176.47
      return 0.73
    elsif vlr.to_f > 176.47 and vlr.to_f <= 183.26
      return 1.15
    elsif vlr.to_f > 183.26 and vlr.to_f <= 190.05
      return 1.19
    elsif vlr.to_f > 190.05 and vlr.to_f <= 196.84
      return 1.65
    elsif vlr.to_f > 196.84 and vlr.to_f <= 203.62
      return 2.14
    elsif vlr.to_f > 203.62 and vlr.to_f <= 210.41
      return 2.21
    elsif vlr.to_f > 210.41 and vlr.to_f <= 217.2
      return 2.96
    elsif vlr.to_f > 217.2 and vlr.to_f <= 230.77
      return 3.87
    elsif vlr.to_f > 230.77 and vlr.to_f <= 237.56
      return 4.63
    elsif vlr.to_f > 237.56 and vlr.to_f <= 244.35
      return 5.06
    elsif vlr.to_f > 244.35 and vlr.to_f <= 257.92
      return 5.96
    elsif vlr.to_f > 257.92 and vlr.to_f <= 264.71
      return 6.44
    elsif vlr.to_f > 264.71 and vlr.to_f <= 271.5
      return 6.93
    elsif vlr.to_f > 271.5 and vlr.to_f <= 278.29
      return 7.44
    elsif vlr.to_f > 278.29 and vlr.to_f <= 285.07
      return 7.96
    elsif vlr.to_f > 285.07 and vlr.to_f <= 291.86
      return 8.5
    elsif vlr.to_f > 291.86 and vlr.to_f <= 298.65
      return 9.05
    elsif vlr.to_f > 298.65 and vlr.to_f <= 305.44
      return 9.62
    elsif vlr.to_f > 305.44 and vlr.to_f <= 312.22
      return 10.21
    elsif vlr.to_f > 312.22 and vlr.to_f <= 319.01
      return 10.81
    elsif vlr.to_f > 319.01 and vlr.to_f <= 325.8
      return 11.43
    elsif vlr.to_f > 325.8 and vlr.to_f <= 332.59
      return 12.07
    elsif vlr.to_f > 332.59 and vlr.to_f <= 339.37
      return 12.71
    elsif vlr.to_f > 339.37 and vlr.to_f <= 356.34
      return 14.06
    elsif vlr.to_f > 356.34 and vlr.to_f <= 373.31
      return 15.83
    elsif vlr.to_f > 373.31 and vlr.to_f <= 390.28
      return 17.69
    elsif vlr.to_f > 390.28 and vlr.to_f <= 407.25
      return 19.65
    elsif vlr.to_f > 407.25 and vlr.to_f <= 424.22
      return 21.69
    elsif vlr.to_f > 424.22 and vlr.to_f <= 441.19
      return 23.84
    elsif vlr.to_f > 441.19 and vlr.to_f <= 458.16
      return 26.07
    elsif vlr.to_f > 458.16 and vlr.to_f <= 475.12
      return 28.39
    elsif vlr.to_f > 475.12 and vlr.to_f <= 492.09
      return 30.8
    elsif vlr.to_f > 492.09 and vlr.to_f <= 509.06
      return 33.29
    elsif vlr.to_f > 509.06 and vlr.to_f <= 526.03
      return 35.87
    elsif vlr.to_f > 526.03 and vlr.to_f <= 543
      return 38.54
    elsif vlr.to_f > 543 and vlr.to_f <= 559.97
      return 41.29
    elsif vlr.to_f > 559.97 and vlr.to_f <= 576.94
      return 44.11
    elsif vlr.to_f > 576.94 and vlr.to_f <= 593.9
      return 47.02
    elsif vlr.to_f > 593.9 and vlr.to_f <= 610.87
      return 50
    elsif vlr.to_f > 610.87 and vlr.to_f <= 627.84
      return 53.06
    elsif vlr.to_f > 627.84 and vlr.to_f <= 644.81
      return 56.2
    elsif vlr.to_f > 644.81 and vlr.to_f <= 661.78
      return 59.4
    elsif vlr.to_f > 661.78 and vlr.to_f <= 678.75
      return 62.68
    elsif vlr.to_f > 678.75 and vlr.to_f <= 695.72
      return 66.02
    elsif vlr.to_f > 695.72 and vlr.to_f <= 712.69
      return 69.43
    elsif vlr.to_f > 712.69 and vlr.to_f <= 729.65
      return 72.9
    elsif vlr.to_f > 729.65 and vlr.to_f <= 746.62
      return 76.43
    elsif vlr.to_f > 746.62 and vlr.to_f <= 763.59
      return 80.03
    elsif vlr.to_f > 763.59 and vlr.to_f <= 780.56
      return 83.68
    elsif vlr.to_f > 780.56 and vlr.to_f <= 797.53
      return 87.39
    elsif vlr.to_f > 797.53 and vlr.to_f <= 814.5
      return 91.15
    elsif vlr.to_f > 814.5 and vlr.to_f <= 831.47
      return 94.96
    elsif vlr.to_f > 831.47 and vlr.to_f <= 848.44
      return 98.81
    elsif vlr.to_f > 848.44 and vlr.to_f <= 865.4
      return 102.72
    elsif vlr.to_f > 865.4 and vlr.to_f <= 882.37
      return 106.67
    elsif vlr.to_f > 882.37 and vlr.to_f <= 899.34
      return 110.65
    elsif vlr.to_f > 899.34 and vlr.to_f <= 916.31
      return 114.68
    elsif vlr.to_f > 916.31 and vlr.to_f <= 933.28
      return 118.74
    elsif vlr.to_f > 933.28 and vlr.to_f <= 950.25
      return 122.84
    elsif vlr.to_f > 950.25 and vlr.to_f <= 967.22
      return 126.96
    elsif vlr.to_f > 967.22 and vlr.to_f <= 984.19
      return 131.11
    elsif vlr.to_f > 984.19 and vlr.to_f <= 1001.15
      return 135.29
    elsif vlr.to_f > 1001.15 and vlr.to_f <= 1018.12
      return 139.49
    elsif vlr.to_f > 1018.12 and vlr.to_f <= 1035.09
      return 143.71
    elsif vlr.to_f > 1035.09 and vlr.to_f <= 1052.06
      return 147.94
    elsif vlr.to_f > 1052.06 and vlr.to_f <= 1069.03
      return 152.19
    elsif vlr.to_f > 1069.03 and vlr.to_f <= 1086
      return 156.45
    elsif vlr.to_f > 1086 and vlr.to_f <= 1102.97
      return 160.72
    elsif vlr.to_f > 1102.97 and vlr.to_f <= 1119.93
      return 164.99
    elsif vlr.to_f > 1119.93 and vlr.to_f <= 1136.92
      return 169.26
    elsif vlr.to_f > 1136.92
      vlrr = ((vlr.to_f * 27)/100.to_f - 135.17).to_f.round(2)
      return vlrr
    end
  end

  helper_method :is_baseuvt
  def is_baseuvt
    return Sifi.find(58).valor.to_i
  end

  helper_method :is_retefuente383
  def is_retefuente383
    return Sifi.find(59).valor.to_i
  end

  helper_method :is_retefuente384
  def is_retefuente384
    return Sifi.find(60).valor.to_i
  end

  helper_method :is_baseuvtpor
  def is_baseuvtpor(vlr)
    if vlr.to_i <= 95
      return 0
    elsif vlr.to_i > 95 and vlr.to_i  <= 150
      return 19
    elsif vlr.to_i > 150 and vlr.to_i <= 360
      return 28
    elsif vlr.to_i > 360
      return 33
    end
  end
  
  helper_method :is_restauvt
  def is_restauvt(vlr)
    if vlr.to_i <= 95
      return vlr
    elsif vlr.to_i > 95 and vlr.to_i  <= 150
      return vlr-95.to_i
    elsif vlr.to_i > 150 and vlr.to_i <= 360
      return vlr-150.to_i
    elsif vlr.to_i > 360
      return vlr-360.to_i
    end
  end

  helper_method :is_select_useractivo
  def is_select_useractivo
    @users = User.find(:all, :conditions=>["activo='S'"], :order=>"nombre")
    return @users
  end

  helper_method :is_nextplaca
  def is_nextplaca
    last_id  = Elemento.maximum('id')
    elemento = Elemento.find(last_id)
    nextdato = elemento.placa.to_i + 1
    return nextdato
  end

  helper_method :is_nextresolucion
  def is_nextresolucion
    last_id = Resolucion.maximum('id')
    begin
      resolucion = Resolucion.find(last_id)
      if resolucion.anno == Time.now.strftime("%Y")
        nextdato = resolucion.nro_resolucion.to_i + 1
      else
        nextdato = '1'
      end
    rescue
      nextdato = '1'
    end
    return nextdato
  end

  helper_method :is_nextcontrato
  def is_nextcontrato
    last_id = Contrato.maximum('id')
    begin
      contrato = Contrato.find(last_id)
      if contrato.created_at.strftime("%Y") == Time.now.strftime("%Y")
        nextdato = contrato.nro_contrato.to_i + 1
      else
        nextdato = '1'
      end
    rescue
      nextdato = '1'
    end
    return nextdato
  end

  helper_method :is_capitalize
  def is_capitalize(campo)
    return campo.mb_chars.capitalize
  end

  helper_method :is_select_comunaespecial
  def is_select_comunaespecial
    @comunas = Comuna.find(:all, :order => "comuna" , :select => "distinct codigo_comuna, comuna", :conditions => " codigo_comuna not in ('11','14','50','60','70','80','90')" )
    return @comunas
  end

  helper_method :is_select_barrios
  def is_select_barrios
    @comunas = Comuna.find(:all,:conditions=>["codigo_barrio in ( '0203', '0302', '0801', '0402', '0401', '0104', '1303', '0711', '0408','0912', '0202', '0514', '0604', '1511',
                                                                  '1305', '0303', '0412', '0410', '0504', '0714', '0717', '1201 ',' 0709 ','0501', '0809', '0404', '0209', '0414',
                                                                  '0205', '0602', '0307', '1304', '0204', '1014', '0914', '0405 ','0606', '0607', '0507', '0201', '0713', '0306',
                                                                  '1610', '0712', '0106', '0715', '0601', '1301','0211', '0208', '0105', '0906', '0505', '00006', '0603', '0511',
                                                                  '0210', '0605', '0103', '0503', '0409 ','0411', '0308', '0502', '0413', '0803', '1317', '0802', '1310', '0206',
                                                                  '0107', '0508', '0808', '0905 ','0722','0725','0301','0513','1302','0403','0207','0719','0415','0702')"], :order=> "barrio")
    return @comunas
  end

  helper_method :valorindicador
  def valorindicador(mes,anno,indicador)
    @indicadoresficha = Indicadoresficha.find_by_indicador_id_and_mes_and_anno(indicador,mes,anno)
    return @indicadoresficha.resultado
    rescue
      return nil
  end

  helper_method :is_nextenviada
  def is_nextenviada
    last_id = Correspondenciasenviada.maximum('id')
    begin
      objeto = Correspondenciasenviada.find(last_id)
      if objeto.created_at.strftime("%Y") == Time.now.strftime("%Y")
        nextdato = objeto.nro_radicado.to_i + 1
      else
        nextdato = '1'
      end
    rescue
      nextdato = '1'
    end
    return nextdato
  end

  helper_method :is_nextrecibida
  def is_nextrecibida
    last_id = Correspondenciasrecibida.maximum('id')
    begin
      objeto = Correspondenciasrecibida.find(last_id)
      if objeto.created_at.strftime("%Y") == Time.now.strftime("%Y")
        nextdato = objeto.nro_radicado.to_i + 1
      else
        nextdato = '1'
      end
    rescue
      nextdato = '1'
    end
    return nextdato
  end
  
  helper_method :is_corresmasivo
  def is_corresmasivo(sub)
    if sub.to_s == 'control_int'
      return Mensaje.find(78).asignadoscorreos.to_s
    elsif sub.to_s == 'planeacion'
      return Mensaje.find(77).asignadoscorreos.to_s
    elsif sub.to_s == 'administrativa'
      return Mensaje.find(76).asignadoscorreos.to_s
    elsif sub.to_s == 'poblacional'
      return Mensaje.find(101).asignadoscorreos.to_s
    elsif sub.to_s == 'juridica'
      return Mensaje.find(74).asignadoscorreos.to_s
    elsif sub.to_s == 'dotacion'
      return Mensaje.find(72).asignadoscorreos.to_s
    elsif sub.to_s == 'comunicaciones'
      return Mensaje.find(71).asignadoscorreos.to_s
    elsif sub.to_s == 'direccion'
      return Mensaje.find(70).asignadoscorreos.to_s
    end
  end 

  helper_method :is_subdireccion
  def is_subdireccion(sub)
    if sub.to_s == 'control_int'
      return 'CONTROL INTERNO'
    end
    if sub.to_s == 'planeacion'
      return 'SUBDIRECCION DE PLANEACION'
    end  
     if sub.to_s == 'administrativa'
      return 'SUBDIRECCION ADMINISTRATIVA Y FINANCIERA'
    end
    if sub.to_s == 'poblacional'
      return 'SUBDIRECCION POBLACIONAL'
    end
    if sub.to_s == 'juridica'
      return 'SUBDIRECCION JURIDICA'
    end
    if sub.to_s == 'dotacion'
      return 'SUBDIRECCION DE DOTACION DE VIVIENDA Y HABITAT'
    end
    if sub.to_s == 'comunicaciones'
      return 'COMUNICACIONES'
    end
    if sub.to_s == 'direccion'
      return 'DIRECCION GENERAL'
    end
  end 

  helper_method :is_subdireccionpermiso
  def is_subdireccionpermiso(sub)
    if sub.to_s == 'control_int'
      if Mensaje.find(78).asignadosid.to_s.include?(is_admin.to_s)
        return true
      else
        return false
      end
    end
    if sub.to_s == 'planeacion'
      if Mensaje.find(77).asignadosid.to_s.include?(is_admin.to_s)
        return true
      else
        return false
      end
    end  
     if sub.to_s == 'administrativa'
      if Mensaje.find(76).asignadosid.to_s.include?(is_admin.to_s)
        return true
      else
        return false
      end
    end
    if sub.to_s == 'poblacional'
      if Mensaje.find(101).asignadosid.to_s.include?(is_admin.to_s)
        return true
      else
        return false
      end
    end
    if sub.to_s == 'juridica'
      if Mensaje.find(74).asignadosid.to_s.include?(is_admin.to_s)
        return true
      else
        return false
      end
    end
    if sub.to_s == 'dotacion'
      if Mensaje.find(72).asignadosid.to_s.include?(is_admin.to_s)
        return true
      else
        return false
      end
    end
    if sub.to_s == 'comunicaciones'
      if Mensaje.find(71).asignadosid.to_s.include?(is_admin.to_s)
        return true
      else
        return false
      end
    end
    if sub.to_s == 'direccion'
      if Mensaje.find(70).asignadosid.to_s.include?(is_admin.to_s)
        return true
      else
        return false
      end
    end
  end  


  helper_method :is_notariasur
  def is_notariasur
    if Notaria.exists?(["utilizada is null and zona = 'ZONA SUR'"]) == true
      last = Notaria.find(:first, :conditions=>["utilizada is null and zona = 'ZONA SUR'"], :order=>"id").id
    else
      ActiveRecord::Base.connection.execute("update notarias set utilizada = null where zona = 'ZONA SUR'")
      last = Notaria.find(:first, :conditions=>["utilizada is null and zona = 'ZONA SUR'"], :order=>"id").id
    end
    return last
  end

  helper_method :is_notarianorte
  def is_notarianorte
    if Notaria.exists?(["utilizada is null and zona = 'ZONA NORTE'"]) == true
      last = Notaria.find(:first, :conditions=>["utilizada is null and zona = 'ZONA NORTE'"], :order=>"id").id
    else
      ActiveRecord::Base.connection.execute("update notarias set utilizada = null where zona = 'ZONA NORTE'")
      last = Notaria.find(:first, :conditions=>["utilizada is null and zona = 'ZONA NORTE'"], :order=>"id").id
    end
    return last
  end  

  helper_method :is_nextreparto
  def is_nextreparto
    last_id = Reparto.maximum('nro_acta')
    if last_id.to_i == 0
      last_id = 352
    else
      last_id = last_id + 1
    end
    return last_id
  end  

  helper_method :is_replacespace
  def is_replacespace(campo)
    b = campo.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    return b
  end

  helper_method :is_select_ayudastiposevento
  def is_select_ayudastiposevento
    @objetos = Ayudastiposevento.find(:all, :order=>"descripcion")
    return @objetos
  end

  helper_method :is_nextinterno
  def is_nextinterno
    last_id = Correspondenciasinterna.maximum('id', :conditions=>["consecutivo is not null"])
    begin
      objeto = Correspondenciasinterna.find(last_id)
      if objeto.created_at.strftime("%Y") == Time.now.strftime("%Y")
        nextdato = objeto.consecutivo.to_i + 1
      else
        nextdato = '1'
      end
    rescue
      nextdato = '1'
    end
    return nextdato
  end
  
  helper_method :is_help_lastint
  def is_help_lastint
    last_id = Correspondenciasinterna.maximum('id', :conditions=>["consecutivo is not null"])
    cc = Correspondenciasinterna.find(last_id)
    ultimacon  = cc.consecutivo.to_i
    fecharesol = cc.created_at.strftime("%Y-%m-%d")
    return ultimacon.to_s+ " del " + fecharesol.to_s
  end

  helper_method :is_trigger_interno
  def is_trigger_interno(id,userid,blo)
    obj = Corresinternasbitacora.new
    obj.correspondenciasinterna_id = id
    obj.actividad = blo
    obj.user_id = userid
    obj.save
  end

  helper_method :is_select_uservinculadoactivo
  def is_select_uservinculadoactivo
    @users = User.find(:all, :conditions=>["activo='S' and identificacion in (select identificacion from empleados where tipo = 'V')"], :order=>"nombre")
    return @users
  end

  helper_method :is_nextcruce
  def is_nextcruce
    last_id = Crucessolicitud.maximum('consecutivo')
    if last_id.to_i == 0
      last_id = 1
    else
      last_id = last_id + 1
    end
    return last_id
  end

  helper_method :is_trigger_interventoria
  def is_trigger_interventoria(contratoid,interventorempleadoid,userid)
    if Contratosinterventoria.exists?(["contrato_id = #{contratoid} and fecha_fin is null"]) == true
      ActiveRecord::Base.connection.execute("update contratosinterventorias set fecha_fin = sysdate-1, user_actualiza = #{userid}
                                             where contrato_id = #{contratoid} and fecha_fin is null")

    end
    mej = Contratosinterventoria.new
    mej.contrato_id = contratoid
    mej.interventorempleado_id = interventorempleadoid
    mej.fecha_inicio = Time.now
    mej.user_id = userid
    mej.save
    @contrato = Contrato.find(contratoid)
    correo = User.find(is_admin).email.to_s
    interventor = User.find_by_identificacion(Empleado.find(@contrato.interventorempleado_id).identificacion).email rescue nil
    if interventor
      correo = correo + ',' + interventor.to_s
    end
    begin
      Notifier.deliver_actainterventoria_message(correo, @contrato)
      flash[:notice] = "Correo ENVIADO con Exito"
      rescue Exception => exc
        flash[:notice] = "Correo NO ENVIADO, Verifique! "+@contrato.id.to_s
    end
  end

  helper_method :is_enviada
  def is_enviada
    last_id = Correspondenciasenviada.maximum('id')
    begin
      objeto = Correspondenciasenviada.find(last_id)
      return objeto.nro_radicado.to_i
    end
  end

  helper_method :is_recibida
  def is_recibida
    last_id = Correspondenciasrecibida.maximum('id')
    begin
      objeto = Correspondenciasrecibida.find(last_id)
      return objeto.nro_radicado.to_i
    end
  end

  helper_method :is_permit
  def is_permit(controlador)
    dato = '/'+controlador
    mod = Modulo.find_by_controlador(dato) rescue nil
    if Usersmodulo.exists?(["modulo_id = #{mod.id} and user_id = #{is_admin}"]) == true
      return true
    else
      return false
    end
  end

  helper_method :is_activo
  def is_activo
    if User.find(is_admin).activo.to_s == 'S'
      return true
    else
      return false
    end
  end

  helper_method :is_feria
    def is_feria
      if Objeto.exists?(["descripcion = 'personasferia'"])
        return true
      else
        return false
      end
   end

  helper_method :is_feria
   def is_feria(objeto, evento) #Evento debe ser A:Actualiza, E:Elimina, C:Crea
     objetoid = Objeto.find_by_descripcion(objeto)
     if objetoid.to_s != ""
       userspermisos = Userspermiso.find(:all, :conditions =>['user_id = ? and objeto_id = ?', is_admin, objetoid])
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

   helper_method :letras
   def letras(campo)
    b = campo.sub("Á","á")
    b = b.sub("É","é")
    b = b.sub("Í","í")
    b = b.sub("Ó","ó")
    b = b.sub("Ú","ú")
    b = b.sub("Ñ","ñ")
    return b
   end
end

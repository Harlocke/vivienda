class Vivienda < ActiveRecord::Base
  belongs_to :persona
  belongs_to :proyecto
  belongs_to :bloque
  belongs_to :piso
  belongs_to :apto
  belongs_to :proceso
  has_many :viviendasimagenes
  has_many :observaviviendas
  has_many :viviendasrenuncias
  has_many :viviendasposventas
  has_many :viviendastramites
  has_many :viviendasreportes
  has_many :viviendaspersonas
  has_many :antviviendastramites
  has_many :antobservaviviendas
  has_many :antviviendaspersonas
  has_many :repartosinmuebles

  def self.fechavencimiento(vivienda)
    @vivienda = Vivienda.find(vivienda.id)
      ActiveRecord::Base.connection.execute("update viviendas set fecha_vencimiento = fnc_dias(to_date('#{@vivienda.esc_expedicion}','dd/mm/yyyy'),85)
                                             where id = #{@vivienda.id}")
      ActiveRecord::Base.connection.execute("update viviendas set fecha_vencimientoaclaracion = fnc_dias(to_date('#{@vivienda.aclaratoria_fecha}','dd/mm/yyyy'),85)
                                             where id = #{@vivienda.id}")
  end

  def self.search(vivienda, fchinicial, fchfinal, page, perpage)
      cadena = ""
      if vivienda.proyecto_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and proyecto_id = ' + vivienda.proyecto_id.to_s
        else
          cadena = ' proyecto_id = ' + vivienda.proyecto_id.to_s
        end
      end
      if vivienda.bloque_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and bloque_id = ' + vivienda.bloque_id.to_s
        else
          cadena = ' bloque_id = ' + vivienda.bloque_id.to_s
        end
      end
      if vivienda.piso_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and piso_id = ' + vivienda.piso_id.to_s
        else
          cadena = ' piso_id = ' + vivienda.piso_id.to_s
        end
      end
      if vivienda.apto_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and apto_id = ' + vivienda.apto_id.to_s
        else
          cadena = ' apto_id = ' + vivienda.apto_id.to_s
        end
      end
      if vivienda.estado.to_s != ""
        if cadena != ""
          cadena = cadena + ' and estado = ' + "'#{vivienda.estado}'"
        else
          cadena = ' estado = ' + "'#{vivienda.estado}'"
        end
      end
      if vivienda.fonade.to_s != ""
        if cadena != ""
          cadena = cadena + ' and fonade = ' + "'#{vivienda.fonade}'"
        else
          cadena = ' fonade = ' + "'#{vivienda.fonade}'"
        end
      end
      if vivienda.vinculado.to_s != ""
        if cadena != ""
          cadena = cadena + ' and vinculado = ' + "'#{vivienda.vinculado}'"
        else
          cadena = ' vinculado = ' + "'#{vivienda.vinculado}'"
        end
      end
      if vivienda.entregado.to_s != ""
        if cadena != ""
          if vivienda.entregado.to_s == "S"
            if fchinicial != "" and fchfinal != ""
              cadena = cadena + ' and entregado = ' + "'#{vivienda.entregado}'" +' and fecha_entrega between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
            else
              cadena = cadena + ' and entregado = ' + "'#{vivienda.entregado}'"
            end
          else
            cadena = cadena + ' and entregado = ' + "'#{vivienda.entregado}'"
          end
        else
          cadena = ' entregado = ' + "'#{vivienda.entregado}'"
        end
      end
      if cadena != ""
        #find(:all, :conditions => [cadena], :order => "to_number(caja), to_number(carpeta), barrio")
        paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "proyecto_id, bloque_id, apto_id"
      else
        paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at"
      end
  end

  def self.searchasocia(vivienda)
      cadena = ""
      if vivienda.proyecto_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and proyecto_id = ' + vivienda.proyecto_id.to_s
        else
          cadena = ' proyecto_id = ' + vivienda.proyecto_id.to_s
        end
      end
      if vivienda.bloque_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and bloque_id = ' + vivienda.bloque_id.to_s
        else
          cadena = ' bloque_id = ' + vivienda.bloque_id.to_s
        end
      end
      if vivienda.piso_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and piso_id = ' + vivienda.piso_id.to_s
        else
          cadena = ' piso_id = ' + vivienda.piso_id.to_s
        end
      end
      if vivienda.apto_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and apto_id = ' + vivienda.apto_id.to_s
        else
          cadena = ' apto_id = ' + vivienda.apto_id.to_s
        end
      end
      if cadena != ""
          cadena = cadena + ' and estado = ' + "'#{vivienda.estado}'"
      else
          cadena = ' estado = ' + "'#{vivienda.estado}'"
      end
      find(:all, :conditions => [cadena], :order => "proyecto_id, bloque_id, apto_id")
  end

  def self.create2(vivienda)
    @viviendaspersona = Viviendaspersona.find_by_vivienda_id(vivienda.id)
    @persona          = Persona.find(@viviendaspersona.persona_id)
    users  = User.find(:all, :conditions => ['id in (select user_id from mensajesusers where mensaje_id = 1)'])
    users.each do |x|
      if Mensajesenvio.enviado(x.id, vivienda.id) == false
        Notifier.deliver_gmail_message(x, vivienda, @persona)
        m = Mensajesenvio.new
        m.mensaje_id  = 1
        m.user_id     = x.id
        m.vivienda_id = vivienda.id
        m.estado      = 'A'
        m.descripcion = 'Solicitud de entrega de la vivienda del proyecto - '+vivienda.proyecto.descripcion+
                        ' - Bloque '+vivienda.bloque.descripcion+' - Apartamento '+vivienda.apto.descripcion+
                        '. El cual pertenece a '+@persona.primer_nombre+' '+@persona.segundo_nombre+' '+@persona.primer_apellido+' '+@persona.segundo_apellido+
                        ', con identificación Nro. '+@persona.identificacion
        m.save
      end
    end
  end

  def direccionproyecto
    return self.proyecto.descripcion.to_s + ' ' + self.bloque.direccion.to_s + ' -  Bloque: ' + self.bloque.descripcion.to_s + ' -  Apto : ' + self.apto.descripcion.to_s
  end

  def estadovivienda
     if self.estado == "O"
       return "ASIGNADO"
     elsif self.estado == "D"
       return "DISPONIBLE"
     end
  end

  def descentregado
     if self.entregado == "S"
       return "SI"
     elsif self.entregado == "N"
       return "NO"
     end
  end

  def estadopadre
     if self.estado_padre == "1"
       return "ASIGNADOS SIN ENTREGAR"
     elsif self.estado_padre == "2"
       return "ASIGNADOS SIN ENTREGAR EN CIERRE"
     elsif self.estado_padre == "3"
      return "DISPONIBLES"
     elsif self.estado_padre == "4"
       return "EN CIERRE"
     elsif self.estado_padre == "5"
       return "EN PROCESO DE ESCRITURACION"
     elsif self.estado_padre == "6"
       return "ESCRITURADOS"
     end
  end

  def saldocierre(id_vivienda)
    viviendaspersona = Viviendaspersona.find_by_vivienda_id(id_vivienda)
    valorsubsidio = 0
    valorcredito = 0
    subsidio = Subsidio.find(:all, :conditions=>["tipos_subsidio_id in (select id from tipos_subsidios where vivienda_nueva = 'SI') and persona_id = #{viviendaspersona.persona_id}"])
    #subsidio = Subsidio.find(:all, :conditions=>["tipos_subsidio_id in (1,6,7,3,2,4,5) and persona_id = #{viviendaspersona.persona_id}"])
    #subsidio = Subsidio.find_all_by_persona_id(viviendaspersona.persona_id)
    subsidio.each do |data|
       if data.tipos_subsidio_id.to_s == '3'
         valorsubsidio = valorsubsidio + data.valor.to_i - self.consig_escrituras.to_i
       else
         valorsubsidio = valorsubsidio + data.valor.to_i
       end
    end
    credito = Credito.find_all_by_persona_id(viviendaspersona.persona_id)
    credito.each do |data|
       valorcredito = valorcredito + data.valor.to_i
    end
    valoraportes = valorsubsidio.to_i + valorcredito.to_i + self.valor_donacion.to_i + self.valor_ahorro_tras.to_i + self.otros_aportes.to_i
    valorsaldo = self.valor_vivienda.to_i - valoraportes.to_i
    return valorsaldo
  end

  def self.valorcredito(id_vivienda)
    valorcredito = 0
    viviendaspersona = Viviendaspersona.find_by_vivienda_id(id_vivienda)
    if viviendaspersona
      credito = Credito.find_all_by_persona_id(viviendaspersona.persona_id)
      credito.each do |data|
         valorcredito = valorcredito + data.valor.to_i
      end
    end
    return valorcredito
  end

  def self.valorsubsidio(id_vivienda, consigescrituras)
    valorsubsidio = 0
    viviendaspersona = Viviendaspersona.find_by_vivienda_id(id_vivienda)
    if viviendaspersona
      subsidio = Subsidio.find(:all, :conditions=>["tipos_subsidio_id in (select id from tipos_subsidios where vivienda_nueva = 'SI') and persona_id = #{viviendaspersona.persona_id}"])
      #subsidio = Subsidio.find(:all, :conditions=>["tipos_subsidio_id in (1,6,7,3,2,4,5) and persona_id = #{viviendaspersona.persona_id}"])
      #subsidio = Subsidio.find_all_by_persona_id(viviendaspersona.persona_id)
      subsidio.each do |data|
         if data.tipos_subsidio_id.to_s == '3'
           valorsubsidio = valorsubsidio + data.valor.to_i - consigescrituras.to_i
         else
           valorsubsidio = valorsubsidio + data.valor.to_i
         end
      end
    end
    return valorsubsidio
  end

  def saldocierrevivienda
    viviendaspersona = Viviendaspersona.find_by_vivienda_id(self.id)
    valorsubsidio = 0
    valorcredito = 0
    #subsidio = Subsidio.find(:all, :conditions=>["tipos_subsidio_id in (1,6,7,3,2,4,5) and persona_id = #{viviendaspersona.persona_id}"])
    subsidio = Subsidio.find(:all, :conditions=>["tipos_subsidio_id in (select id from tipos_subsidios where vivienda_nueva = 'SI') and persona_id = #{viviendaspersona.persona_id}"])
    #subsidio = Subsidio.find_all_by_persona_id(viviendaspersona.persona_id)
    subsidio.each do |data|
       if data.tipos_subsidio_id.to_s == '3'
         valorsubsidio = valorsubsidio + data.valor.to_i - self.consig_escrituras.to_i
       elsif data.tipos_subsidio_id.to_s == '8'
         valorsubsidio = valorsubsidio
       else
         valorsubsidio = valorsubsidio + data.valor.to_i
       end
    end
    credito = Credito.find_all_by_persona_id(viviendaspersona.persona_id)
    credito.each do |data|
       valorcredito = valorcredito + data.valor.to_i
    end
    valoraportes = valorsubsidio.to_i + valorcredito.to_i + self.valor_donacion.to_i + self.valor_ahorro_tras.to_i + self.valor_aportado.to_i
    valorsaldo = self.valor_vivienda.to_i - valoraportes.to_i
    return valorsaldo
  end

  def self.clasificacion(vivienda_id, persona_id)
    vivienda = Vivienda.find(vivienda_id)
    nombreproyecto = Proyecto.find(vivienda.proyecto_id).descripcion
    nombrebloque = Bloque.find(vivienda.bloque_id).descripcion
    nombrepiso = Piso.find(vivienda.piso_id).descripcion
    nombreapto = Apto.find(vivienda.apto_id).descripcion
    personasclasificacion = Personasclasificacion.new
    personasclasificacion.persona_id = persona_id
    personasclasificacion.clasificacion_id = 10002
    personasclasificacion.descripcion = 'PROYECTO '+nombreproyecto+' BLOQUE '+nombrebloque+' PISO '+nombrepiso+' APTO '+nombreapto
    personasclasificacion.save
  end

  def limpiavivienda(id_vivienda)
     vivienda = Vivienda.find(id_vivienda);
       vivienda.estado ='D'
       vivienda.nro_matricula = ""
       vivienda.poblacion_objeto = ""
       vivienda.valor_vivienda = ""
       vivienda.acreditacion = ""
       vivienda.consig_escrituras = ""
       vivienda.pago_escrituras = ""
       vivienda.notaria = ""
       vivienda.forma_pago = ""
       vivienda.otros_aportes = ""
       vivienda.valor_ahorro_prog = ""
       vivienda.valor_ahorro_tras = ""
       vivienda.valor_donacion = ""
       vivienda.entregado = ""
       vivienda.fecha_entrega = ""
       vivienda.carpeta = ""
       vivienda.fonade = ""
       vivienda.vinculado = ""
       vivienda.censo_habitado = ""
       vivienda.censo_habitado_por = ""
       vivienda.censo_reasentado_censo = ""
       vivienda.censo_poseedor = ""
       vivienda.censo_demanda_org = ""
       vivienda.censo_nro_habitante = ""
       vivienda.censo_menores_16 = ""
       vivienda.censo_mayores_65 = ""
       vivienda.censo_posventa_otros = ""
       vivienda.esc_nro_escritura = ""
       vivienda.esc_expedicion = ""
       vivienda.esc_notaria_origen = ""
       vivienda.esc_registrada = ""
       vivienda.esc_registrada_of = ""
       vivienda.esc_registro = ""
       vivienda.esc_en_tramite = ""
       vivienda.esc_estado_actual = ""
       vivienda.esc_oficina_registro = ""
       vivienda.esc_gravamenes = ""
       vivienda.esc_limitaciones = ""
       vivienda.liq_valor_rentas = ""
       vivienda.liq_rentas_fecha = ""
       vivienda.liq_rentas_nro = ""
       vivienda.liq_valor_registro = ""
       vivienda.liq_registro_fecha = ""
       vivienda.liq_registro_nro = ""
       vivienda.liq_valor_notaria = ""
       vivienda.liq_notaria_fecha = ""
       vivienda.liq_notaria_nro = ""
       vivienda.liq_fiducia_sol_fecha = ""
       vivienda.liq_fiducia_dese_fecha = ""
       vivienda.solicitar_entrega = ""
       vivienda.proceso_id = ""
       vivienda.valor_proceso = ""
       vivienda.escriturado = ""
       vivienda.estado_padre = ""
       vivienda.fecha_recescritura = ""
       vivienda.lic_registro = ""
       vivienda.lic_certificado = ""
       vivienda.fecha_cobnotaria = ""
       vivienda.fecha_recnotaria = ""
       vivienda.concepto_notaria = ""
       vivienda.fecha_entregafin = ""
       vivienda.valor_avaluo = ""
       vivienda.valor_aportado = ""
       vivienda.fecha_vencimiento = ""
       vivienda.valor_venta = ""
       vivienda.valor_prerregistro = ""
       vivienda.valor_prerentas = ""
       vivienda.vencimiento_rentas = ""
       vivienda.fecha_prefinanciera = ""
       vivienda.fecha_preregistrofinan = ""
       vivienda.save
  end

  def self.desvinculacompleto(viviendaspersona_id,userid)
    @viviendaspersona = Viviendaspersona.find(viviendaspersona_id)
    @persona = Persona.find(@viviendaspersona.persona_id)
    #
    # Asignacion anterior Vivienda
    #
    @antviviendaspersona = Antviviendaspersona.new
    @antviviendaspersona.vivienda_id = @viviendaspersona.vivienda_id
    @antviviendaspersona.fecha_inicio = @viviendaspersona.created_at
    @antviviendaspersona.fecha_final = Time.now
    @antviviendaspersona.observaciones = "ASIGNACION ANTERIOR A " + @persona.autobuscar.to_s
    @antviviendaspersona.user_desvincula = userid
    @antviviendaspersona.fecha_desvincula = Time.now
    @antviviendaspersona.save
    #
    # Respaldo de los tramites anteriores
    #
    @viviendastramites = Viviendastramite.find_all_by_vivienda_id(@viviendaspersona.vivienda_id)
    @viviendastramites.each do |viviendastramite|
       @antviviendastramite = Antviviendastramite.new
       @antviviendastramite.vivienda_id = viviendastramite.vivienda_id
       @antviviendastramite.viviendastipostramite_id = viviendastramite.viviendastipostramite_id
       @antviviendastramite.fecha_inicio = viviendastramite.fecha_inicio
       @antviviendastramite.fecha_esperada = viviendastramite.fecha_esperada
       @antviviendastramite.observaciones = "ASIGNACION ANTERIOR A " + @persona.autobuscar.to_s + " * " + viviendastramite.observaciones.to_s
       @antviviendastramite.created_at = viviendastramite.created_at
       @antviviendastramite.updated_at = viviendastramite.updated_at
       @antviviendastramite.user_id = viviendastramite.user_id
       @antviviendastramite.useract_id = viviendastramite.useract_id
       @antviviendastramite.devolucion = viviendastramite.devolucion
       @antviviendastramite.verificacion = viviendastramite.verificacion
       @antviviendastramite.user_desvincula = userid
       @antviviendastramite.fecha_desvincula = Time.now
       @antviviendastramite.save
    end
    #
    # Respaldo de las observaciones anteriores
    #
    @observaviviendas = Observavivienda.find_all_by_vivienda_id(@viviendaspersona.vivienda_id)
    @observaviviendas.each do |observavivienda|
       @antobservavivienda = Antobservavivienda.new
       @antobservavivienda.vivienda_id = observavivienda.vivienda_id
       @antobservavivienda.observacion = "ASIGNACION ANTERIOR A " + @persona.autobuscar.to_s + " * " + observavivienda.observacion
       @antobservavivienda.user_id = observavivienda.user_id
       @antobservavivienda.created_at = observavivienda.created_at
       @antobservavivienda.updated_at = observavivienda.updated_at
       @antobservavivienda.tipo_atencion = observavivienda.tipo_atencion
       @antobservavivienda.user_desvincula = userid
       @antobservavivienda.fecha_desvincula = Time.now       
       @antobservavivienda.save
    end
    #
    # Limpia toda la informacion del registro de la vivienda.
    #
    vivienda = Vivienda.find(@viviendaspersona.vivienda_id)
    vivienda.estado ='D'
    vivienda.valor_vivienda = ""
    vivienda.valor_ahorro_prog = ""
    vivienda.valor_ahorro_tras = ""
    vivienda.consig_escrituras = ""
    vivienda.valor_avaluo = ""
    vivienda.valor_aportado = ""
    vivienda.valor_donacion = ""
    vivienda.esc_nro_escritura = ""
    vivienda.esc_expedicion = ""
    vivienda.fecha_vencimiento = ""
    vivienda.esc_notaria_origen = ""
    vivienda.esc_registrada = ""
    vivienda.esc_registrada_of = ""
    vivienda.esc_registro = ""
    vivienda.nro_matricula = ""
    vivienda.valor_avaluo = ""
    vivienda.valor_venta = ""
    vivienda.esc_gravamenes = ""
    vivienda.escritura_aclaratoria = ""
    vivienda.aclaratoria_fecha = ""
    vivienda.fecha_vencimientoaclaracion = ""
    vivienda.aclaratoria_notaria = ""
    vivienda.afecta_vivienda = ""
    vivienda.esc_limitaciones = ""
    vivienda.fecha_prefinanciera = ""
    vivienda.valor_prerregistro = ""
    vivienda.valor_prerentas = ""
    vivienda.vencimiento_rentas = ""
    vivienda.liq_valor_rentas = ""
    vivienda.liq_rentas_fecha = ""
    vivienda.liq_rentas_nro = ""
    vivienda.lic_registro = ""
    vivienda.lic_certificado = ""
    vivienda.liq_valor_registro = ""
    vivienda.liq_registro_fecha = ""
    vivienda.liq_registro_nro = ""
    vivienda.liq_valor_notaria = ""
    vivienda.liq_notaria_nro = ""
    vivienda.fecha_cobnotaria = ""
    vivienda.fecha_recnotaria = ""
    vivienda.concepto_notaria = ""
    vivienda.liq_valor_notaria2 = ""
    vivienda.liq_notaria_nro2 = ""
    vivienda.fecha_cobnotaria2 = ""
    vivienda.fecha_recnotaria2 = ""
    vivienda.concepto_notaria2 = ""
    vivienda.entregado = ""
    vivienda.fecha_entrega = ""
    vivienda.censo_habitado = ""
    vivienda.censo_habitado_por = ""
    vivienda.censo_nro_habitante = ""
    vivienda.censo_menores_16 = ""
    vivienda.censo_mayores_65 = ""
    vivienda.save
    #
    # Elimina la relacion 
    #
    Viviendastramite.delete_all("vivienda_id = #{@viviendaspersona.vivienda_id}")
    Observavivienda.delete_all("vivienda_id = #{@viviendaspersona.vivienda_id}")
    Viviendaspersona.delete(@viviendaspersona.id)
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end

end

class Viviendasrenuncia < ActiveRecord::Base
  belongs_to :persona
  belongs_to :vivienda

  validates_presence_of :tipo_renuncia, :fecha

  #Procedimiento para liberar vivienda
   def self.resetvivienda(id_persona, id_vivienda, tiporenuncia, userid)
     #if (tiporenuncia == '1')
     #elsif (tiporenuncia == '2')
     if ( (tiporenuncia == '3') or (tiporenuncia == '4') ) #Renuncia al proyecto o revocado
       cantvivienda = Viviendaspersona.count(:conditions => [' vivienda_id = ? ', id_vivienda])
       if cantvivienda > 1
         viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id_and_persona_id(id_vivienda, id_persona);
         viviendaspersonas.each do |data|
           data.destroy
         end
         personasclasificaciones = Personasclasificacion.find_all_by_persona_id_and_clasificacion_id(id_persona,'10002')
         personasclasificaciones.each do |data|
           data.destroy
         end
       else
#         creditos = Credito.find_all_by_persona_id(id_persona);
#         creditos.each do |data|
#            antcredito = Antcredito.new
#            antcredito.persona_id = data.persona_id
#            antcredito.consecutivo_viv = data.consecutivo_viv
#            antcredito.entidad_id = data.entidad_id
#            antcredito.valor = data.valor
#            antcredito.fecha_credito = data.fecha_credito
#            antcredito.fecha_vencimiento = data.fecha_vencimiento
#            antcredito.estado = data.estado
#            antcredito.resolucion = data.resolucion
#            antcredito.user_id = userid
#            antcredito.save
#            data.destroy
#         end
#         subsidios = Subsidio.find_all_by_persona_id(id_persona);
#         subsidios.each do |data|
#            antsubsidio = Antsubsidio.new
#            antsubsidio.persona_id = data.persona_id
#            antsubsidio.consecutivo_viv = data.consecutivo_viv
#            antsubsidio.tipos_subsidio_id = data.tipos_subsidio_id
#            antsubsidio.valor = data.valor
#            antsubsidio.resolucion = data.resolucion
#            antsubsidio.fecha_asig = data.fecha_asig
#            antsubsidio.entidad_otorga = data.entidad_otorga
#            antsubsidio.fecha_cobro = data.fecha_cobro
#            antsubsidio.tipo_cobro = data.tipo_cobro
#            antsubsidio.fecha_subsidio = data.fecha_subsidio
#            antsubsidio.estado = data.estado
#            antsubsidio.entidad_admin = data.entidad_admin
#            antsubsidio.fecha_pago = data.fecha_pago
#            antsubsidio.solicitud_pago = data.solicitud_pago
#            antsubsidio.modalidad = data.modalidad
#            antsubsidio.fecha_vigencia = data.fecha_vigencia
#            antsubsidio.estado_int = data.estado_int
#            antsubsidio.valor_utilizado = data.valor_utilizado
#            antsubsidio.bolsa = data.bolsa
#            antsubsidio.user_id = userid
#            antsubsidio.save
#            data.destroy
#         end
         viviendas = Vivienda.find(id_vivienda);
         viviendas.nro_matricula = ""
         viviendas.poblacion_objeto = ""
         viviendas.valor_vivienda = ""
         viviendas.acreditacion = ""
         viviendas.consig_escrituras = ""
         viviendas.pago_escrituras = ""
         viviendas.notaria = ""
         viviendas.forma_pago = ""
         viviendas.otros_aportes = ""
         viviendas.valor_ahorro_prog = ""
         viviendas.valor_ahorro_tras = ""
         viviendas.valor_donacion = ""
         viviendas.entregado = ""
         viviendas.fecha_entrega = ""
         viviendas.carpeta = ""
         viviendas.fonade = ""
         viviendas.vinculado = ""
         viviendas.estado_inmueble = ""
         viviendas.censo_habitado = ""
         viviendas.censo_habitado_por = ""
         viviendas.censo_reasentado_censo = ""
         viviendas.censo_poseedor = ""
         viviendas.censo_demanda_org = ""
         viviendas.censo_nro_habitante = ""
         viviendas.censo_menores_16 = ""
         viviendas.censo_mayores_65 = ""
         viviendas.censo_posventa_otros = ""
         viviendas.esc_nro_escritura = ""
         viviendas.esc_expedicion = ""
         viviendas.esc_notaria_origen = ""
         viviendas.esc_registrada = ""
         viviendas.esc_registrada_of = ""
         viviendas.esc_registro = ""
         viviendas.esc_en_tramite = ""
         viviendas.esc_estado_actual = ""
         viviendas.esc_oficina_registro = ""
         viviendas.esc_gravamenes = ""
         viviendas.esc_limitaciones = ""
         viviendas.liq_valor_rentas = ""
         viviendas.liq_rentas_fecha = ""
         viviendas.liq_rentas_nro = ""
         viviendas.liq_valor_registro = ""
         viviendas.liq_registro_fecha = ""
         viviendas.liq_registro_nro = ""
         viviendas.liq_valor_notaria = ""
         viviendas.liq_notaria_fecha = ""
         viviendas.liq_notaria_nro = ""
         viviendas.liq_fiducia_sol_fecha = ""
         viviendas.liq_fiducia_dese_fecha = ""
         viviendas.solicitar_entrega = ""
         viviendas.valor_proceso = ""
         viviendas.escriturado = ""
         viviendas.fecha_recescritura = ""
         viviendas.lic_registro = ""
         viviendas.lic_certificado = ""
         viviendas.fecha_cobnotaria = ""
         viviendas.fecha_recnotaria = ""
         viviendas.concepto_notaria = ""
         viviendas.fecha_entregafin = ""
         viviendas.valor_avaluo = ""
         viviendas.valor_aportado = ""
         viviendas.estado ='D'
         viviendas.save
         viviendaspersonas = Viviendaspersona.find_all_by_vivienda_id(id_vivienda);
         viviendaspersonas.each do |data|
           data.destroy
         end
         personasclasificaciones = Personasclasificacion.find_all_by_persona_id_and_clasificacion_id(id_persona,'10002')
         personasclasificaciones.each do |data|
           data.destroy
         end
       end
     end
   end

  def tiporenuncia
     if self.tipo_renuncia == "1"
       return " A ELEGIBILIDAD"
     elsif self.tipo_renuncia == "2"
       return "ASIGNACION"
     elsif self.tipo_renuncia == "3"
       return "AL PROYECTO"
     elsif self.tipo_renuncia == "4"
       return "REVOCADO"
     end
  end

  def infovivienda
    vivienda = Vivienda.find(self.vivienda_id)
    cadena = vivienda.proyecto.descripcion rescue nil
    cadena = cadena + ' BLOQUE ' +vivienda.bloque.descripcion rescue nil
    cadena = cadena + ' APTO ' +vivienda.apto.descripcion rescue nil
    return cadena
  end
end

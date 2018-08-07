# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def javascript(*files)
		content_for(:head) { javascript_include_tag(*files) }
	end

	def stylesheet(*files)
		content_for(:head) { stylesheet_link_tag(*files) }
	end

	FLASH_NOTICE_KEYS = [:error, :notice, :warning, :subsidio]

	def flash_messages
		return unless messages = flash.keys.select{|k| FLASH_NOTICE_KEYS.include?(k)}
			formatted_messages = messages.map do |type|
				content_tag :div, :class => type.to_s do
				message_for_item(flash[type], flash["#{type}_item".to_sym])
			end
		end
		formatted_messages.join
	end

	def message_for_item(message, item = nil)
		if item.is_a?(Array)
			message % link_to(*item)
		else
			message % item
		end
	end

	def select_user
		return is_select_user
	end

  def select_correspondenciasclase
		return is_select_correspondenciasclase
	end

  def select_dependencia
		return is_select_dependencia
	end

  def select_correspondenciasremitente
		return is_select_correspondenciasremitente
	end

  def select_especial
    return is_select_especial
  end

  def select_familiar
    return is_select_familiar
  end

  def select_sisben
    return is_select_sisben
  end

  def select_caja
    return is_select_caja
  end

  def select_comuna
    return is_select_comuna
  end

  def select_resolucionesclase
    return is_select_resolucionesclase
  end

  def select_empleado
    return is_select_empleado
  end

  def select_tiposcontrato
    return is_select_tiposcontrato
  end

  def select_modalidad
    return is_select_modalidad
  end

  def select_archivosserie
    return is_select_archivosserie
  end

  def select_archivosserie_actual
    return is_select_archivosserie_actual
  end

  def select_archivosserie_anno
    [
      ["2015","2015"],
      ["2018","2018"]
    ]
  end

  def select_ayudastiposevento
    return is_select_ayudastiposevento
  end  

  def select_sino
    [
      ["SI","SI"],
      ["NO","NO"]
    ]
  end

  def select_sinonoaplica
    [
      ["SI","SI"],
      ["NO","NO"],
      ["NO APLICA","NO APLICA"]
    ]
  end

  def select_tipo_atencion
    [
      ["PERSONALIZADA","1"],
      ["TELEFONICA","2"],
      ["DOMICILIARIA","3"],
      ["OTRA","4"]
    ]
  end

  def select_tipo_atencionpqrs
    [
      ["PERSONALIZADA","1"],
      ["TELEFONICA","2"],
      ["DOMICILIARIA","3"],
      ["OTRA","4"],
      ["CIERRE PQRS","5"]
    ]
  end

  def select_calculo
    [
      ["SUBSIDIO","SUBSIDIO"],
      ["NO SUBSIDIO","NO SUBSIDIO"],
      ["SUBSIDIO-DIAGNOSTICO","SUBSIDIO-DIAGNOSTICO"],
      ["EJECUCION","EJECUCION"],
      ["SIN ADMINISTRACION","SIN ADMINISTRACION"],
      ["EJECUCION 2015-2016-2017","EJECUCION 2015"]
    ]
  end

	def select_useractivo
		return is_select_useractivo
	end

  def select_situacion
    [
      ["AGENDADA ","AGENDADA "],
      ["PENDIENTE","PENDIENTE"],
      ["NO APLICA","NO APLICA"]
    ]
  end

  def select_no_agenda
    [
      ["COMERCIO","COMERCIO"],
      ["CONFLICTO","CONFLICTO"],
      ["EXCEDE UNIDADES DE VIVIENDA","EXCEDE UNIDADES DE VIVIENDA"],
      ["FUE OBJETO DE MEJORAMIENTO ","FUE OBJETO DE MEJORAMIENTO "],
      ["NO TIENE ESCRITURA O TITULO","NO TIENE ESCRITURA O TITULO"],
      ["RECHAZA EL PROGRAMA","RECHAZA EL PROGRAMA"],
      ["SERVIDUMBRE NO CERTIFICADA ","SERVIDUMBRE NO CERTIFICADA "],
      ["SUCESION ","SUCESION "],
      ["SUPERA NIVELES","SUPERA NIVELES"],
      ["TRAMITE PARTICULAR","TRAMITE PARTICULAR"],
      ["VIVIENDA DEMOLIDA","VIVIENDA DEMOLIDA"]
    ]
  end

  def select_asigtemporal
    [
      ["VISITA DE RECOLECCION DE INFORMACION Y DOCUMENTOS","VISITA DE RECOLECCION DE INFORMACION Y DOCUMENTOS"],
      ["LEVANTAMIENTO ARQUITECTONICO","LEVANTAMIENTO ARQUITECTONICO"],
      ["ELABORACION DE PLANO ARQUITECTONICO","ELABORACION DE PLANO ARQUITECTONICO"],
      ["CALCULO Y REVISION ESTRUCTURAL Y GEOTECNICA DEL PROYECTO","CALCULO Y REVISION ESTRUCTURAL Y GEOTECNICA DEL PROYECTO"],
      ["ELABORACION PLANO ESTRUCTURAL","ELABORACION PLANO ESTRUCTURAL"],
      ["VISITA SOCIAL","VISITA SOCIAL"],
      ["ASIGNACION LIDER SOCIAL","ASIGNACION LIDER SOCIAL"],
      ["ASIGNACION PERITAJE TECNICO","ASIGNACION PERITAJE TECNICO"]
    ]
  end

  def select_entidadotorga
    [
      ["CCF CALDAS","CCF CALDAS"],
      ["COMFAMA","COMFAMA"],
      ["COMFAMILIAR CAMACOL","COMFAMILIAR CAMACOL"],
      ["COMFENALCO","COMFENALCO"],
      ["FIDUCIA","FIDUCIA"],
      ["FONVIVIENDA","FONVIVIENDA"],
      ["INCENDIO MORAVIA","INCENDIO MORAVIA"],
      ["ISVIMED","ISVIMED"],
      ["LA ISLA","LA ISLA"],
      ["PML","PML"],
      ["PUENTE AURES","PUENTE AURES"],
      ["PUI","PUI"]
    ]
  end
  
  def select_entidadadmin
    [
      ["COMFAMA","COMFAMA"],
      ["COMFENALCO","COMFENALCO"],
      ["COMFAMILIAR CAMACOL","COMFAMILIAR CAMACOL"]
    ]
  end

  def select_estadosubsidio
    [
      ["ASIGNADO CON APLICACION EN VG","ASIGNADO CON APLICACION EN VG"],
      ["ARRIENDO PARCIAL" ,"ARRIENDO PARCIAL"],
      ["ARRIENDO 100%" ,"ARRIENDO 100%"],
      ["COBRADO A SIN LEGALIZAR","COBRADO A SIN LEGALIZAR"],
      ["LEGALIZADO","LEGALIZADO"],
      ["PERDIDA DE VIGENCIA","PERDIDA DE VIGENCIA"],
      ["RENUNCIA","RENUNCIA"],
      ["RESTITUIDO","RESTITUIDO"],
      ["REVOCADO","REVOCADO"],
      ["SIN COBRO VIGENTE","SIN COBRO VIGENTE"],
      ["VIGENTE SIN COBRO","VIGENTE SIN COBRO"]
    ]
  end

  def select_tipocobro
    [
      ["COBRO ANTICIPADO CON POLIZA","COBRO ANTICIPADO CON POLIZA"],
      ["COBRO ANTICIPADO CON AVAL BANCARIO","COBRO ANTICIPADO CON AVAL BANCARIO"],
      ["CONTRAESCRITURA","CONTRAESCRITURA"],
      ["LEGALIZACION 20% FINAL","LEGALIZACION 20% FINAL"]
    ]
  end

  def select_encargo_tramite
    [
      ["CESION DE OBLIGACIONES URBANISTISCAS Y LEGALIZACION DE PROYECTOS","CESION DE OBLIGACIONES URBANISTISCAS Y LEGALIZACION DE PROYECTOS"],
      ["LOTES FUTURO DESARROLLO","LOTES FUTURO DESARROLLO"],
      ["ESCRITURACION VIVIENDA NUEVA","ESCRITURACION VIVIENDA NUEVA"],
      ["INMUEBLES PENDIENTES POR CLASIFICAR","INMUEBLES PENDIENTES POR CLASIFICAR"],
      ["PROCESO DE TRANSFERENCIA TERMINADO","PROCESO DE TRANSFERENCIA TERMINADO"],
      ["SANEAMIENTO CORVIDE","SANEAMIENTO CORVIDE"],
      ["TITULACION","TITULACION"],
      ["TRAMITE DE DESCARGUE","TRAMITE DE DESCARGUE"]
    ]
  end

  def select_motivo_no_agenda
    [
      ["AFECTACION","AFECTACION"],
      ["COMERCIO","COMERCIO"],
      ["CONFLICTO","CONFLICTO"],
      ["EXCEDE UNIDADES DE VIVIENDA","EXCEDE UNIDADES DE VIVIENDA"],
      ["FONDOS COMUNES","FONDOS COMUNES"],
      ["FUE OBJETO DE MEJORAMIENTO ","FUE OBJETO DE MEJORAMIENTO "],
      ["MAL TITULADO","MAL TITULADO"],
      ["MATERIALES NO CONVENCIONALES","MATERIALES NO CONVENCIONALES"],
      ["NO TIENE ESCRITURA O TITULO","NO TIENE ESCRITURA O TITULO"],
      ["OTROS","OTROS"],
      ["OTROS USOS","OTROS USOS"],
      ["RECHAZA EL PROGRAMA","RECHAZA EL PROGRAMA"],
      ["SERVIDUMBRE NO CERTIFICADA ","SERVIDUMBRE NO CERTIFICADA "],
      ["SUCESION ","SUCESION "],
      ["SUPERA NIVELES","SUPERA NIVELES"],
      ["TRAMITE PARTICULAR","TRAMITE PARTICULAR"],
      ["VIVIENDA DEMOLIDA","VIVIENDA DEMOLIDA"]
    ]
  end

  def select_motivo_fallida
    [
      ["AFECTACION","AFECTACION"],
      ["AUSENTE","AUSENTE"],
      ["COMERCIO","COMERCIO"],
      ["CONFLICTO","CONFLICTO"],
      ["EXCEDE UNIDADES DE VIVIENDA","EXCEDE UNIDADES DE VIVIENDA"],
      ["FONDOS COMUNES","FONDOS COMUNES"],
      ["FUE OBJETO DE MEJORAMIENTO","FUE OBJETO DE MEJORAMIENTO"],
      ["MAL TITULADO","MAL TITULADO"],
      ["MATERIALES NO CONVENCIONALES","MATERIALES NO CONVENCIONALES"],
      ["NO TIENE ESCRITURA O TITULO","NO TIENE ESCRITURA O TITULO"],
      ["OTROS","OTROS"],
      ["OTROS USOS","OTROS USOS"],
      ["RECHAZA EL PROGRAMA","RECHAZA EL PROGRAMA"],
      ["SERVIDUMBRE NO CERTIFICADA","SERVIDUMBRE NO CERTIFICADA"],
      ["SUCESION","SUCESION"],
      ["SUPERA NIVELES","SUPERA NIVELES"],
      ["TRAMITE PARTICULAR","TRAMITE PARTICULAR"],
      ["VIVIENDA DEMOLIDA","VIVIENDA DEMOLIDA"]
    ]
  end

  def select_situacion_levantamiento
    [
      ["EFECTIVA","EFECTIVA"],
      ["FALLIDA","FALLIDA"],
      ["PENDIENTE","PENDIENTE"]
    ]
  end

  def select_estado_visita
    [
      ["AGENDADA","AGENDADA"],
      ["NO APLICA","NO APLICA"],
      ["PENDIENTE","PENDIENTE"]
    ]
  end

  def select_tipo_visita
    [
      ["VISITA DE SOCIALIZACION","VISITA DE SOCIALIZACION"],
      ["VISITA DE LEVANTAMIENTO","VISITA DE LEVANTAMIENTO"]
    ]
  end

  def select_unidad_conservacion
    [
      ["CAJA","CAJA"],
      ["CARPETA","CARPETA"],
      ["TOMO","TOMO"],
      ["OTRO","OTRO"]
    ]
  end

  def select_tipo
    [
      ["SEDE CENTRAL","A"],
      ["SEDE 2","T"],
      ["SEDE 3","M"],
      ["UNIDAD PERMANENTE DE JUSTIFICA - UPJ","S"],
      ["CENTRAL DE INVERSIONES - CISA","C"],
      ["SECRETARIA DE HACIENDA","S"],
      ["ARRENDAMIENTO TEMPORAL","AR"],
      ["SAN LUIS","SL"]
    ]
  end

  def select_tipo1
    [
      ["SEDE 2","T"],
      ["SEDE 3","M"],
      ["SAN LUIS","SL"]
    ]
  end
  
  def select_plazo
    [  
      ["PLAZO","P"],
      ["PLAZO - VALOR","PV"],
      ["PLAZO - CLAUSULAS","PC"],
      ["PLAZO - VALOR - CLAUSULAS","PVC"],
      ["VALOR","V"],
      ["VALOR - CLAUSULAS","VC"],
      ["CLAUSULAS","C"]
    ]
  end

  def select_annos
    [
      ["2018","2018"],
      ["2017","2017"],
      ["2016","2016"],
      ["2015","2015"],
      ["2014","2014"],
      ["2013","2013"],
      ["2012","2012"],
      ["2011","2011"],
      ["2010","2010"],
      ["2009","2009"],
      ["2008","2008"],
      ["2007","2007"],
      ["2006","2006"]
    ]
  end

  def select_mes
    [ ["ENERO" , 1],
      ["FEBRERO", 2],
      ["MARZO", 3],
      ["ABRIL" , 4],
      ["MAYO" , 5],
      ["JUNIO" , 6],
      ["JULIO", 7],
      ["AGOSTO",8],
      ["SEPTIEMBRE" , 9],
      ["OCTUBRE" , 10],
      ["NOVIEMBRE" , 11],
      ["DICIEMBRE", 12]
    ]
  end

  def select_rangocalendar
    [2000,2019]
  end

  def select_tipovinculacion
    [
      ["LIBRE NOMBRAMIENTO Y REMOCION","LIBRE NOMBRAMIENTO Y REMOCION"],
      ["PROVISIONALIDAD","PROVISIONALIDAD"],
      ["PERIODO","PERIODO"]
    ]
  end

  def select_nivel
    [
      ["DIRECTIVO","DIRECTIVO"],
      ["ASESOR","ASESOR"],
      ["PROFESIONAL","PROFESIONAL"],
      ["TECNICO","TECNICO"],
      ["ASISTENCIAL","ASISTENCIAL"]
    ]
  end
  

  def select_causaldev
      [
        ["CERRADO","CERRADO"],
        ["DESCONOCIDO","DESCONOCIDO"],
        ["DIRECCION ERRADA","DIRECCION ERRADA"],
        ["FALLECIDO","FALLECIDO"],
        ["FUERZA MAYOR","FUERZA MAYOR"],
        ["NO EXISTE","NO EXISTE"],
        ["NO RECLAMADO","NO RECLAMADO"],
        ["NO RESIDE","NO RESIDE"],
        ["OTRO","OTRO"],
        ["REHUSADO","REHUSADO"]
      ]
  end
  
  def select_estadocorvide
      [
        ["DIAGNÓSTICO","DIAGNÓSTICO"],
        ["REPARTO NOTARIAL","REPARTO NOTARIAL"],
        ["ELABORACION DE MINUTA","ELABORACION DE MINUTA"],
        ["PROTOCOLIZACION","PROTOCOLIZACION"],
        ["EN REGISTRO","EN REGISTRO"],
        ["REGISTRADO","REGISTRADO"],
        ["CANCELACION DE HIPOTECAS","CANCELACION DE HIPOTECAS"]
      ]
  end

  def select_proyectocorvide
      [
        ["LIMONAR I Y II","LIMONAR I Y II"],
        ["MULTIFAMILIAR LUIS FERNANDO VELEZ","MULTIFAMILIAR LUIS FERNANDO VELEZ"],
        ["OTROS PROYECTOS Y VIVIENDA USADA","OTROS PROYECTOS Y VIVIENDA USADA"],
        ["URB. ALCAZAR DE SUCRE","URB. ALCAZAR DE SUCRE"],
        ["URB. ALTOS DE SAN JAVIER","URB. ALTOS DE SAN JAVIER"],
        ["URB. BRISAS DE SAN ANTONIO","URB. BRISAS DE SAN ANTONIO"],
        ["URB. LAS CARMELITAS","URB. LAS CARMELITAS"],
        ["URB. MULTIFAMILIARES LA IGUANA","URB. MULTIFAMILIARES LA IGUANA"],
        ["URB. PLAZA LINARES","URB. PLAZA LINARES"],
        ["URB. PORTÓN DE LIMONAR","URB. PORTÓN DE LIMONAR"],
        ["URB. SOL DE ORIENTE","URB. SOL DE ORIENTE"],
        ["KENNEDY LA JESUSITA","KENNEDY LA JESUSITA"],
        ["URB. PLAZA DEL RIO","URB. PLAZA DEL RIO"]
      ]
  end

  def select_estadosolicitud
      [
        ["PENDIENTE","PENDIENTE"],
        ["RECHAZADO","RECHAZADO"],
        ["ACEPTADO","ACEPTADO"],
        ["CANCELADO","CANCELADO"]
      ]
  end


  def select_fase2censosmatricula
      [
        ["1 - No tiene","1 - No tiene"],
        ["2 - Solo tiene posesion","2 - Solo tiene posesion"],
        ["3 - Es arrendatario y no tiene esa informacion","3 - Es arrendatario y no tiene esa informacion"],
        ["4 - Si tiene, pero no lo sabe","4 - Si tiene, pero no lo sabe"],
        ["5 - Si tiene, y lo sabe","5 - Si tiene, y lo sabe"],
        ["-98 - No sabe","-98 - No sabe"],
        ["-99 - No responde.","-99 - No responde."]
      ]
  end

  def select_fase2censosestrato
      [
        ["1 - Bajo bajo","1 - Bajo bajo"],
        ["2 - Bajo","2 - Bajo"],
        ["3 - Medio bajo","3 - Medio bajo"]
      ]
  end

  def select_fase2censosnegocio
      [
        ["1 - Propio","1 - Propio"],
        ["2 - Externo","2 - Externo"],
        ["-88 - No aplica.","-88 - No aplica."]
      ]
  end

  def select_fase2censosactnegocio
      [
        ["1 - Agropecuaria","1 - Agropecuaria"],
        ["3 - Electricidad gas, agua y alcantarillado","3 - Electricidad gas, agua y alcantarillado"],
        ["4 - Industria","4 - Industria"],
        ["5 - Construccion","5 - Construccion"],
        ["6 - Comercio, hotel, restaurantes","6 - Comercio, hotel, restaurantes"],
        ["7 - Transporte, almacenamiento y comunicaciones","7 - Transporte, almacenamiento y comunicaciones"],
        ["8 - Establecimiento financiero, bienes inmuebles y otros","8 - Establecimiento financiero, bienes inmuebles y otros"],
        ["9 - Servicios sociales, comunales y personales","9 - Servicios sociales, comunales y personales"],
        ["-88 - No aplica.","-88 - No aplica."]
      ]
  end

  def select_fase2censossinoaplica
      [
        ["1 - Si","1 - Si"],
        ["2 - No","2 - No"],
        ["-88 - No aplica","-88 - No aplica"]
      ]
  end

  def select_fase2censossino
      [
        ["1 - Si","1 - Si"],
        ["2 - No","2 - No"]
      ]
  end

  def select_fase2censotenencia
      [
        ["1 - En arriendo o subarriendo mensual","1 - En arriendo o subarriendo mensual"],
        ["2 - Propia, la estan pagando mensual","2 - Propia, la estan pagando mensual"],
        ["3 - Propia, totalmente pagada","3 - Propia, totalmente pagada"],
        ["4 - En usufructo","4 - En usufructo"],
        ["5 - Ocupante de hecho","5 - Ocupante de hecho"],
        ["6 - Anticresis","6 - Anticresis"]
      ]
  end

  def select_fase2censotipologia
      [
        ["1 - Rancho, vivienda de desechos","1 - Rancho, vivienda de desechos"],
        ["2 - Cuarto(s","2 - Cuarto(s"],
        ["3 - Cuarto en inquilinato","3 - Cuarto en inquilinato"],
        ["4 - Apartamento","4 - Apartamento"],
        ["5 - Casa","5 - Casa"]
      ]
  end

  def select_fase2censoestado
      [
        ["1 - Bueno","1 - Bueno"],
        ["2 - Regular","2 - Regular"],
        ["3 - Malo","3 - Malo"],
        ["4 - No Tiene","4 - No Tiene"],
        ["-88 - No aplica","-88 - No aplica"]
      ]
  end

  def select_fase2censocuartos
      [
        ["0","0"],
        ["1","1"],
        ["2","2"]
      ]
  end

  def select_fase2censosala
      [
        ["1 - Bueno","1 - Bueno"],
        ["2 - Regular","2 - Regular"],
        ["3 - Malo","3 - Malo"],
        ["4 - No Tiene","4 - No Tiene"]
      ]
  end

  def select_fase2censocompartido
      [
        ["0","0"],
        ["1","1"],
        ["2","2"],
        ["3","3"],
        ["4","4"],
        ["5","5"]
      ]
  end

  def select_fase2censootrouso
      [
        ["0","0"],
        ["1","1"],
        ["2","2"],
        ["3","3"],
        ["4","4"],
        ["5","5"],
        ["6","6"]
      ]
  end

  def select_fase2censoexclusivo
      [
        ["0","0"],
        ["1","1"],
        ["2","2"],
        ["3","3"],
        ["4","4"],
        ["5","5"],
        ["6","6"],
        ["7","7"],
        ["8","8"],
        ["9","9"]
      ]
   end

  def select_fase2censomaterial
      [
        ["1 - Materiales de desechos y otros (zinc, tela, lona,","1 - Materiales de desechos y otros (zinc, tela, lona,"],
        ["2 - Madera burda","2 - Madera burda"],
        ["3 - Bahareque sin revocar, guadua, cana, esterilla,","3 - Bahareque sin revocar, guadua, cana, esterilla,"],
        ["4 - Bahareque revocado","4 - Bahareque revocado"],
        ["5 - Tapia pisada","5 - Tapia pisada"],
        ["6 - Material prefabricado, dry wall, superboard","6 - Material prefabricado, dry wall, superboard"],
        ["7 - Ladrillo-bloque-adobe sin ranurar, sin revocar o sin revitar ","7 - Ladrillo-bloque-adobe sin ranurar, sin revocar o sin revitar "],
        ["8 - Bloque ranurado o revitado","8 - Bloque ranurado o revitado"],
        ["9 - Ladrillo ranurado o revitado","9 - Ladrillo ranurado o revitado"],
        ["10 - Ladrillo-bloque-adobe revocado o pintado","10 - Ladrillo-bloque-adobe revocado o pintado"],
        ["11 - Ladrillo-bloque forrado en piedra o madera","11 - Ladrillo-bloque forrado en piedra o madera"]
      ]
   end

  def select_fase2censoestadopared
      [
        ["1 - Bueno","1 - Bueno"],
        ["2 - Regular","2 - Regular"],
        ["3 - Malo","3 - Malo"]
      ]
   end

  def select_fase2censotecho
      [
        ["1 - No tiene posibilidad de tener losa","1 - No tiene posibilidad de tener losa"],
        ["2 - Tiene terraza y la quiere vender","2 - Tiene terraza y la quiere vender"],
        ["3 - Tiene terraza y no piensa vender","3 - Tiene terraza y no piensa vender"],
        ["4 - Si ha pensado construir terraza","4 - Si ha pensado construir terraza"],
        ["5 - Losa compartida","5 - Losa compartida"],
        ["-88 - No aplica","-88 - No aplica"]
      ]
   end

  def select_fase2censomaterialtecho
      [
        ["1 - Materiales de desechos y otros (tela, lona, carton, latas, desechos","1 - Materiales de desechos y otros (tela, lona, carton, latas, desechos"],
        ["2 - Madera","2 - Madera"],
        ["3 - Losa techo en concreto","3 - Losa techo en concreto"],
        ["4 - Plastico o acrilicos","4 - Plastico o acrilicos"],
        ["5 - Metalica Lamina de Zinc","5 - Metalica Lamina de Zinc"],
        ["6 - Prefabricados","6 - Prefabricados"],
        ["7 - Otros","7 - Otros"]
      ]
   end

  def select_fase2censootro
      [
        ["CAÑA BRAVA(TEJA BARRO","CAÑA BRAVA(TEJA BARRO"],
        ["ETERNIT","ETERNIT"],
        ["1 - Eternit","1 - Eternit"],
        ["2 - Cana Brava (Teja Barro","2 - Cana Brava (Teja Barro"],
        ["3 - Tejalit","3 - Tejalit"],
        ["4 - Termoacustica","4 - Termoacustica"],
        ["-88 - No aplica","-88 - No aplica"]
      ]
   end

  def select_fase2censomaterialpiso
      [
        ["1 - Tierra o arena","1 - Tierra o arena"],
        ["2 - Madera burda, tabla, tablon u otro vegetal","2 - Madera burda, tabla, tablon u otro vegetal"],
        ["3 - Cemento o gravilla","3 - Cemento o gravilla"],
        ["4 - Baldosa, vinilo, tableta o ladrillo","4 - Baldosa, vinilo, tableta o ladrillo"],
        ["5 - Marmol","5 - Marmol"],
        ["6 - Madera pulida y lacada, parque, cristal","6 - Madera pulida y lacada, parque, cristal"],
        ["7 - Alfombra o tapete de pared a pared","7 - Alfombra o tapete de pared a pared"]
      ]
   end

  def select_fase2censoalimentacion
      [
        ["1 - En un cuarto solo para cocinar","1 - En un cuarto solo para cocinar"],
        ["2 - En un cuarto usado tambien para dormir","2 - En un cuarto usado tambien para dormir"],
        ["3 - En una sala comedor con lavaplatos","3 - En una sala comedor con lavaplatos"],
        ["4 - En una sala comedor sin lavaplatos","4 - En una sala comedor sin lavaplatos"],
        ["5 - En un patio, corredor, enramada o al aire libre","5 - En un patio, corredor, enramada o al aire libre"],
        ["6 - En ninguna parte, no preparan alimentos","6 - En ninguna parte, no preparan alimentos"]
      ]
   end

  def select_fase2censoenchapecocina
      [
        ["1","1"],
        ["2","2"]
      ]
  end

  def select_fase2censoelectrica
      [
        ["1 - Definitivas","1 - Definitivas"],
        ["2 - Provisionales: malas (sueltos y/o anadidos","2 - Provisionales: malas (sueltos y/o anadidos"],
        ["3 - Provisionales: aceptables (canaletas","3 - Provisionales: aceptables (canaletas"]
      ]
  end

  def select_fase2censoserviciosanitario
      [
        ["1 - No tiene","1 - No tiene"],
        ["2 - Bajamar","2 - Bajamar"],
        ["3 - Letrina","3 - Letrina"],
        ["4 - Inodoro sin conexion a alcantarillado o pozo septico","4 - Inodoro sin conexion a alcantarillado o pozo septico"],
        ["5 - Inodoro conectado a pozo septico","5 - Inodoro conectado a pozo septico"],
        ["6 - Inodoro conectado a alcantarillado","6 - Inodoro conectado a alcantarillado"],
        ["7 - Inodoro conectado a alcantarillado pero no Regulado (quebrada o rio","7 - Inodoro conectado a alcantarillado pero no Regulado (quebrada o rio"]
      ]
  end

  def select_fase2censoimplementos
    [
      ["0","0"],
      ["1","1"],
      ["2","2"],
      ["3","3"]
    ]
  end

  def select_fase2censodagrd
    [
      ["1 - Evacuacion temporal","1 - Evacuacion temporal"],
      ["2 - Deterioro estructural","2 - Deterioro estructural"],
      ["-88","-88"]
    ]
  end

  def select_comunaespecial
    return is_select_comunaespecial
  end

  def select_barrios
    return is_select_barrios
  end
  

   def select_arriendonucleo
    [
      ["INDOCUMENTADO","INDOCUMENTADO"],
      ["COMPLETA","COMPLETA"],
      ["INCOMPLETA","INCOMPLETA"],
      ["SIN DOCUMENTOS","SIN DOCUMENTOS"],
      ["COMPLETA EN TRAMITE","COMPLETA EN TRAMITE"]
    ]
  end

   def select_arriendoatencion
    [
      ["CONTRATO","CONTRATO"],
      ["INACTIVO","INACTIVO"],
      ["ZR NO APTA","ZR NO APTA"],
      ["NOTIFICADO CON CRUCE","NOTIFICADO CON CRUCE"],
      ["CAMBIO DE VIVIENDA","CAMBIO DE VIVIENDA"],
      ["NO LE ALQUILAN","NO LE ALQUILAN"],
      ["CONTRATO CANCELADO","CONTRATO CANCELADO"],
      ["REMITIDO CON CRUCE","REMITIDO CON CRUCE"],
      ["CONTRATO - CAMBIO DE VIVIENDA","CONTRATO - CAMBIO DE VIVIENDA"],
      ["INVIABLE","INVIABLE"],
      ["NOTIFICADO","NOTIFICADO"],
      ["TRAMITE","TRAMITE"],
      ["IMPEDIMENTO PARA ACCEDER AL PROGRAMA","IMPEDIMENTO PARA ACCEDER AL PROGRAMA"],
      ["REMITIDO","REMITIDO"],
      ["ACTA DE NO ACEPTACION","ACTA DE NO ACEPTACION"],
      ["NO TOMA LA VIVIENDA","NO TOMA LA VIVIENDA"],
      ["COLOMBIA HUMANITARIA","COLOMBIA HUMANITARIA"],
      ["INACTIVO CON CRUCE","INACTIVO CON CRUCE"]
    ]
  end

  def select_arriendofasehumanitaria
    [
      ["FASE 1","FASE 1"],
      ["FASE 2","FASE 2"],
      ["FASE 1 Y 2","FASE 1 Y 2"],
      ["NO APLICA","NO APLICA"]
    ]
  end

  def select_arriendomejoramiento
    [
      ["EN PROCESO","EN PROCESO"],
      ["FINALIZADO","FINALIZADO"],
      ["NO APLICA","NO APLICA"],
      ["NO CUMPLE REQUISITOS","NO CUMPLE REQUISITOS"],
      ["RECOMENDADO","RECOMENDADO"]
    ]
  end

  def select_arriendocategoria
    [
      ["ACCION POPULAR","ACCION POPULAR"],
      ["CINTURON VERDE","CINTURON VERDE"],
      ["EDU","EDU"],
      ["EDU - OPV","EDU - OPV"],
      ["EVACUACIONES PREVENTIVAS","EVACUACIONES PREVENTIVAS"],
      ["EXPROPIACION DE MORAVIA","EXPROPIACION DE MORAVIA"],
      ["HACIENDA","HACIENDA"],
      ["ISVIMED ESPECIAL","ISVIMED ESPECIAL"],
      ["JARDIN CIRCUNVALAR EDU","JARDIN CIRCUNVALAR EDU"],
      ["MIB","MIB"],
      ["MOSCU ESPECIAL","MOSCU ESPECIAL"],
      ["OBRAPUBLICA","OBRAPUBLICA"],
      ["PREVENCION POR RIESGO","PREVENCION POR RIESGO"],
      ["PRINCIPALES EVENTOS","PRINCIPALES EVENTOS"],
      ["REASENTAMIENTO IGUANA","REASENTAMIENTO IGUANA"],
      ["REASENTAMIENTO MORAVIA","REASENTAMIENTO MORAVIA"],
      ["SIN ASIGNAR","SIN ASIGNAR"],
      ["TRANVIA","TRANVIA"],
      ["TUTELAS","TUTELAS"]
    ]
  end



  def select_arriendotiposubsidio
    [
      ["LOTE","LOTE"],["ARRIENDO","ARRIENDO"],
      ["VIVIENDA","VIVIENDA"],
      ["MEJORAMIENTO DE VIVIENDA","MEJORAMIENTO DE VIVIENDA"],
      ["VIVIENDA USADA","VIVIENDA USADA"],
      ["MEJORAMIENTO","MEJORAMIENTO"]
    ]
  end

  def select_arriendoentidadsubsidio
    [
       ["BANCO DE BOGOTA","BANCO DE BOGOTA"],
       ["CODEVI","CODEVI"],
       ["COMFAMA","COMFAMA"],
       ["COMFENALCO","COMFENALCO"],
       ["CORVIDE","CORVIDE"],
       ["CORVIVE","CORVIVE"],
       ["CREDITO TERRITORIAL","CREDITO TERRITORIAL"],
       ["FONVIVIENDA","FONVIVIENDA"],
       ["INURBE","INURBE"],
       ["ISVIMED","ISVIMED"]
    ]
  end

  def select_arriendoresidencia
    [
      ["RESIDENCIA CON NEGOCIO","RESIDENCIA CON NEGOCIO"],
      ["RESIDENCIA","RESIDENCIA"],
      ["NEGOCIO","NEGOCIO"]
    ]
  end

  def select_arriendotiemporn
    [
      ["00 SIN DEFINIR","00 SIN DEFINIR"],
      ["01 ANOS","01 ANOS"],
      ["01 AOS","01 AOS"],
      ["02 MESES","02 MESES"]
    ]
  end

  def select_arriendootrodestino
    [
      ["0","0"],
      ["1","1"],
      ["2","2"],
      ["3","3"],
      ["4","4"],
      ["5","5"]
    ]
  end

  def select_arriendoingresos
    [
      ["$0 - $50,000","$0 - $50,000"],
      ["$51,000 - $100,000","$51,000 - $100,000"],
      ["$101,000 - $200,000","$101,000 - $200,000"],
      ["$201,000 - $300,000","$201,000 - $300,000"],
      ["$301,000 - $400,000","$301,000 - $400,000"],
      ["$401,000 - $500,000","$401,000 - $500,000"],
      ["$501,000 - $600,000","$501,000 - $600,000"],
      ["$601,000 - $700,000","$601,000 - $700,000"],
      ["$701,000 - $800,000","$701,000 - $800,000"],
      ["$801,000 - $900,000","$801,000 - $900,000"],
      ["$901,000 - $1,000,000","$901,000 - $1,000,000"],
      ["MAS DE 1 MILLON","MAS DE 1 MILLON"]
    ]
  end

  def select_eventos
       [
        ["INVADIDA/POSESION", "INVADIDA/POSESION"],
        ["INVADIDA","INVADIDA"],
        ["PRESTADA","PRESTADA"],
        ["PROPIA/POSESION","PROPIA/POSESION"],
        ["PROPIETARIO RENTISTA", "PROPIETARIO RENTISTA"],
        ["ALQUILADA", "ALQUILADA"],
        ["NO ACCESIBLE", "NO ACCESIBLE"]
       ]
    end

    def select_riesgoasociado
      [
        ["ALTO", "ALTO"],
        ["MEDIO", "MEDIO"],
        ["BAJO", "BAJO"]
      ]
    end

    def select_mespagado
     [
       ["ENERO" , "ENERO"],
       ["FEBRERO", "FEBRERO"],
       ["MARZO", "MARZO"],
       ["ABRIL" ,"ABRIL"],
       ["MAYO" , "MAYO"],
       ["JUNIO" , "JUNIO"],
       ["JULIO", "JULIO"],
       ["AGOSTO","AGOSTO"],
       ["SEPTIEMBRE" , "SEPTIEMBRE"],
       ["OCTUBRE" , "OCTUBRE"],
       ["NOVIEMBRE" ,"NOVIEMBRE"],
       ["DICIEMBRE", "DICIEMBRE"]
     ]
  end

  def select_estadopago
   [
     ["PENDIENTE" , "PENDIENTE"],
     ["PAGADO", "PAGADO"],
     ["ANULADO", "ANULADO"],
     ["NO APLICA", "NO APLICA"]
   ]
  end

  def select_tiponovedad
   [
      ["SIN SELECCIONAR", "SIN SELECCIONAR"],
      ["DERIVACION", "DERIVACION"],
      ["CONTRATO PRIMERA VEZ", "CONTRATO PRIMERA VEZ"],
      ["CAMBIO VIVIENDA", "CAMBIO VIVIENDA"],
      ["EVENTUALIDAD", "EVENTUALIDAD"],
      ["SOLICITUD DE CAMBIO", "SOLICITUD DE CAMBIO"]
   ]
  end

  def select_prioridad
    [
      ["ALTA", "ALTA"],
      ["BAJA", "BAJA"],
      ["URGENTE", "URGENTE"],
      ["NORMAL", "NORMAL"]
    ]
  end

  def select_tipoderivada
    [
       ["CONTRATO","CONTRATO"],
       ["EVENTUALIDAD","EVENTUALIDAD"],
       ["SIN SELECCIONAR","SIN SELECCIONAR"],
       ["VISITA ACTA DE ENTREGA","VISITA ACTA DE ENTREGA"],
       ["VISITA ACTA DE NO ACEPTACION","VISITA ACTA DE NO ACEPTACION"],
       ["VISITA DE NOTIFICACION","VISITA DE NOTIFICACION"],
       ["VISITA SEGUIMIENTO TECNICO","VISITA SEGUIMIENTO TECNICO"],
       ["VISITA SOCIAL","VISITA SOCIAL"],
       ["VISITA VERIFICACION","VISITA VERIFICACION"],
       ["VISITA VIABILIDAD","VISITA VIABILIDAD"]
    ]
  end

  def select_estadoatencion
    [
      ["CONTRATO", "CONTRATO"],
      ["SIN ASIGNAR", "SIN ASIGNAR"],
      ["NO LE ALQUILAN", "NO LE ALQUILAN"],
      ["ZR NO APTO", "ZR NO APTO"],
      ["COLOMBIA HUMANITARIA", "COLOMBIA HUMANITARIA"],
      ["INVIABLE JURIDICAMENTE", "INVIABLE JURIDICAMENTE"],
      ["PENDIENTE DE CONTRATO", "PENDIENTE DE CONTRATO"],
      ["CONTRATO CANCELADO", "CONTRATO CANCELADO"],
      ["EN TRAMITE ZR", "EN TRAMITE ZR"],
      ["INVIABLE TECNICAMENTE", "INVIABLE TECNICAMENTE"],
      ["EN TECNICA", "EN TECNICA"],
      ["EN JURIDICA", "EN JURIDICA"]
    ]
  end

  def select_viabilidad
    [
      ["VIABLE", "VIABLE"],
      ["SIN DEFINIR", "SIN DEFINIR"],
      ["INVIABLE", "INVIABLE"]
    ]
  end

  def select_zonariesgo
    [
      ["NO APTO", "NO APTO"],
      ["APTO", "APTO"],
      ["EN TRAMITE", "EN TRAMITE"]
    ]
  end

  def select_indicadorproceso
    [
      ["GESTION ADMINISTRATIVA Y FINANCIERA", "GESTION ADMINISTRATIVA Y FINANCIERA"],
      ["GESTION DE INFRAESTRUCTURA", "GESTION DE INFRAESTRUCTURA"],
      ["GESTION DE LAS TICS", "GESTION DE LAS TICS"],
      ["GESTION HUMANA", "GESTION HUMANA"],
      ["GESTION JURIDICA", "GESTION JURIDICA"],
      ["GESTION DOCUMENTAL", "GESTION DOCUMENTAL"],
      ["GESTION DE COMUNICACIONES", "GESTION DE COMUNICACIONES"],
      ["GESTION DE EVALUACION Y MEJORA CONTINUA", "GESTION DE EVALUACION Y MEJORA CONTINUA"],
      ["GESTION ESTRATEGICA", "GESTION ESTRATEGICA"],
      ["GESTION DE ATENCION AL USUARIO", "GESTION DE ATENCION AL USUARIO"],
      ["GESTION DE DESARROLLO DE SOLUCIONES HABITACIONALES", "GESTION DE DESARROLLO DE SOLUCIONES HABITACIONALES"],
      ["GESTION SOCIAL", "GESTION SOCIAL"]
    ]
  end

  def select_indicadortipologia
    [
      ["EFECTIVIDAD", "EFECTIVIDAD"],
      ["EFICIENCIA", "EFICIENCIA"],
      ["EFICACIA", "EFICACIA"]
    ]
  end

  def select_indicadorcredev
    [
      ["CRECIENTE", "CRECIENTE"],
      ["DECRECIENTE", "DECRECIENTE"],
      ["CONSTANTE", "CONSTANTE"]
    ]
  end

  def select_indicadormedicion
    [
      ["MENSUAL", "MENSUAL"],
      ["BIMENSUAL", "BIMENSUAL"],
      ["TRIMESTRAL", "TRIMESTRAL"],
      ["SEMESTRAL", "SEMESTRAL"],
      ["ANUAL", "ANUAL"],
      ["BIANUAL", "BIANUAL"]
    ]
  end

  def select_indicadorsentido
    [
      ["POSITIVO", "POSITIVO"],
      ["NEGATIVO", "NEGATIVO"]
    ]
  end

  def select_indicadortipo
    [
      ["IMPACTO", "IMPACTO"],
      ["RESULTADO", "RESULTADO"],
      ["PRODUCTO", "PRODUCTO"],
      ["GESTION", "GESTION"]
    ]
  end

  def select_indicadorcontrolcambio
    [
      ["Proceso", "Proceso"],
      ["Código Indicador", "Código Indicador"],
      ["Nombre indicador", "Nombre indicador"],
      ["Definición del indicador", "Definición del indicador"],
      ["Objetivo del indicador", "Objetivo del indicador"],
      ["Dimensión Plan de Desarrollo 2016-2019", "Dimensión Plan de Desarrollo 2016-2019"],
      ["Sector", "Sector"],
      ["Entidad o dependencia responsable del cálculo del indicador", "Entidad o dependencia responsable del cálculo del indicador"],
      ["Persona responsable del dato", "Persona responsable del dato"],
      ["Persona responsable del reporte", "Persona responsable del reporte"],
      ["Marco normativo en el cual se sustenta el indicador", "Marco normativo en el cual se sustenta el indicador"],
      ["Palabras Clave", "Palabras Clave"],
      ["Comportamiento deseado del indicador", "Comportamiento deseado del indicador"],
      ["Sentido del indicador", "Sentido del indicador"],
      ["Unidad de medida", "Unidad de medida"],
      ["Fórmula de Cálculo", "Fórmula de Cálculo"],
      ["Variables que componen la fórmula V1", "Variables que componen la fórmula V1"],
      ["Variables que componen la fórmula V2", "Variables que componen la fórmula V2"],
      ["Restricciones de los datos", "Restricciones de los datos"],
      ["Referencias bibliográficas - Cibergráficas", "Referencias bibliográficas - Cibergráficas"],
      ["Interpretación", "Interpretación"],
      ["Fecha de concertación del indicador", "Fecha de concertación del indicador"],
      ["Medición", "Medición"],
      ["Límite de control", "Límite de control"],
      ["Meta", "Meta"],
      ["Tipo de Indicador", "Tipo de Indicador"],
      ["Categorías de desagragación del Indicador", "Categorías de desagragación del Indicador"],
      ["Ámbito de desagregación territorial", "Ámbito de desagregación territorial"],
      ["Ámbito de desagregación poblacional", "Ámbito de desagregación poblacional"],
      ["Otras categorías de desagregación del indicador", "Otras categorías de desagregación del indicador"],
      ["Periodicidad de generación del indicador", "Periodicidad de generación del indicador"]
    ]
  end

  def select_memorandotipodocto
    [
      ["SOLICITUD DE INFORMACION Y/O APOYO", "SOLICITUD DE INFORMACION Y/O APOYO"],
      ["INFORMACION GENERAL", "INFORMACION GENERAL"],
      ["OTROS", "OTROS"]
    ]
  end

  def select_unidaddemedida
    [
      ["NUMERO", "NUMERO"],
      ["PORCENTAJE", "PORCENTAJE"],
      ["DIAS", "DIAS"]
    ]
  end

  def select_sector
    [
      ["AMPLIACION AVENIDA 34 TRAMO 3","AMPLIACION AVENIDA 34 TRAMO 3"],
      ["AMPLIACION CALLE 4 SUR","AMPLIACION CALLE 4 SUR"],
      ["BERMEJALA","BERMEJALA"],
      ["BELENCITO CORAZON","BELENCITO CORAZON"],
      ["CEDEZO","CEDEZO"],
      ["CENTRO SALUD","CENTRO SALUD"],
      ["CHISPERO","CHISPERO"],
      ["COLON","COLON"],
      ["EDIFICIO 11","EDIFICIO 11"],
      ["EDIFICIO 12","EDIFICIO 12"],
      ["EDIFICIO 36","EDIFICIO 36"],
      ["EDIFICIO 39","EDIFICIO 39"],
      ["EDIFICIO 40","EDIFICIO 40"],
      ["EDIFICIO 68","EDIFICIO 68"],
      ["EL BOSQUE","EL BOSQUE"],
      ["EL JARDIN","EL JARDIN"],
      ["EL PORVENIR Y VALLEJUELOS","EL PORVENIR Y VALLEJUELOS"],
      ["EL SOCORRO","EL SOCORRO"],
      ["HERRADURA","HERRADURA"],
      ["ISLA DE LA FANTASIA","ISLA DE LA FANTASIA"],
      ["ITAGUI","ITAGUI"],
      ["INDEPENDENCIAS I","INDEPENDENCIAS I"],
      ["INDEPENDENCIAS II","INDEPENDENCIAS II"],
      ["LA 34","LA 34"],
      ["LA ALGODONERA","LA ALGODONERA"],
      ["LA CRUZ","LA CRUZ"],
      ["LA ESTRELLA","LA ESTRELLA"],
      ["LA PLAYITA","LA PLAYITA"],
      ["LA PLAYITA Y CHORROS","LA PLAYITA Y CHORROS"],
      ["LAS PALMAS","LAS PALMAS"],
      ["LATERAL NORTE QUEBRADA ZUNIGA","LATERAL NORTE QUEBRADA ZUNIGA"],
      ["LOMA LOS PARRA AVENIDA 34 Y CARRERA 43 A","LOMA LOS PARRA AVENIDA 34 Y CARRERA 43 A"],
      ["LOS BALSOS","LOS BALSOS"],
      ["LOS MANGOS","LOS MANGOS"],
      ["LOS MANGOS","LOS MANGOS"],
      ["MASAVIELLE","MASAVIELLE"],
      ["MORAVIA","MORAVIA"],
      ["MORRO","MORRO"],
      ["OASIS","OASIS"],
      ["OASIS CALAMIDAD","OASIS CALAMIDAD"],
      ["OLAYA1 Y OLAYA2","OLAYA1 Y OLAYA2"],
      ["PALERMO","PALERMO"],
      ["PASO DESNIVEL CARRETERA TESORO VIA LINARES","PASO DESNIVEL CARRETERA TESORO VIA LINARES"],
      ["PASO DESNIVEL DE LA TRANSVERSAL INFERIOR CON LA LOMA DE LOS PARRA","PASO DESNIVEL DE LA TRANSVERSAL INFERIOR CON LA LOMA DE LOS PARRA"],
      ["PASO DESNIVEL DE LA TRANSVERSAL INFERIOR CON LOMA DE LOS GONZALEZ","PASO DESNIVEL DE LA TRANSVERSAL INFERIOR CON LOMA DE LOS GONZALEZ"],
      ["PASO DESNIVEL TRANSVERSAL SUPERIO CON CALLE 10","PASO DESNIVEL TRANSVERSAL SUPERIO CON CALLE 10"],
      ["PROLONGACION CARRERA 15","PROLONGACION CARRERA 15"],
      ["PROLONGACION CARRERA 37 A HASTA LAS PALMAS","PROLONGACION CARRERA 37 A HASTA LAS PALMAS"],
      ["PROLONGACION LOMA LOS PARRA AVENIDA POBLADO-AVENIDA LAS VEGAS","PROLONGACION LOMA LOS PARRA AVENIDA POBLADO-AVENIDA LAS VEGAS"],
      ["PROLONGACION LOMA LOS PARRA INFERIOR HASTA LA 29D","PROLONGACION LOMA LOS PARRA INFERIOR HASTA LA 29D"],
      ["SABANETA","SABANETA"],
      ["SAN DIEGO","SAN DIEGO"],
      ["VEINTE DE JULIO","VEINTE DE JULIO"],
      ["DOCE DE OCTUBRE","DOCE DE OCTUBRE"],
      ["PICACHO","PICACHO"],
      ["ROBLEDO ALTO","ROBLEDO ALTO"],
      ["SAN LUIS","SAN LUIS"],
      ["LA PARALELA","LA PARALELA"],
      ["HECTOR ABAD","HECTOR ABAD"]
    ]
  end

  def select_tenencia
    [
      ["POSEEDOR","POSEEDOR"],
      ["MERO TENEDOR","MERO TENEDOR"],
      ["PROPIETARIO","PROPIETARIO"],
      ["NO PROPIETARIO","NO PROPIETARIO"],
      ["ARRENDATARIO","ARRENDATARIO"],
      ["POSEEDOR RENTISTA","POSEEDOR RENTISTA"],
      ["PROPIETARIO RENTISTA","PROPIETARIO RENTISTA"],
      ["PRESTADA","PRESTADA"],
      ["INVADIDA","INVADIDA"]
    ]
  end

  def select_sinoespecial
    [
      ["SI","S"],
      ["NO","N"]
    ]    
  end

  def select_sinoespecial2
    [
      ["SI","S"],
      ["NO","N"],
      ["NO APLICA","NA"],
    ]    
  end  

 def select_opc_viviendas
    [ 
     ["CANTARES", "CANTARES"],
     ["AURORA", "AURORA"],
     ["CHAGUALON", "CHAGUALON"],
     ["HUERTA", "HUERTA"],
     ["MONTANA", "MONTANA"],
     ["NAZARET", "NAZARET"],
     ["TIROL", "TIROL"],
     ["CASCADA", "CASCADA"],
     ["VIVIENDA USADA", "VIVIENDA USADA"],
     ["VIVIENDA NUEVA", "VIVIENDA NUEVA"],
     ["NEGOCIACION DIRECTA", "NEGOCIACION DIRECTA"],
     ["SIN DEFINIR OPCION", "SIN DEFINIR OPCION"],
     ["ALAMOS I", "ALAMOS I"],
     ["ALAMOS II", "ALAMOS II"],
     ["HERRADURA III", "HERRADURA III"],
     ["HUERTA III", "HUERTA III"],
     ["MIRADOR DE MORAVIA", "MIRADOR DE MORAVIA"]
    ]
  end

 def select_tipo_solucion
    [ 
     ["VIVIENDA USADA", "VIVIENDA USADA"],
     ["VIVIENDA NUEVA", "VIVIENDA NUEVA"]
    ]
  end

  def select_est_vivienda
    [
     ["SOLICITUD AVALUO", "SOLICITUD AVALUO"],
     ["ASIGNACION DE SUBSIDIO", "ASIGNACION DE SUBSIDIO"],
     ["ESCRITURACION", "ESCRITURACION"],
     ["PAGOS", "PAGOS"],
     ["SOLICITUD CERTIFICADO DE RIESGO", "SOLICITUD CERTIFICADO DE RIESGO"],
     ["REMISION BANCO INMOBILIARIO", "REMISION BANCO INMOBILIARIO"],
     ["SIN DEFINIR OPCION", "SIN DEFINIR OPCION"],
     ["CIERRE FINANCIERO", "CIERRE FINANCIERO"],
     ["POSTULACION", "POSTULACION"],
     ["REGISTRADA", "REGISTRADA"],
     ["PROCESO FINALIZADO", "PROCESO FINALIZADO"],
     ["REASENTADO", "REASENTADO"],
     ["RECEPCION DE DOCUMENTOS", "RECEPCION DE DOCUMENTOS"],
     ["ESTUDIO DE TITULOS", "ESTUDIO DE TITULOS"]
   ]
  end

  def select_iguanaproyconsolidado
    [["IGUANA","IGUANA"],
     ["MORAVIA","MORAVIA"],
     ["LOTES DE OPORTUNIDAD MORAVIA","LOTES DE OPORTUNIDAD MORAVIA"],
     ["AMVA INTERCAMBIO VIAL","AMVA INTERCAMBIO VIAL"],
     ["IGUANA DOS","IGUANA DOS"],
     ["PHC SANTO DOMINGO","PHC SANTO DOMINGO"],
     ["HABITAT EL SOCORRO","HABITAT EL SOCORRO"],
     ["HABITAT LA CRUZ","HABITAT LA CRUZ"],
     ["HIJOS DE MORAVIA","HIJOS DE MORAVIA"],
     ["PLAN SAN LORENZO","PLAN SAN LORENZO"],
     ["FONVALMED","FONVALMED"],
     ["LA PLAYITA - BELEN AGUASFRIAS","LA PLAYITA - BELEN AGUASFRIAS"],
     ["LINARES VIA AL TESORO","LINARES VIA AL TESORO"],
     ["IGUANA - PUENTE MADRE LAURA","IGUANA - PUENTE MADRE LAURA"],
     ["DESASTRE- MORAVIA- EDU VIEJOS","DESASTRE- MORAVIA- EDU VIEJOS"],
     ["CONECTIVIDADES - CONEXION ABURRA RIO CAUCA","CONECTIVIDADES - CONEXION ABURRA RIO CAUCA"],
     ["JARDIN INFANTIL LORETO","JARDIN INFANTIL LORETO"],
     ["PARQUE AMBIENTAL LA ISLA","PARQUE AMBIENTAL LA ISLA"]
   ]
  end

  def select_iguanapagos
    [
     ["IGUANA","IGUANA"],
     ["MORAVIA","MORAVIA"]
   ]
  end

  def select_clase
    [
     ["ADQUISICION","ADQUISICION"],
     ["OBRAPUBLICA","OBRAPUBLICA"],
     ["SANLUIS","SANLUIS"],
     ["INFRAESTRUCTURA DE TRANSPORTE","CABLEPICACHO"]
   ]
  end
 
  def select_iguanaproyectos
      [
        ["CABLE PICACHO","CABLE PICACHO"],
        ["ADQUISICION - SAN LUIS","ADQUISICION - SAN LUIS"],
        ["AMVA INTERCAMBIO VIAL","AMVA INTERCAMBIO VIAL"],
        ["CONECTIVIDADES-CONEXIÓN VIAL ABURRA RIO-CAUCA","CONECTIVIDADES-CONEXIÓN VIAL ABURRA RIO-CAUCA"],
        ["CONECTIVIDADES-CONEXIÓN VIAL NORTE","CONECTIVIDADES-CONEXIÓN VIAL NORTE"],
        ["DESASTRE- MORAVIA- EDU VIEJOS","DESASTRE- MORAVIA- EDU VIEJOS"],
        ["EDU HISTORICOS","EDU HISTORICOS"],
        ["FONVALMED","FONVALMED"],
        ["HÁBITAT EL SOCORRO","HÁBITAT EL SOCORRO"],
        ["HÁBITAT LA CRUZ","HÁBITAT LA CRUZ"],
        ["HIJOS DE MORAVIA","HIJOS DE MORAVIA"],
        ["IGUANA","IGUANA"],
        ["IGUANA DOS","IGUANA DOS"],
        ["JARDIN INFANTIL LORETTO","JARDIN INFANTIL LORETTO"],
        ["LA PLAYITA - BELEN AGUASFRIAS","LA PLAYITA - BELEN AGUASFRIAS"],
        ["LINARES VIA AL TESORO","LINARES VIA AL TESORO"],
        ["LOTES DE OPORTUNIDAD MORAVIA","LOTES DE OPORTUNIDAD MORAVIA"],
        ["MEJORAS VEGETALES-LOTE CASTILLA","MEJORAS VEGETALES-LOTE CASTILLA"],
        ["MORAVIA","MORAVIA"],
        ["PARQUE AMBIENTAL LA ISLA","PARQUE AMBIENTAL LA ISLA"],
        ["PHC SANTO DOMINGO","PHC SANTO DOMINGO"],
        ["PLAN SAN LORENZO","PLAN SAN LORENZO"],
        ["PUENTE AURES","PUENTE AURES"],
        ["PUENTE MADRE LAURA","PUENTE MADRE LAURA"],
        ["PUI COMUNA 13","PUI COMUNA 13"],
        ["PUI NOROCCIDENTAL","PUI NOROCCIDENTAL"],
        ["TRANVIA","TRANVIA"]
      ]
  end
 

  def select_iguanaresultado
    [
      ["SUBIO","S"],
      ["BAJO","B"],
      ["RATIFICADO","R"]
    ]
  end

  def select_iguanatratamiento
    [
      ["NEGOCIACION DIRECTA","N"],
      ["POSEEDOR","P"],
      ["RENTISTA","R"],
      ["UNIPERSONAL","U"]
    ]
  end

  def select_pendientesestado
    [ 
     ["FINALIZADO", "FINALIZADO"],
     ["PENDIENTE", "PENDIENTE"],
     ["EN TRAMITE", "EN TRAMITE"]
    ]
  end 

  def select_estadocuraduria
    [ 
     ["SIN INGRESAR", "SIN INGRESAR"],      
     ["RADICADO", "RADICADO"],
     ["ACTA DE OBSERVACION", "ACTA DE OBSERVACION"],
     ["DESISTIDO", "DESISTIDO"],
     ["LICENCIA DE APROBACION", "LICENCIA DE APROBACION"],
     ["RESOLUCION", "RESOLUCION"]
    ]    
  end

  def select_propietarioslocales
    [ 
     ["MUNICIPIO", "MUNICIPIO"],
     ["FIDEICOMISOS MIRADOR DE LA HUERTA", "FIDEICOMISOS MIRADOR DE LA HUERTA"],
     ["FIDEICOMISO LA CASCADA", "FIDEICOMISO LA CASCADA"],
     ["ISVIMED", "ISVIMED"],
     ["PARTICULARES", "PARTICULARES"]
    ]
  end

   def select_proyectoslocales
    [ 
     ["LA CRUZ","LA CRUZ"],
     ["HERRERA","HERRERA"],
     ["HERRADURA","HERRADURA"],
     ["LIMONAR","LIMONAR"],
     ["CIUDAD DEL ESTE","CIUDAD DEL ESTE"],
     ["MIRADOR DE LA HUERTA","MIRADOR DE LA HUERTA"],
     ["CASCADA","CASCADA"],
     ["MIRADOR DE CALASANZ","MIRADOR DE CALASANZ"],
     ["ALAMOS I","ALAMOS I"],
     ["ALAMOS II","ALAMOS II"],
     ["FLORES","FLORES"],
     ["JUAN BOBO I","JUAN BOBO I"],
     ["VILLA SURAMERICANA","VILLA SURAMERICANA"],
     ["LUSITANIA","LUSITANIA"]
    ]
  end  

   def select_indicadorclase
    [ 
     ["COMPUESTO","COMPUESTO"],
     ["SIMPLE","SIMPLE"],
     ["ESPECIFICO","ESPECIFICO"]
    ]
  end

  def select_sede
    [ 
     ["ISVIMED","ISVIMED"],
     ["IGUANA","IGUANA"],
     ["NOTARIA 27","NOTARIA 27"]
    ]
  end

  def select_usercargo
    [
      ["ASESOR DE DOTACION Y MEJORAMIENTO" , "ASESOR DE DOTACION Y MEJORAMIENTO"],
      ["ASESOR DE GESTION DEL SUELO" , "ASESOR DE GESTION DEL SUELO"],
      ["ASESOR DE NORMALIZACION" , "ASESOR DE NORMALIZACION"],
      ["ASISTENTE SUBDIRECCION APOYO ADMINISTRATIVO Y FINANCIERO" , "ASISTENTE SUBDIRECCION APOYO ADMINISTRATIVO Y FINANCIERO"],
      ["ASISTENTE SUBDIRECCION APOYO JURIDICO" , "ASISTENTE SUBDIRECCION APOYO JURIDICO"],
      ["ASISTENTE SUBDIRECCION DE PLANEACION" , "ASISTENTE SUBDIRECCION DE PLANEACION"],
      ["ASISTENTE SUBDIRECCION DOTACION DE VIVIENDA Y HABITAT" , "ASISTENTE SUBDIRECCION DOTACION DE VIVIENDA Y HABITAT"],
      ["ASISTENTE SUBDIRECCION POBLACIONAL" , "ASISTENTE SUBDIRECCION POBLACIONAL"],
      ["AUXILIAR EN GESTION FINANCIERA" , "AUXILIAR EN GESTION FINANCIERA"],
      ["AUXILIAR EN PRESUPUESTO" , "AUXILIAR EN PRESUPUESTO"],
      ["CONDUCTOR" , "CONDUCTOR"],
      ["CONTADOR" , "CONTADOR"],
      ["CONTRATISTA" , "CONTRATISTA"],
      ["DIRECTOR GENERAL" , "DIRECTOR GENERAL"],
      ["JEFE DE COMUNICACIONES" , "JEFE DE COMUNICACIONES"],
      ["JEFE DE CONTROL INTERNO" , "JEFE DE CONTROL INTERNO"],
      ["PROFESIONAL ESPECIALIZADO" , "PROFESIONAL ESPECIALIZADO"],
      ["PROFESIONAL ESPECIALIZADO ADMINISTRATIVO" , "PROFESIONAL ESPECIALIZADO ADMINISTRATIVO"],
      ["PROFESIONAL ESPECIALIZADO DERECHO URBANO" , "PROFESIONAL ESPECIALIZADO DERECHO URBANO"],
      ["PROFESIONAL ESPECIALIZADO FINANCIERO" , "PROFESIONAL ESPECIALIZADO FINANCIERO"],
      ["PROFESIONAL ESPECIALIZADO JURIDICA" , "PROFESIONAL ESPECIALIZADO JURIDICA"],
      ["PROFESIONAL ESPECIALIZADO PLANEACION" , "PROFESIONAL ESPECIALIZADO PLANEACION"],
      ["PROFESIONAL ESPECIALIZADO TITULACION" , "PROFESIONAL ESPECIALIZADO TITULACION"],
      ["PROFESIONAL ESPECIALIZADO ESCRITURACION" , "PROFESIONAL ESPECIALIZADO ESCRITURACION"],
      ["PROFESIONAL UNIVERSITARIO" , "PROFESIONAL UNIVERSITARIO"],
      ["PROFESIONAL UNIVERSITARIO ARRENDAMIENTO" , "PROFESIONAL UNIVERSITARIO ARRENDAMIENTO"],
      ["PROFESIONAL UNIVERSITARIO CONVIVENCIA" , "PROFESIONAL UNIVERSITARIO CONVIVENCIA"],
      ["PROFESIONAL UNIVERSITARIO GESTION HUMANA" , "PROFESIONAL UNIVERSITARIO GESTION HUMANA"],
      ["PROFESIONAL UNIVERSITARIO JURIDICA" , "PROFESIONAL UNIVERSITARIO JURIDICA"],
      ["PROFESIONAL UNIVERSITARIO OPV" , "PROFESIONAL UNIVERSITARIO OPV"],
      ["PROFESIONAL UNIVERSITARIO PLANEACION" , "PROFESIONAL UNIVERSITARIO PLANEACION"],
      ["PROFESIONAL UNIVERSITARIO POBLACION VULNERABLE" , "PROFESIONAL UNIVERSITARIO POBLACION VULNERABLE"],
      ["PROFESIONAL UNIVERSITARIO SUBSIDIOS" , "PROFESIONAL UNIVERSITARIO SUBSIDIOS"],
      ["SUBDIRECTOR DE APOYO ADMINISTRATIVO Y FINANCIERO" , "SUBDIRECTOR DE APOYO ADMINISTRATIVO Y FINANCIERO"],
      ["SUBDIRECTOR DE APOYO JURIDICO" , "SUBDIRECTOR DE APOYO JURIDICO"],
      ["SUBDIRECTORA DE DOTACION DE VIVIENDA Y HABITAT" , "SUBDIRECTORA DE DOTACION DE VIVIENDA Y HABITAT"],
      ["SUBDIRECTORA DE PLANEACION" , "SUBDIRECTORA DE PLANEACION"],
      ["SUBDIRECTORA POBLACIONAL" , "SUBDIRECTORA POBLACIONAL"],
      ["TECNICO" , "TECNICO"],
      ["TECNICO ADMINISTRATIVO" , "TECNICO ADMINISTRATIVO"],
      ["TECNICO DOCUMENTAL" , "TECNICO DOCUMENTAL"],
      ["TECNICO FINANCIERO" , "TECNICO FINANCIERO"],
      ["TESORERA" , "TESORERA"]
    ]
  end
  
  
  def select_unidad_gestion
	[
	  ["UG I","UG I"],
	  ["UG II","UG II"],
	  ["UG III","UG III"],
	  ["UG IV","UG IV"],
	  ["UG V","UG V"],
	  ["UG VIII","UG VIII"]
	]
  end

  def select_proyectospajarito
    [
      ["AURORA","AURORA"],
      ["AURORA 454","AURORA 454"],
      ["AURORA PEDREGAL ALTO","AURORA PEDREGAL ALTO"],
      ["CANTARES I","CANTARES I"],
      ["CANTARES II","CANTARES II"],
      ["CANTARES III","CANTARES III"],
      ["CANTARES IV Y V","CANTARES IV Y V"],
      ["CASCADA","CASCADA"],
      ["CHAGUALON","CHAGUALON"],
      ["COLINAS DE OCCIDENTE","COLINAS DE OCCIDENTE"],
      ["CUCARACHO","CUCARACHO"],
      ["CUCARACHO MIXTO - LUSITANIA","CUCARACHO MIXTO - LUSITANIA"],
      ["EQUIPAMIENTOS CANTARES I  Y II","EQUIPAMIENTOS CANTARES I  Y II"],
      ["EQUIPAMIENTOS CERCA A BALCONES DE PAJARITO","EQUIPAMIENTOS CERCA A BALCONES DE PAJARITO"],
      ["EQUIPAMIENTOS CERCA A COLINAS DE OCCIDENTE","EQUIPAMIENTOS CERCA A COLINAS DE OCCIDENTE"],
      ["EQUIPAMIENTOS CERCA A ESTACIÓN METRO AURORA","EQUIPAMIENTOS CERCA A ESTACIÓN METRO AURORA"],
      ["EQUIPAMIENTOS CERCA A HOSPITAL Y ESTACIÓN DE POLICIA PAJARITO","EQUIPAMIENTOS CERCA A HOSPITAL Y ESTACIÓN DE POLICIA PAJARITO"],
      ["EQUIPAMIENTOS CERCA A LOTE CUBO","EQUIPAMIENTOS CERCA A LOTE CUBO"],
      ["EQUIPAMIENTOS CERCA A VILLA SURAMERICANA","EQUIPAMIENTOS CERCA A VILLA SURAMERICANA"],
      ["HUERTAS","HUERTAS"],
      ["LOTE LIBRE ANEXO A BALCONES DE PAJARITO","LOTE LIBRE ANEXO A BALCONES DE PAJARITO"],
      ["LOTE LIBRE CONTIGUO A VILLA SURAMERICANA","LOTE LIBRE CONTIGUO A VILLA SURAMERICANA"],
      ["LOTE RESTANTE LA AURORA","LOTE RESTANTE LA AURORA"],
      ["MIRADOR DE LA CASCADA","MIRADOR DE LA CASCADA"],
      ["MONTAÑA","MONTAÑA"],
      ["NAZARETH","NAZARETH"],
      ["POBLADO DEL VIENTO","POBLADO DEL VIENTO"],
      ["RENACERES","RENACERES"],
      ["TIROL I","TIROL I"],
      ["TIROL II","TIROL II"],
      ["TIROL III","TIROL III"],
      ["VELETAS","VELETAS"]
    ]
  end

  def select_naturaleza
    [
      ["PUBLICA","PUBLICA"],
      ["PRIVADA","PRIVADA"]
    ]
  end  

  def select_grupoetnico
    [
      ["INDIGENAS","INDIGENAS"],
      ["AFROCOLOMBIANOS","AFROCOLOMBIANOS"],
      ["RAIZALES","RAIZALES"],
      ["GITANOS O ROM","GITANOS O ROM"],
      ["MESTIZO","MESTIZO"],
      ["OTRO","OTRO"],
      ["SIN DATO","SIN DATO"]
    ]
  end

  def select_escolaridad
    [
      ["PREESCOLAR","PREESCOLAR"],
      ["PRIMARIA","PRIMARIA"],
      ["BACHILLERATO","BACHILLERATO"],
      ["TECNICO","TECNICO"],
      ["TECNOLOGO","TECNOLOGO"],
      ["PROFESIONAL","PROFESIONAL"],
      ["PREGRADO","PREGRADO"],
      ["POSGRADO","POSGRADO"],
      ["MAESTRIA O DOCTORADO","MAESTRIA O DOCTORADO"],
      ["SIN ESCOLARIDAD","SIN ESCOLARIDAD"],
      ["HOGAR ICBF","HOGAR ICBF"],
      ["BUEN COMIENZO","BUEN COMIENZO"],
      ["PRIMARIA INCOMPLETA","PRIMARIA INCOMPLETA"],
      ["SECUNDARIA INCOMPLETA","SECUNDARIA INCOMPLETA"]
    ]
  end   
  
  def select_contrato
    [
      ["INDEFINIDO","INDEFINIDO"],
      ["TEMPORAL","TEMPORAL"],
      ["NO TIENE","NO TIENE"]
    ]
  end

  def select_tipo_discapacidad
    [
      ["FISICA","FISICA"],
      ["MENTAL","MENTAL"],
      ["SENSORIAL","SENSORIAL"],
      ["NINGUNA","NINGUNA"]
    ]
  end  

  def select_participacion
    [
      ["J.A.C.","J.A.C."],
      ["J.A.L.","J.A.L."],
      ["P.P.","P.P."],
      ["JORNADA DE VIDA","JORNADA DE VIDA"],
      ["NINGUNA","NINGUNA"]
    ]
  end  

  def select_estrato
    [ 
      ["ESTRATO 1", 1],
      ["ESTRATO 2", 2],
      ["ESTRATO 3", 3], 
      ["ESTRATO 4", 4],
      ["ESTRATO 5", 5],
      ["ESTRATO 6", 6],
      ["SIN ESTRATO", 0],
      ["SIN DATO", 9]]
  end

  def select_tiporeparto
    [
      ["ORDINARIO","ORDINARIO"],
      ["ESPECIAL","ESPECIAL"]
    ]
 end  

  def select_categoria
    [ 
      ["CATEGORIA PRIMERA", "CATEGORIA PRIMERA"],
      ["CATEGORIA SEGUNDA", "CATEGORIA SEGUNDA"],
      ["CATEGORIA TERCERA", "CATEGORIA TERCERA"],
      ["CATEGORIA CUARTA", "CATEGORIA CUARTA"],
      ["CATEGORIA QUINTA", "CATEGORIA QUINTA"],
      ["CATEGORIA SEXTA", "CATEGORIA SEXTA"],
      ["CATEGORIA SEPTIMA", "CATEGORIA SEPTIMA"]
    ]      
  end

  def select_zona
    [
      ["ZONA NORTE","ZONA NORTE"],
      ["ZONA SUR","ZONA SUR"]
    ]
  end  

  def select_tiposubaspira
    [
      ["SUBSIDIO PARA ADQUISICION DE VIVIENDA","SUBSIDIO PARA ADQUISICION DE VIVIENDA"],
      ["SUBSIDIO PARA ADQUISICION DE VIVIENDA USADA","SUBSIDIO PARA ADQUISICION DE VIVIENDA USADA"],
      ["MEJORAMIENTO DE VIVIENDA","MEJORAMIENTO DE VIVIENDA"]
    ]
  end

   def select_agendaestado
    [
      ["ACTIVO","ACTIVO"],
      ["INACTIVO","INACTIVO"]
    ]
  end


  def select_agendahora
    [
      ['07:00 a.m.','07:00:00'],
      ['07:30 a.m.','07:30:00'],
      ['08:00 a.m.','08:00:00'],
      ['08:30 a.m.','08:30:00'],
      ['09:00 a.m.','09:00:00'],
      ['09:30 a.m.','09:30:00'],
      ['10:00 a.m.','10:00:00'],
      ['10:30 a.m.','10:30:00'],
      ['11:00 a.m.','11:00:00'],
      ['11:30 a.m.','11:30:00'],
      ['12:00 p.m.','12:00:00'],
      ['12:30 p.m.','12:30:00'],
      ['01:00 p.m.','13:00:00'],
      ['01:30 p.m.','13:30:00'],
      ['02:00 p.m.','14:00:00'],
      ['02:30 p.m.','14:30:00'],
      ['03:00 p.m.','15:00:00'],
      ['03:30 p.m.','15:30:00'],
      ['04:00 p.m.','16:00:00'],
      ['04:30 p.m.','16:30:00'],
      ['05:00 p.m.','17:00:00']
    ]

  end

  def select_agendapersonal
    [ 
      ["1", 1],
      ["2", 2],
      ["3", 3], 
      ["4", 4],
      ["5", 5],
      ["6", 6],
      ["7", 7],
      ["8", 8]
    ]
  end

  def select_agendaintervalo
    [ 
      ["10 Minutos", 10],
      ["15 Minutos", 15],
      ["20 Minutos", 20], 
      ["30 Minutos", 30],
      ["45 Minutos", 45],
      ["60 Minutos", 60]
    ]
  end

  def select_categoriaisvimed
    [
      ["ACCION POPULAR","ACCION POPULAR"],
      ["CINTURON VERDE","CINTURON VERDE"],
      ["EDU","EDU"],
      ["EDU - OPV","EDU - OPV"],
      ["EVACUACIONES PREVENTIVAS","EVACUACIONES PREVENTIVAS"],
      ["EXPROPIACION DE  MORAVIA","EXPROPIACION DE  MORAVIA"],
      ["HACIENDA","HACIENDA"],
      ["ISVIMED ESPECIAL","ISVIMED ESPECIAL"],
      ["JARDIN CIRCUNVALAR EDU","JARDIN CIRCUNVALAR EDU"],
      ["MIB","MIB"],
      ["OBRA PUBLICA","OBRA PUBLICA"],
      ["OTROS","OTROS"],
      ["PREVENCION POR RIESGO","PREVENCION POR RIESGO"],
      ["PRINCIPALES EVENTOS","PRINCIPALES EVENTOS"],
      ["REASENTAMIENTO","REASENTAMIENTO"],
      ["REASENTAMIENTO IGUANA","REASENTAMIENTO IGUANA"],
      ["REASENTAMIENTO MORAVIA","REASENTAMIENTO MORAVIA"],
      ["REMISIONES ESPECIALES","REMISIONES ESPECIALES"],
      ["SIN ASIGNAR","SIN ASIGNAR"],
      ["TRANVIA","TRANVIA"],
      ["TUTELAS","TUTELAS"]
    ]        
  end


  def select_tipoevacuacion
    [ 
      ["TEMPORAL","TEMPORAL"],
      ["DEFINITIVA","DEFINITIVA"],
      ["NO TIENE","NO TIENE"]
    ]    
  end

#REQ-0 Arrendamiento temporal - harlynton.castano - 22/03/2018
  def select_tiporelacion
    [ 
      ["BENEFICIARIO","BENEFICIARIO"],
      ["INTEGRANTE","INTEGRANTE"],
      ["PROPIETARIO","PROPIETARIO"],
      ["APODERADO","APODERADO"]
    ]    
  end


   def select_genero
    [ 
      ["MASCULINO", "MASCULINO"],
      ["FEMENINO", "FEMENINO"]
    ]
  end

  def select_uservinculadoactivo
    return is_select_uservinculadoactivo
  end

    def select_viabilidad
    [
      ["VIABLE", "VIABLE"],
      ["INVIABLE", "INVIABLE"],
      ["SIN DEFINIR", "SIN DEFINIR"],
      ["NO APLICA", "NO APLICA"]
    ]
  end

  def select_motivoaumento
    [
      ["SIN ASIGNAR", "SIN ASIGNAR"],
      ["IPC", "IPC"],
      ["REAJUSTE", "REAJUSTE"],
      ["MEJORA", "MEJORA"]
    ]
  end

  def select_porcentaje
  [
    ['1%',0.01],['2%',0.02],['3%',0.03],
    ['4%',0.04],['5%',0.05],['6%',0.06],
    ['7%',0.07],['8%',0.08],['9%',0.09],
    ['10%',0.10],['11%',0.11],['12%',0.12],
    ['13%',0.13],['14%',0.14],['15%',0.15],
    ['16%',0.16],['17%',0.17],['18%',0.18],
    ['19%',0.19],['20%',0.20],['21%',0.21],
    ['22%',0.22],['23%',0.23],['24%',0.24],
    ['25%',0.25],['26%',0.26],['27%',0.27],
    ['28%',0.28],['29%',0.29],['30%',0.30],
    ['31%',0.31],['32%',0.32],['33%',0.33],
    ['34%',0.34],['35%',0.35],['36%',0.36],
    ['37%',0.37],['38%',0.38],['39%',0.39],
    ['40%',0.40],['41%',0.41],['42%',0.42],
    ['43%',0.43],['44%',0.44],['45%',0.45],
    ['46%',0.46],['47%',0.47],['48%',0.48],
    ['49%',0.49],['50%',0.50],['51%',0.51],
    ['52%',0.52],['53%',0.53],['54%',0.54],
    ['55%',0.55],['56%',0.56],['57%',0.57],
    ['58%',0.58],['59%',0.59],['60%',0.60],
    ['61%',0.61],['62%',0.62],['63%',0.63],
    ['64%',0.64],['65%',0.65],['66%',0.66],
    ['67%',0.67],['68%',0.68],['69%',0.69],
    ['70%',0.70],['71%',0.71],['72%',0.72],
    ['73%',0.73],['74%',0.74],['75%',0.75],
    ['76%',0.76],['77%',0.77],['78%',0.78],
    ['79%',0.79],['80%',0.80],['81%',0.81],
    ['82%',0.82],['83%',0.83],['84%',0.84],
    ['85%',0.85],['86%',0.86],['87%',0.87],
    ['88%',0.88],['89%',0.89],['90%',0.90],
    ['91%',0.91],['92%',0.92],['93%',0.93],
    ['94%',0.94],['95%',0.95],['96%',0.96],
    ['97%',0.97],['98%',0.98],['99%',0.99],
    ['100%',0.100]
  ]
  end

  def select_servicios_cuenta
    [
      ["ENERGIA","ENERGIA"],
      ["ENERGIA PREPAGO","ENERGIA PREPAGO"],
      ["AGUA","AGUA"],
      ["AGUA COMUNITARIA","AGUA COMUNITARIA"],
      ["AGUA VEREDA","AGUA VEREDA"],
      ["GAS","GAS"],
      ["TELEFONIA","TELEFONIA"],
      ["INTERNET","INTERNET"],
      ["TELEVISION","TELEVISION"]
    ]
  end

  def select_estadoatencion
    [
      ["CONTRATO", "CONTRATO"],
      ["SIN ASIGNAR", "SIN ASIGNAR"],
      ["NO LE ALQUILAN", "NO LE ALQUILAN"], 
      ["COLOMBIA HUMANITARIA", "COLOMBIA HUMANITARIA"],
      ["INVIABLE JURIDICAMENTE", "INVIABLE JURIDICAMENTE"],
      ["PENDIENTE DE CONTRATO", "PENDIENTE DE CONTRATO"],
      ["CONTRATO CANCELADO", "CONTRATO CANCELADO"],
      ["EN TRAMITE ZR", "EN TRAMITE ZR"],
      ["INVIABLE TECNICAMENTE", "INVIABLE TECNICAMENTE"],
      ["EN TECNICA", "EN TECNICA"],
      ["EN JURIDICA", "EN JURIDICA"],
      ["PENDIENTE DE PAPELERIA", "PENDIENTE DE PAPELERIA"],
      ["NO TOMA VIVIENDA", "NO TOMA VIVIENDA"],
      ["SUSPENSION DEL TRAMITE", "SUSPENSION DEL TRAMITE"]
    ]
  end
  
  
  def select_tipologia_familiar
    [
     ["NUCLEAR","NUCLEAR"],
     ["EXTENSA","EXTENSA"],
     ["DIADA CONYUGAL","DIADA CONYUGAL"],
     ["MONOPARENTAL","MONOPARENTAL"],
     ["UNIPERSONAL","UNIPERSONAL"],
     ["RECONSTITUIDA","RECONSTITUIDA"],
     ["AMPLIADA","AMPLIADA"],
     ["OTRA","OTRA"]
    ]
  end

  def select_actividad_desempena
    [
     ["CONSTRUCCION","CONSTRUCCION"],
     ["RECICLAJE","RECICLAJE"],
     ["OFICIOS VARIOS","OFICIOS VARIOS"],
     ["VENTAS","VENTAS"],
     ["MANUALIDADES","MANUALIDADES"],
     ["AGRICULTOR","AGRICULTOR"],
     ["OTRO","OTRO"]
    ]
  end

  def select_sector_solucion
    [
     ["SIN ASIGNAR","SIN ASIGNAR"],
     ["SECTOR VIVIENDA ACTUAL","SECTOR VIVIENDA ACTUAL"],
     ["OTRO","OTRO"]
    ]
  end

   def select_modalidad_vivienda
    [
     ["SIN ASIGNAR","SIN ASIGNAR"],
     ["NUEVA","NUEVA"],
     ["USADA","USADA"]
    ]
  end

   def select_modalidad_vivienda
    [
     ["","SIN ASIGNAR"],
     ["NUEVA","NUEVA"],
     ["USADA","USADA"]
    ]
  end

  def select_annosayuda
    [ 
      ["1 años","1"],["2 años","2"],["3 años","3"],
      ["4 años","4"],["5 años","5"],["6 años","6"],
      ["7 años","7"],["8 años","8"],["9 años","9"],
      ["10 años","10"],["11 años","11"],["12 años","12"],
      ["13 años","13"],["14 años","14"],["15 años","15"],
      ["16 años","16"],["17 años","17"],["18 años","18"],
      ["19 años","19"],["20 años","20"],["21 años","21"],
      ["22 años","22"],["23 años","23"],["24 años","24"],
      ["25 años","25"],["26 años","26"],["27 años","27"],
      ["28 años","28"],["29 años","29"],["30 años","30"],
      ["31 años","31"],["32 años","32"],["33 años","33"],
      ["34 años","34"],["35 años","35"],["36 años","36"],
      ["37 años","37"],["38 años","38"],["39 años","39"],
      ["40 años","40"],["41 años","41"],["42 años","42"],
      ["43 años","43"],["44 años","44"],["45 años","45"],
      ["46 años","46"],["47 años","47"],["48 años","48"],
      ["49 años","49"],["50 años","50"],["51 años","51"],
      ["52 años","52"],["53 años","53"],["54 años","54"],
      ["55 años","55"],["56 años","56"],["57 años","57"],
      ["58 años","58"],["59 años","59"],["60 años","60"],
      ["61 años","61"],["62 años","62"],["63 años","63"],
      ["64 años","64"],["65 años","65"],["66 años","66"],
      ["67 años","67"],["68 años","68"],["69 años","69"],
      ["70 años","70"],["71 años","71"],["72 años","72"],
      ["73 años","73"],["74 años","74"],["75 años","75"]
    ]
  end

  def select_miembros_aportan
    [ 
     ["1",1],
     ["2",2],
     ["3",3],
     ["4",4],
     ["5",5],
     ["6",6],
     ["7",7],
     ["8",8],
     ["9",9],
     ["10",10]
    ]
  end

  def select_rango_salario
    [
      ["$0 - 50.000","0 - 50.000"],
      ["$101.000 - 200.000","101.000 and 200.000"],
      ["$201.000 - 300.000","201.000 and 300.000"],
      ["$301.000 - 400.000","301.000 and 400.000"],
      ["$401.000 - 500.000","401.000 and 500.000"],
      ["$501.000 - 600.000","501.000 and 600.000"],
      ["$51.000 - 100.000","51.000 and 100.000"],
      ["$601.000 - 700.000","601.000 and 700.000"],
      ["$701.000 - 800.000","701.000 and 800.000"],
      ["$801.000 - 900.000","801.000 and 900.000"],
      ["$901.000 - 1.000.000","901.000 and 1.000.000"]
    ]
  end

	
  def select_presentacionparcial
    [
      ["PARCIAL","PARCIAL"],
      ["TOTAL","TOTAL"],
      ["NO APLICA","NO APLICA"]
    ]
  end


  def select_predio_evacuado
    [ 
      ["CERTIFICADO DE LIBERTAD","CERTIFICADO DE LIBERTAD"],
      ["COMPRAVENTA","COMPRAVENTA"],
      ["DECLARACION DE POSESION","DECLARACION DE POSESION"],
      ["DESCRIPCION DE PREDIOS","DESCRIPCION DE PREDIOS"],
      ["ESCRITURA","ESCRITURA"],
      ["FICHA CATASTRAL","FICHA CATASTRAL"],
      ["NINGUNO","NINGUNO"],
      ["PERMUTA","PERMUTA"],
      ["PREDIAL","PREDIAL"],
      ["PROMESA DE COMPRAVENTA","PROMESA DE COMPRAVENTA"],
      ["RESOLUCION DE CATASTRO","RESOLUCION DE CATASTRO"],
      ["SIN VALOR PROBADO","SIN VALOR PROBADO"]
    ]
  end

  def select_evento
    [
      ["AFLOJAMIENTO DE AGUA","AFLOJAMIENTO DE AGUA"],
      ["AVENIDA TORRENCIAL","AVENIDA TORRENCIAL"],
      ["COLAPSO DE VIVIENDA","COLAPSO DE VIVIENDA"],
      ["DESLIZAMIENTO","DESLIZAMIENTO"],
      ["DETERIORO DE ESTRUCTURA","DETERIORO DE ESTRUCTURA"],
      ["EPIDEMIOLOGGICO","EPIDEMIOLOGGICO"],
      ["EROSION","EROSION"],
      ["HUMEDADES","HUMEDADES"],
      ["INCENDIO","INCENDIO"],
      ["INUNDACION","INUNDACION"],
      ["MIB","MIB"],
      ["MOVIMIENTO EN MASA","MOVIMIENTO EN MASA"],
      ["NATURAL","NATURAL"],
      ["OTROS","OTROS"],
      ["RETIRO DE QUEBRADA","RETIRO DE QUEBRADA"],
      ["RIESGO","RIESGO"],
      ["SIN DEFINIR","SIN DEFINIR"],
      ["SOCAVACION","SOCAVACION"],
      ["TECNOLOGICO","TECNOLOGICO"],
      ["TERREMOTO","TERREMOTO"],
      ["TERRORISMO","TERRORISMO"],
      ["VOLADURA DE TECHO","VOLADURA DE TECHO"]
    ]
  end

   def select_eventos
       [
        ["INVADIDA/POSESION", "INVADIDA/POSESION"],
        ["INVADIDA","INVADIDA"],
        ["PRESTADA","PRESTADA"],
        ["PROPIA/POSESION","PROPIA/POSESION"],
        ["PROPIETARIO RENTISTA", "PROPIETARIO RENTISTA"],
        ["ALQUILADA", "ALQUILADA"],
        ["NO ACCESIBLE", "NO ACCESIBLE"],
        ["SD", "SD"]
       ]
    end
	
	  def select_motivo_cancelacion
		[
		  ["ATENCION TEMPORAL","ATENCION TEMPORAL"],
		  ["AUMENTO DE SUBSIDIO","AUMENTO DE SUBSIDIO"],
		  ["CAMBIO DE BENEFICIARIO","CAMBIO DE BENEFICIARIO"],
		  ["CAMBIO DE FECHA DE CORTE DE CERTIFICACION","CAMBIO DE FECHA DE CORTE DE CERTIFICACION"],
		  ["CAMBIO DE PROPIETARIO","CAMBIO DE PROPIETARIO"],
		  ["CAMBIO DE VIVIENDA","CAMBIO DE VIVIENDA"],
		  ["CONFLICTO FAMILIAR","CONFLICTO FAMILIAR"],
		  ["CRUCE","CRUCE"],
		  ["DOC. GRUPO FAMILIAR INCOMPLETOS","DOC. GRUPO FAMILIAR INCOMPLETOS"],
		  ["FALLECE JEFE DE HOGAR - UNIPERSONAL","FALLECE JEFE DE HOGAR - UNIPERSONAL"],
		  ["INDICACION DEL ISVIMED DE NO CONTINUIDAD","INDICACION DEL ISVIMED DE NO CONTINUIDAD"],
		  ["INFORMACION FRAUDULENTA","INFORMACION FRAUDULENTA"],
		  ["NINGUNO","NINGUNO"],
		  ["NO ACEPTA SOLUCION HABITACIONAL","NO ACEPTA SOLUCION HABITACIONAL"],
		  ["NO ACREDITA","NO ACREDITA"],
		  ["NO APLICA","NO APLICA"],
		  ["NO APORTA CERTIFICADO DE DOMICILIO","NO APORTA CERTIFICADO DE DOMICILIO"],
		  ["OCUPA VIVIENDA EVACUADA","OCUPA VIVIENDA EVACUADA"],
		  ["PAGO DE MEJORAS","PAGO DE MEJORAS"],
		  ["PENDIENTE DE PAZ Y SALVO","PENDIENTE DE PAZ Y SALVO"],
		  ["REAJUSTE VALOR DE SUBSIDIO","REAJUSTE VALOR DE SUBSIDIO"],
		  ["RENUNCIA VOLUNTARIA","RENUNCIA VOLUNTARIA"],
		  ["SUBSIDIO DE MEJORAMIENTO DE VIVIENDA","SUBSIDIO DE MEJORAMIENTO DE VIVIENDA"],
		  ["SUBSIDIO DE VIVIENDA","SUBSIDIO DE VIVIENDA"],
		  ["SUPERA INGRESOS A 2 SMMLV","SUPERA INGRESOS A 2 SMMLV"],
		  ["USO INADECUADO DE VIVIENDA ARRENDADA","USO INADECUADO DE VIVIENDA ARRENDADA"],
		  ["USO INADECUADO DE VIVIENDA EVACUADA","USO INADECUADO DE VIVIENDA EVACUADA"],
		  ["VENCIMIENTO DE PLAZO DE POSTULACION","VENCIMIENTO DE PLAZO DE POSTULACION"]
		]
	  end

	def select_bancos
    [
      ["0001 BANCO DE BOGOTA","BANCO DE BOGOTA"],
      ["0002 BANCO POPULAR","BANCO POPULAR"],
      ["0006 CORBANCA","CORBANCA"],
      ["0007 BANCOLOMBIA","BANCOLOMBIA"],
      ["0008 ABN AMOR BANK COLOMBIA","ABN AMOR BANK COLOMBIA"],
      ["0009 CITIBANK","CITIBANK"],
      ["0010 HSBC","HSBC"],
      ["0012 SUDAMERIS","SUDAMERIS"],
      ["0013 BBVA COLOMBIA","BBVA COLOMBIA"],
      ["0013 GRANAHORRAR (BBVA)","GRANAHORRAR (BBVA)"],
      ["0014 HEIM TRUST","HEIM TRUST"],
      ["0019 BANCO POLPATRIA","BANCO POLPATRIA"],
      ["0023 BANCO DE OCCIDENTE","BANCO DE OCCIDENTE"],
      ["0028 BANCO MERCANTIL DE COLOMBIA","BANCO MERCANTIL DE COLOMBIA"],
      ["0032 BANCO CAJA SOCIAL","BANCO CAJA SOCIAL"],
      ["0035 INTERCONTINENTAL","INTERCONTINENTAL"],
      ["0040 BANCO AGRARIO","BANCO AGRARIO"],
      ["0050 GRANBANCO  BANCAFE","GRANBANCO  BANCAFE"],
      ["0051 DAVIVIENDA","DAVIVIENDA"],
      ["0052 AV VILLAS","AV VILLAS"],
      ["0060 PICHINCHA","PICHINCHA"],
      ["0061 COOMEVA","COOMEVA"],
      ["0283 COOPERATIVA FINANCIERA DE ANTIOQUIA","COOPERATIVA FINANCIERA DE ANTIOQUIA"],
      ["0289 COOTRAFA","COOTRAFA"],
      ["0292 COOPERATIVA CONFIAR","COOPERATIVA CONFIAR"],
      ["0419 YA SERVICIOS FINANCIEROS","YA SERVICIOS FINANCIEROS"],
      ["0502 SKANDIA","SKANDIA"],
      ["0505 ALIANZA FIDUCIARIA","ALIANZA FIDUCIARIA"],
      ["NINGUNO","NINGUNO"]
    ]
  end
  
    def select_segun_valorpredio
   [
    ["AVALUO COMERCIAL","AVALUO COMERCIAL"],
    ["CERTIFICADO NOMENCLATURA","CERTIFICADO NOMENCLATURA"],
    ["CESTIFICADO DE LIBERTAD","CESTIFICADO DE LIBERTAD"],
    ["COMPRAVENTA","COMPRAVENTA"],
    ["DECLARACION DE POSESION","DECLARACION DE POSESION"],
    ["DESCRIPCION DE PREDIOS","DESCRIPCION DE PREDIOS"],
    ["ESCRITURA","ESCRITURA"],
    ["FICHA CATASTRAL","FICHA CATASTRAL"],
    ["NINGUNO","NINGUNO"],
    ["PAZ Y SALVO PREDIAL","PAZ Y SALVO PREDIAL"],
    ["PERMUTA","PERMUTA"],
    ["PREDIAL","PREDIAL"],
    ["PROMESA DE COMPRAVENTA","PROMESA DE COMPRAVENTA"],
    ["RESOLUCION DE CATASTRO","RESOLUCION DE CATASTRO"]
   ]
  end

 

def select_segun_valorpredio
   [
    ["AVALUO COMERCIAL","AVALUO COMERCIAL"],
    ["CERTIFICADO NOMENCLATURA","CERTIFICADO NOMENCLATURA"],
    ["CESTIFICADO DE LIBERTAD","CESTIFICADO DE LIBERTAD"],
    ["COMPRAVENTA","COMPRAVENTA"],
    ["DECLARACION DE POSESION","DECLARACION DE POSESION"],
    ["DESCRIPCION DE PREDIOS","DESCRIPCION DE PREDIOS"],
    ["ESCRITURA","ESCRITURA"],
    ["FICHA CATASTRAL","FICHA CATASTRAL"],
    ["NINGUNO","NINGUNO"],
    ["PAZ Y SALVO PREDIAL","PAZ Y SALVO PREDIAL"],
    ["PERMUTA","PERMUTA"],
    ["PREDIAL","PREDIAL"],
    ["PROMESA DE COMPRAVENTA","PROMESA DE COMPRAVENTA"],
    ["RESOLUCION DE CATASTRO","RESOLUCION DE CATASTRO"]
   ]
  end

  def select_arriendoacreditado  #quitar de la parte de arriba y colcoar este nuevo
    [
      ["NINGUNO","NINGUNO"],
      ["SI","SI"],
      ["PARCIAL","PARCIAL"],
      ["NO","NO"],
      ["NO TIENE COMO ACREDITAR","NO TIENE COMO ACREDITAR"],
      ["SI-PARCIAL","SI-PARCIA"]
    ]
  end

  def select_atiende_como  #QUITAR DE MAS ARRIBA
    [ 
      ["MERO TENEDOR","MERO TENEDOR"],
      ["POSEEDOR","POSEEDOR"],
      ["PROPIETARIO","PROPIETARIO"],
      ["NINGUNO","NINGUNO"] 
    ]
  end

  def select_motivocambio # CAMBIAR Y REVISAR MAS ARRIBA
    [ 
      ["CONDICIONES ECONOMICAS (BENEFICIARIO)","CONDICIONES ECONOMICAS (BENEFICIARIO)"],
      ["MOTIVOS DE SALUD (BENEFICIARIO)","MOTIVOS DE SALUD (BENEFICIARIO)"],
      ["POR SEGURIDAD (BENEFICIARIO)","POR SEGURIDAD (BENEFICIARIO)"],
      ["REACTIVACION","REACTIVACION"],
      ["RECOMENDACIÓN AREA JURIDICA","RECOMENDACIÓN AREA JURIDICA"],
      ["RECOMENDACIÓN AREA SOCIAL","RECOMENDACIÓN AREA SOCIAL"],
      ["RECOMENDACIÓN AREA TECNICA","RECOMENDACIÓN AREA TECNICA"],
      ["SIN ASIGNAR","SIN ASIGNAR"],
      ["SOLICITUD DE PROPIETARIO","SOLICITUD DE PROPIETARIO"]
    ]
  end

  def select_arriendoentidad # CAMBIAR Y REVISAR MAS ARRIBA
    [
      ["COMFAMA","COMFAMA"],
      ["CAMACOL","CAMACOL"],
      ["ANTIOQUIA PRESENTE","ANTIOQUIA PRESENTE"],
      ["FONDO DE ADAPTACION","FONDO DE ADAPTACION"],
      ["SD","SD"]
    ]
  end

  def select_formato  
    [
      ["PANTALLA","PANTALLA"],
      ["EXCEL","EXCEL"]
    ]
  end
  
  def select_municipio
    [
      ["ABEJORRAL","ABEJORRAL"],
      ["ABRIAQUI","ABRIAQUI"],
      ["ALEJANDRIA","ALEJANDRIA"],
      ["AMAGA","AMAGA"],
      ["AMALFI","AMALFI"],
      ["ANDES","ANDES"],
      ["ANGELOPOLIS","ANGELOPOLIS"],
      ["ANGOSTURA","ANGOSTURA"],
      ["ANORI","ANORI"],
      ["ANZA","ANZA"],
      ["APARTADO","APARTADO"],
      ["ARBOLETES","ARBOLETES"],
      ["ARGELIA","ARGELIA"],
      ["ARMENIA","ARMENIA"],
      ["BARBOSA","BARBOSA"],
      ["BELLO","BELLO"],
      ["BELMIRA","BELMIRA"],
      ["BETANIA","BETANIA"],
      ["BETULIA","BETULIA"],
      ["BRICEY0","BRICEY0"],
      ["BURITICA","BURITICA"],
      ["CACERES","CACERES"],
      ["CAICEDO","CAICEDO"],
      ["CALDAS","CALDAS"],
      ["CAMPAMENTO","CAMPAMENTO"],
      ["CAÑASGORDAS","CAÑASGORDAS"],
      ["CARACOLI","CARACOLI"],
      ["CARAMANTA","CARAMANTA"],
      ["CAREPA","CAREPA"],
      ["CARMEN DE VIBORAL","CARMEN DE VIBORAL"],
      ["CAROLINA","CAROLINA"],
      ["CAUCASIA","CAUCASIA"],
      ["CHIGORODO","CHIGORODO"],
      ["CISNEROS","CISNEROS"],
      ["CIUDAD BOLIVAR","CIUDAD BOLIVAR"],
      ["COCORNA","COCORNA"],
      ["CONCEPCION","CONCEPCION"],
      ["CONCORDIA","CONCORDIA"],
      ["COPACABANA","COPACABANA"],
      ["DABEIBA","DABEIBA"],
      ["DON MATIAS","DON MATIAS"],
      ["EBEJICO","EBEJICO"],
      ["EL BAGRE","EL BAGRE"],
      ["EL PEÑOL","EL PEÑOL"],
      ["EL RETIRO","EL RETIRO"],
      ["ENTRERRIOS","ENTRERRIOS"],
      ["ENVIGADO","ENVIGADO"],
      ["FREDONIA","FREDONIA"],
      ["FRONTINO","FRONTINO"],
      ["GIRALDO","GIRALDO"],
      ["GIRARDOTA","GIRARDOTA"],
      ["GOMEZ PLATA","GOMEZ PLATA"],
      ["GRANADA","GRANADA"],
      ["GUADALUPE","GUADALUPE"],
      ["GUARNE","GUARNE"],
      ["GUATAPE","GUATAPE"],
      ["HELICONIA","HELICONIA"],
      ["HISPANIA","HISPANIA"],
      ["ITAGUI","ITAGUI"],
      ["ITUANGO","ITUANGO"],
      ["JARDIN","JARDIN"],
      ["JERICO","JERICO"],
      ["LA CEJA","LA CEJA"],
      ["LA ESTRELLA","LA ESTRELLA"],
      ["LA PINTADA","LA PINTADA"],
      ["LA UNION","LA UNION"],
      ["LIBORINA","LIBORINA"],
      ["MACEO","MACEO"],
      ["MARINILLA","MARINILLA"],
      ["MEDELLIN","MEDELLIN"],
      ["MONTEBELLO","MONTEBELLO"],
      ["MURINDO","MURINDO"],
      ["MUTATA","MUTATA"],
      ["NARIÑO","NARIÑO"],
      ["NECHI","NECHI"],
      ["NECOCLI","NECOCLI"],
      ["OLAYA","OLAYA"],
      ["PEQUE","PEQUE"],
      ["PUEBLO RICO","PUEBLO RICO"],
      ["PUERTO BERRIO","PUERTO BERRIO"],
      ["PUERTO NARE","PUERTO NARE"],
      ["PUERTO TRIUNFO","PUERTO TRIUNFO"],
      ["REMEDIOS","REMEDIOS"],
      ["RIONEGRO","RIONEGRO"],
      ["SABANALARGA","SABANALARGA"],
      ["SABANETA","SABANETA"],
      ["SALGAR","SALGAR"],
      ["SAN ANDRES","SAN ANDRES"],
      ["SAN CARLOS","SAN CARLOS"],
      ["SAN FRANCISCO","SAN FRANCISCO"],
      ["SAN JERONIMO","SAN JERONIMO"],
      ["SAN JOSE DE LA MONTAÑA","SAN JOSE DE LA MONTAÑA"],
      ["SAN JUAN DE URABA","SAN JUAN DE URABA"],
      ["SAN LUIS","SAN LUIS"],
      ["SAN PEDRO","SAN PEDRO"],
      ["SAN PEDRO DE URABA","SAN PEDRO DE URABA"],
      ["SAN RAFAEL","SAN RAFAEL"],
      ["SAN ROQUE","SAN ROQUE"],
      ["SAN VICENTE","SAN VICENTE"],
      ["SANTA BARBARA","SANTA BARBARA"],
      ["SANTA FE DE ANTIOQUIA","SANTA FE DE ANTIOQUIA"],
      ["SANTA ROSA DE OSOS","SANTA ROSA DE OSOS"],
      ["SANTO DOMINGO","SANTO DOMINGO"],
      ["SANTUARIO","SANTUARIO"],
      ["SEGOVIA","SEGOVIA"],
      ["SONSON","SONSON"],
      ["SOPETRAN","SOPETRAN"],
      ["TAMESIS","TAMESIS"],
      ["TARAZA","TARAZA"],
      ["TARSO","TARSO"],
      ["TITIRIBI","TITIRIBI"],
      ["TOLEDO","TOLEDO"],
      ["TURBO","TURBO"],
      ["URAMITA","URAMITA"],
      ["URRAO","URRAO"],
      ["VALDIVIA","VALDIVIA"],
      ["VALPARAISO","VALPARAISO"],
      ["VEGACHI","VEGACHI"],
      ["VENECIA","VENECIA"],
      ["VIGIA DEL FUERTE","VIGIA DEL FUERTE"],
      ["YALI","YALI"],
      ["YARUMAL","YARUMAL"],
      ["YOLOMBO","YOLOMBO"],
      ["YONDO","YONDO"],
      ["ZARAGOZA","ZARAGOZA"]
    ]
  end

  def select_tipopago_ayuda
    [
      ["DAVIPLATA","DAVIPLATA"],
      ["TRANSFERENCIA","TRANSFERENCIA"]
    ]
  end

  def select_dia
    [
      ["LUNES","LUNES"],
      ["MARTES","MARTES"],
      ["MIERCOLES","MIERCOLES"],
      ["JUEVES","JUEVES"],
      ["VIERNES","VIERNES"]
    ]
  end

  def select_estadoescritura 
   [ 
    ["FINALIZADO","FINALIZADO"],
    ["REPARTO","REPARTO"],
    ["SIN INICIAR","SIN INICIAR"],
    ["TRAMITE","TRAMITE"]
   ]
  end

  def select_calidad_sanluis
    [ 
      ["POSEEDOR","POSEEDOR"],
      ["PROPIETARIO","PROPIETARIO"],
      ["TENEDOR","TENEDOR"]
    ]
  end

  def select_predial_sanluis
    [ 
      ["LOTE","LOTE"],
      ["CONSTRUCCION","CONSTRUCCION"],
      ["LOTE + CONSTRUCCION","LOTE + CONSTRUCCION"],
      ["SIN IDENTIDAD REGISTRAL","SIN IDENTIDAD REGISTRAL"],
      ["PROPIEDAD HORIZONTAL","PROPIEDAD HORIZONTAL"]
    ]
  end

  def select_resol_modalidad
    [ 
      ["NUEVA","NUEVA"],
      ["USADA","USADA"],
      ["MEJORAMIENTO","MEJORAMIENTO"],
      ["NUEVA POR REPOSICION","NUEVA POR REPOSICION"],
      ["ARRENDAMIENTO","ARRENDAMIENTO"],
      ["ESCRITURACION","ESCRITURACION"]
    ]
  end  

  def select_tipovivienda
    [
      ["PROPIA","PROPIA"],
      ["ARRIENDO","ARRIENDO"],
      ["FAMILIAR","FAMILIAR"]
    ]
  end

  def select_tiposnovedad
    [
      ["DEDUCCION","1"],
      ["INCAPACIDAD","2"],
      ["DEVENGADO","3"],
      ["VACACIONES","4"],
      ["PRIMA DE NAVIDAD","7"],
      ["BONIFICACION","8"],
      ["PRIMA DE SERVICIOS","9"]
    ]
  end

  def select_puntaje
    [ 
      ["1 - MUY MALO","1"],
      ["2 - MALO","2"],
      ["3 - ACEPTABLE","3"],
      ["4 - BUENO" ,"4"],
      ["5 - EXCELENTE","5"]
    ]
  end

   def select_informacion
    [ 
      ["BOLETIN INTERNO","BOLETIN INTERNO"],
      ["CORREOS","CORREOS"],
      ["CARTELERAS","CARTELERAS"],
      ["REUNIONES DE AREAS","REUNIONES DE AREAS "],
      ["REUNIONES DEL INSTITUTO","REUNIONES DEL INSTITUTO"],
      ["PAGINA WEB","PAGINA WEB "],
      ["OTROS","OTROS"],
    ]
  end  

  def select_claserecibida

      [
        ["ARRENDAMIENTO TEMPORAL","ARRENDAMIENTO TEMPORAL"],
        ["AUTORIZACION PARA VENTA O ARRENDAMIENTO","AUTORIZACION PARA VENTA O ARRENDAMIENTO"],
        ["CANCELACION DE HIPOTECAS","CANCELACION DE HIPOTECAS"],
        ["COPROPIEDADES","COPROPIEDADES"],
        ["DESENGLOBE","DESENGLOBE"],
        ["DESPLAZADOS","DESPLAZADOS"],
        ["ENTES DE CONTROL","ENTES DE CONTROL"],
        ["ENTREGAS","ENTREGAS"],
        ["ENTREGAS DE EXPEDIENTES","ENTREGAS DE EXPEDIENTES"],
        ["ESCRITURACION", "ESCRITURACION"],
        ["GESTION ADMINISTRATIVA Y FINANCIERA","GESTION ADMINISTRATIVA Y FINANCIERA"],
        ["GESTION DE INFRAESTRUCTURA INTERNA","GESTION DE INFRAESTRUCTURA INTERNA"],    
        ["GESTION DE LAS TICS","GESTION DE LAS TICS"],
        ["GESTION DOCUMENTAL","GESTION DOCUMENTAL"],
        ["GESTION HUMANA","GESTION HUMANA"],
        ["LEGALIZACION","LEGALIZACION"],
        ["MEJORAMIENTO","MEJORAMIENTO"],
        ["MEJORAMIENTO SIN BARRERAS","MEJORAMIENTO SIN BARRERAS"],
        ["OPV","OPV"],
        ["PLANEACION","PLANEACION"],
        ["POSTULACIONES","POSTULACIONES"],
        ["POSTVENTAS","POSTVENTAS"],
        ["PQRS","PQRS"],
        ["REASENTAMIENTO","REASENTAMIENTO"],
        ["RENUNCIA A SUBSIDIOS","RENUNCIA A SUBSIDIOS"],
        ["TITULACION","TITULACION"],
        ["TUTELAS","TUTELAS"],
        ["TRAMITES DE ESCRITURACION","TRAMITES DE ESCRITURACION"],
        ["VIVIENDA NUEVA","VIVIENDA NUEVA"],
        ["VIVIENDA NUEVA (POSTULACION - ASIGNACION)","VIVIENDA NUEVA (POSTULACION - ASIGNACION)"],
        ["VIVIENDA USADA","VIVIENDA USADA"]
    ]
  end

=begin    
    [["ARRENDAMIENTO","ARRENDAMIENTO"],
    ["MEJORAMIENTO","MEJORAMIENTO"],
    ["SOLICITUD PERMISO PARA VENDER Y/O ARRENDAR","SOLICITUD PERMISO PARA VENDER Y/O ARRENDAR"],
    ["SUBSIDIO VIVIENDA NUEVA","SUBSIDIO VIVIENDA NUEVA"],
    ["SUBSIDIO VIVIENDA USADA","SUBSIDIO VIVIENDA USADA"],
    ["TITULACIONES","TITULACIONES"],
    ["POSVENTAS","POSVENTAS"],
    ["OTRO ASUNTO","OTRO ASUNTO"]]
  end
=end

  def select_tiposdocumemto
    [
      ["CARTAS DE PROPIETARIOS SOLICITANDO LA VIVIENDA","CARTAS DE PROPIETARIOS SOLICITANDO LA VIVIENDA"],
      ["CARTAS PARA CAMBIO DE VIVIENDA","CARTAS PARA CAMBIO DE VIVIENDA"],
      ["CARTAS RECIBIDAS PARA SOLICITUD DE AUMENTO DE CANON","CARTAS RECIBIDAS PARA SOLICITUD DE AUMENTO DE CANON"],
      ["DOCUMENTACION DE TENENCIA DE VIVIENDA EVACUADA","DOCUMENTACION DE TENENCIA DE VIVIENDA EVACUADA"],
      ["DOCUMENTACION DE VIVIENDA PARA ARRENDAR POR PRIMERA VEZ","DOCUMENTACION DE VIVIENDA PARA ARRENDAR POR PRIMERA VEZ"],
      ["DOCUMENTACION DE VIVIENDAS DISPONIBLES","DOCUMENTACION DE VIVIENDAS DISPONIBLES"],
      ["DOCUMENTACION PARA CAMBIO DE VIVIENDA","DOCUMENTACION PARA CAMBIO DE VIVIENDA"],
      ["DOCUMENTOS SOPORTES DE INGRESOS FAMILIARES","DOCUMENTOS SOPORTES DE INGRESOS FAMILIARES"],
      ["DOCUMENTOS DE IDENTIDAD DEL GRUPO FAMILIAR","DOCUMENTOS DE IDENTIDAD DEL GRUPO FAMILIAR"],
      ["OTROS DOCUMENTOS","OTROS DOCUMENTOS"],
      ["PAZ Y SALVOS RECIBIDOS","PAZ Y SALVOS RECIBIDOS"]
    ]
  end

  def select_tipocontrato
    [
      ["F. DE ADMINISTRACION - ADMINISTRACION Y PAGOS","F. DE ADMINISTRACION - ADMINISTRACION Y PAGOS"],
      ["F. INVERSION - FIDEICOMISOS DE INVERSION CON DESTINACION ESPECIFICA","F. INVERSION - FIDEICOMISOS DE INVERSION CON DESTINACION ESPECIFICA"],
      ["F. INMOBILIARIA - DE ADMINISTRACION Y PAGOS","F. INMOBILIARIA - DE ADMINISTRACION Y PAGOS"]
    ]
  end

  def select_tipomodificacion
    [
      ["CONDICIONES DE OPERACION","CONDICIONES DE OPERACION"],
      ["DINERO","DINERO"],
      ["TIEMPO","TIEMPO"]
    ]
  end

  def select_estado_iguana
    [
      ["ENTREGADO","ENTREGADO"],
      ["PENDIENTE","PENDIENTE"],
      ["EN REVISION","EN REVISION"],
      ["NO APLICA","NO APLICA"]
    ]
  end

  def select_originrecurso
    [
      ["MUNICIPAL","MUNICIPAL"],
      ["NACIONAL","NACIONAL"]
    ]
  end

  def select_tipoactivo
    [
      ["ACTIVOS MONETARIOS","ACTIVOS MONETARIOS"],
      ["BIENES INMUEBLES","BIENES INMUEBLES"]
    ]
  end

  def select_cumple
    [
      ["CUMPLE","CUMPLE"],
      ["NO CUMPLE","NO CUMPLE"]
    ]
  end
end

	

class Fase2censo < ActiveRecord::Base
  belongs_to :persona

  def d_id_estado
    return "Código Estado (id_estado)"
  end

  def d_estado
    return  "Identificación de Estado (estado)"
  end

  def d_noform
    return  "Número de Formulario (noform)"
  end

  def d_p1
    return  "Fecha visita (p1)"
  end

  def d_p2
    return  "Dirección o instalación de energía de la vivienda (p2)"
  end

  def d_p3
    return  "Fotografía 01 (p3)"
  end

  def d_p4
    return  "Comuna o corregimiento (p4)"
  end

  def d_p5
    return  "Barrio (p5)"
  end

  def d_p6
    return  "Teléfono fijo (p6)"
  end

  def d_p6_1
    return  "Teléfono celular (p6_1)"
  end

  def d_p7
    return  "Manzana (p7)"
  end

  def d_p8
    return  "Lote (p8)"
  end

  def d_p9
    return  "Área total del lote - en M2. Aproximadamente (p9)"
  end

  def d_p10
    return  "Área construida - en M2  Aproximadamente (p10)"
  end

  def d_p11
    return  "Número de Matricula Inmobiliaria (p11)"
  end

  def d_p11_1
    return  "Matrícula Inmobiliaria (p11_1)"
  end

  def d_p12
    return  "Número de Código catastral (p12)"
  end

  def d_p12_1
    return  "Código catastral (p12_1)"
  end

  def d_p13
    return  "Estrato socioeconómico (p13)"
  end

  def d_p14
    return  "Tipo de Tenencia de la vivienda (p14)"
  end

  def d_p16
    return  "Tipología de la vivienda (p16)"
  end

  def d_p22
    return  "Cuántos cuartos tiene esta vivienda?:  N° comedor independiente (p22)"
  end

  def d_p23
    return  "Cuántos cuartos tiene esta vivienda?:  Y cuál es su estado Actual: comedor independiente? (p23)"
  end

  def d_p24
    return  "Cuántos cuartos tiene esta vivienda?:  Requieren intervención: comedor independiente? (p24)"
  end

  def d_p25
    return  "Cuántos cuartos tiene esta vivienda?:  N° sala comedor (p25)"
  end

  def d_p26
    return  "Cuántos cuartos tiene esta vivienda?:  Y cuál es su estado Actual: sala comedor? (p26)"
  end

  def d_p27
    return  "Cuántos cuartos tiene esta vivienda?:  Requieren intervención: sala comedor? (p27)"
  end

  def d_p28
    return  "Cuántos cuartos tiene esta vivienda?:  N° sala independiente (p28)"
  end

  def d_p29
    return  "Cuántos cuartos tiene esta vivienda?:  Y cuál es su estado Actual: sala independiente? (p29)"
  end

  def d_p30
    return  "Cuántos cuartos tiene esta vivienda?:  Requieren intervención: sala independiente? (p30)"
  end

  def d_p31
    return  "Cuántos cuartos tiene esta vivienda?:  N° garajes (p31)"
  end

  def d_p32
    return  "Cuántos cuartos tiene esta vivienda?:  Y cuál es su estado Actual: garajes? (p32)"
  end

  def d_p33
    return  "Cuántos cuartos tiene esta vivienda?:  Requieren intervención: garajes? (p33)"
  end

  def d_p34
    return  "Cuántos cuartos tiene esta vivienda?:  N° cuartos compartidos para dormir (p34)"
  end

  def d_p35
    return  "Cuántos cuartos tiene esta vivienda?:  Y cuál es su estado Actual: cuartos compartidos para dormi? (p35)"
  end

  def d_p36
    return  "Cuántos cuartos tiene esta vivienda?:  Requieren intervención: cuartos compartidos para dormi? (p36)"
  end

  def d_p37
    return  "Cuántos cuartos tiene esta vivienda?:  N° cuartos Para dormir -independientemente del hogar- y otros usos (p37)"
  end

  def d_p38
    return  "Cuántos cuartos tiene esta vivienda?:  Y cuál es su estado Actual: cuartos Para dormir -independientemente del hogar- y otros usos? (p38)"
  end

  def d_p39
    return  "Cuántos cuartos tiene esta vivienda?:  Requieren intervención: cuartos Para dormir -independientemente del hogar- y otros usos? (p39)"
  end

  def d_p40
    return  "Cuántos cuartos tiene esta vivienda?:  N° Cuartos para otros usos (p40)"
  end

  def d_p40_1
    return  "Cuántos cuartos tiene esta vivienda?:  N° Cuartos exclusivos para dormir (p40_1)"
  end

  def d_p41
    return  "Cuántos cuartos tiene esta vivienda?:  Y cuál es su estado Actual: Cuartos para otros usos? (p41)"
  end

  def d_p41_1
    return  "Cuántos cuartos tiene esta vivienda?:  Y cuál es su estado Actual: Cuartos exclusivos para dormir? (p41_1)"
  end

  def d_p42
    return  "Cuántos cuartos tiene esta vivienda?:  Requieren intervención: Cuartos para otros usos? (p42)"
  end

  def d_p42_1
    return  "Cuántos cuartos tiene esta vivienda?:  Requieren intervención: Cuartos exclusivos para dormir? (p42_1)"
  end

  def d_p43
    return  "Fotografía02 de Comedor Independiente (p43)"
  end

  def d_p44
    return  "Fotografía03 de Sala - Comedor (p44)"
  end

  def d_p45
    return  "Fotografía04 de Sala Independiente (p45)"
  end

  def d_p46
    return  "Fotografía05 de Garaje (p46)"
  end

  def d_p47
    return  "Fotografía06 Cuartos compartir para dormir (p47)"
  end

  def d_p48
    return  "Fotografía07  Para dormir y otros usos (p48)"
  end

  def d_p49
    return  "Fotografía08  Cuartos otros usos (p49)"
  end

  def d_p49_1
    return  "Fotografía08_1 Cuartos exclusivos para dormir (p49_1)"
  end

  def d_p50
    return  "¿Hay en esta vivienda algún tipo de negocio? (p50)"
  end

  def d_p51
    return  "Fotografía 9 del negocio y vivienda (p51)"
  end

  def d_p52
    return  "Y el negocio es (p52)"
  end

  def d_p53
    return  "¿Y cuál es la actividad económica de ese negocio? (p53)"
  end

  def d_p54
    return  "Tiene el negocio alguno de los siguientes documentos: Registro de Cámara de Comercio (p54)"
  end

  def d_p55
    return  "Tiene el negocio alguno de los siguientes documentos: RUT (p55)"
  end

  def d_p56
    return  "Tiene el negocio alguno de los siguientes documentos: NIT (p56)"
  end

  def d_p57
    return  "Tiene el negocio alguno de los siguientes documentos: Declaración de rentas de los 2 últimos años (p57)"
  end

  def d_p58
    return  "Tiene el negocio alguno de los siguientes documentos: Declaración industria y comercio (p58)"
  end

  def d_p59
    return  "Tiene el negocio alguno de los siguientes documentos: Libros de contabilidad (p59)"
  end

  def d_p60
    return  "Tiene el negocio alguno de los siguientes documentos: Estados financieros (p60)"
  end

  def d_p61
    return  "Tiene el negocio alguno de los siguientes documentos: Ninguno (p61)"
  end

  def d_p62
    return  "¿Qué área de la vivienda en M2-aproximadamente- ocupa el negocio? (p62)"
  end

  def d_p63
    return  "¿Este hogar percibe alguna Renta o alquiler por ese negocio o por alquiler de parte de la vivienda? (p63)"
  end

  def d_p78
    return  "¿Posee?: Columnas (p78)"
  end

  def d_p79
    return  "Y ¿Cuál es el estado de los siguientes elementos estructurales?: Columnas (p79)"
  end

  def d_p80
    return  "¿Posee?: Vigas de Amarre (p80)"
  end

  def d_p81
    return  "Y ¿Cuál es el estado de los siguientes elementos estructurales?: Vigas de Amarre (p81)"
  end

  def d_p82
    return  "¿Posee?: Losas en Concreto (p82)"
  end

  def d_p83
    return  "Y ¿Cuál es el estado de los siguientes elementos estructurales?: Losas en Concreto (p83)"
  end

  def d_p84
    return  "Fotografía 10: Columnas (p84)"
  end

  def d_p85
    return  "Fotografía 11: Vigas de Amarre (p85)"
  end

  def d_p86
    return  "Fotografía 12: Losas en Concreto (p86)"
  end

  def d_p87
    return  "¿Cuál es el Material predominante de las paredes exteriores? (p87)"
  end

  def d_p88
    return  "Estado actual de fachada o paredes exteriores (p88)"
  end

  def d_p89
    return  "¿Requiere intervención: fachada o paredes exteriores? (p89)"
  end

  def d_p90
    return  "Fotografía 13: Fachada, enfatice en las que requiere Intervención (p90)"
  end

  def d_p91
    return  "En relación con su techo o losa: (p91)"
  end

  def d_p92
    return  "¿Cuál es el Material predominante de los techos o cubiertas? (p92)"
  end

  def d_p92_2
    return  "Otros ¿Cuál? (p92_2)"
  end

  def d_p93
    return  "¿Estado actual de los Techos? (p93)"
  end

  def d_p94
    return  "¿Requieren Intervención:  Techos? (p94)"
  end

  def d_p95
    return  "Fotografía 14: Techos, enfatice en los que hay que intervenir (p95)"
  end

  def d_p96
    return  "Fotografía 15: Techos, enfatice en los que hay que intervenir (p96)"
  end

  def d_p97
    return  "¿Cuál es el Material predominante de los pisos? (p97)"
  end

  def d_p98
    return  "¿Cuál es el estado actual de los pisos? (p98)"
  end

  def d_p99
    return  "¿Requieren Intervención: pisos? (p99)"
  end

  def d_p100
    return  "Fotografía 16: Pisos, enfatice en los que hay que intervenir (p100)"
  end

  def d_p101
    return  "Fotografía 17: Pisos, enfatice en los que hay que intervenir (p101)"
  end

  def d_p102
    return  "¿En dónde preparan los alimentos las personas de este hogar? (p102)"
  end

  def d_p103
    return  "¿Cuál es el estado y funcionamiento de la cocina en: Mesón de la cocina (p103)"
  end

  def d_p104
    return  "¿Requiere intervención: Mesón de la cocina? (p104)"
  end

  def d_p105
    return  "¿Cuál es el estado y funcionamiento de la cocina en: Enchapes de cocina (p105)"
  end

  def d_p106
    return  "¿Requiere intervención: Enchapes de cocina? (p106)"
  end

  def d_p107
    return  "¿Cuál es el estado y funcionamiento de la cocina en: Estructura de cubierta-Muebles (p107)"
  end

  def d_p108
    return  "¿Requiere intervención: Estructura de cubierta-Muebles? (p108)"
  end

  def d_p109
    return  "¿Cuál es el estado y funcionamiento de la cocina en: Fogón o parrilla (p109)"
  end

  def d_p110
    return  "¿Requiere intervención: Fogón o parrilla? (p110)"
  end

  def d_p111
    return  "Fotografía 18: de la cocina y  demás partes, enfatice en las que hay que Intervenir: Mesón de la cocina (p111)"
  end

  def d_p112
    return  "Fotografía 19: de la cocina y  demás partes, enfatice en las que hay que Intervenir: Enchapes de cocina (p112)"
  end

  def d_p113
    return  "Fotografía 20: de la cocina y  demás partes, enfatice en las que hay que Intervenir: Estructura de cubierta-Muebles (p113)"
  end

  def d_p114
    return  "Fotografía 21: de la cocina y  demás partes, enfatice en las que hay que Intervenir:  Fogón o parrilla (p114)"
  end

  def d_p115
    return  "¿Cuál es el estado y funcionamiento de la vivienda en: Enchapes de Baños (p115)"
  end

  def d_p116
    return  "¿Requieren Intervención: Enchapes de Baños? (p116)"
  end

  def d_p117
    return  "¿Cuál es el estado y funcionamiento de la vivienda en: Revoque de los muros (p117)"
  end

  def d_p118
    return  "¿Requieren Intervención: Revoque de los muros? (p118)"
  end

  def d_p119
    return  "¿Cuál es el estado y funcionamiento de la vivienda en: Estuco de los muros (p119)"
  end

  def d_p120
    return  "¿Requieren Intervención: Estuco de los muros? (p120)"
  end

  def d_p121
    return  "¿Cuál es el estado y funcionamiento de la vivienda en: Pintura de los muros (p121)"
  end

  def d_p122
    return  "¿Requieren Intervención:  Pintura de los muros? (p122)"
  end

  def d_p123
    return  "¿Cuál es el estado y funcionamiento de la vivienda en: Muros mampostería (p123)"
  end

  def d_p124
    return  "¿Requieren Intervención: Muros mampostería? (p124)"
  end

  def d_p125
    return  "Fotografía 22: de los implementos y demás áreas, enfatice en las que  requieren intervención: Enchapes de Baños (p125)"
  end

  def d_p126
    return  "Fotografía 23: de los implementos y demás áreas, enfatice en las que  requieren intervención: Revoque de los muros (p126)"
  end

  def d_p127
    return  "Fotografía 24: de los implementos y demás áreas, enfatice en las que  requieren intervención: Estuco de los muros (p127)"
  end

  def d_p128
    return  "Fotografía 25: de los implementos y demás áreas, enfatice en las que  requieren intervención: Pintura de los muros (p128)"
  end

  def d_p129
    return  "Fotografía 26: de los implementos y demás áreas, enfatice en las que  requieren intervención: Muros mampostería (p129)"
  end

  def d_p130
    return  "¿Qué tipo de instalaciones eléctricas tiene el hogar? (p130)"
  end

  def d_p131
    return  "Requiere intervención: instalaciones eléctricas? (p131)"
  end

  def d_p132
    return  "Fotografía 27: Instalaciones eléctricas, enfatice en las que hay que Intervenir (p132)"
  end

  def d_p133
    return  "Fotografía 28: Instalaciones eléctricas, enfatice en las que hay que Intervenir (p133)"
  end

  def d_p134
    return  "La unidad de vivienda cuenta con servicios públicos de: Energía (p134)"
  end

  def d_p135
    return  "Estado de servicios públicos en la vivienda de: Energía (p135)"
  end

  def d_p136
    return  "La unidad de vivienda requiere intervención en servicios públicos de: Energía (p136)"
  end

  def d_p137
    return  "La unidad de vivienda cuenta con servicios públicos de: Acueducto (p137)"
  end

  def d_p138
    return  "Estado de servicios públicos en la vivienda de: Acueducto (p138)"
  end

  def d_p139
    return  "La unidad de vivienda requiere intervención en servicios públicos de: Acueducto (p139)"
  end

  def d_p140
    return  "La unidad de vivienda cuenta con servicios públicos de: Alcantarillado (p140)"
  end

  def d_p141
    return  "Estado de servicios públicos en la vivienda de: Alcantarillado (p141)"
  end

  def d_p142
    return  "La unidad de vivienda requiere intervención en servicios públicos de: Alcantarillado (p142)"
  end

  def d_p143
    return  "La unidad de vivienda cuenta con servicios públicos de: Teléfono (línea fija) (p143)"
  end

  def d_p144
    return  "Estado de servicios públicos en la vivienda de: Teléfono (línea fija) (p144)"
  end

  def d_p145
    return  "La unidad de vivienda requiere intervención en servicios públicos de: Teléfono (línea fija) (p145)"
  end

  def d_p146
    return  "La unidad de vivienda cuenta con servicios públicos de: Gas natural (red) (p146)"
  end

  def d_p147
    return  "Estado de servicios públicos en la vivienda de: Gas natural (red) (p147)"
  end

  def d_p148
    return  "La unidad de vivienda requiere intervención en servicios públicos de: Gas natural (red) (p148)"
  end

  def d_p149
    return  "La unidad de vivienda cuenta con servicios públicos de: Aseo (recolección) (p149)"
  end

  def d_p150
    return  "Estado de servicios públicos en la vivienda de: Aseo (recolección) (p150)"
  end

  def d_p151
    return  "La unidad de vivienda requiere intervención en servicios públicos de: Aseo (recolección) (p151)"
  end

  def d_p152
    return  "La unidad de vivienda cuenta con servicios públicos de: Gas en pipeta (p152)"
  end

  def d_p153
    return  "Estado de servicios públicos en la vivienda de: Gas en pipeta (p153)"
  end

  def d_p154
    return  "La unidad de vivienda requiere intervención en servicios públicos de: Gas en pipeta (p154)"
  end

  def d_p155
    return  "La unidad de vivienda cuenta con servicios públicos de: Conexión a internet (p155)"
  end

  def d_p156
    return  "Estado de servicios públicos en la vivienda de: Conexión a internet (p156)"
  end

  def d_p157
    return  "La unidad de vivienda requiere intervención en servicios públicos de: Conexión a internet (p157)"
  end

  def d_p158
    return  "Fotografía 29:  del servicio, enfatice en los que requiere intervención: Energía (p158)"
  end

  def d_p159
    return  "Fotografía 30: del servicio, enfatice en los que requiere intervención: Acueducto (p159)"
  end

  def d_p160
    return  "Fotografía 31: del servicio, enfatice en los que requiere intervención: Alcantarillado (p160)"
  end

  def d_p161
    return  "¿Cuál es el estado de la vivienda en: Canoas y ruanas (p161)"
  end

  def d_p162
    return  "¿Requieren Intervención: Canoas y ruanas? (p162)"
  end

  def d_p163
    return  "¿Cuál es el estado de la vivienda en: Lagrimales (p163)"
  end

  def d_p164
    return  "¿Requieren Intervención: Lagrimales? (p164)"
  end

  def d_p165
    return  "¿Cuál es el estado de la vivienda en: Impermeabilización de losas y cubiertas (p165)"
  end

  def d_p166
    return  "¿Requieren Intervención: Impermeabilización de losas y cubiertas? (p166)"
  end

  def d_p167
    return  "Fotografía 32: de las áreas, enfatice en las que  requieren intervención: Canoas y ruanas (p167)"
  end

  def d_p168
    return  "Fotografía 33: de las áreas, enfatice en las que  requieren intervención:  Impermeabilización de losas y cubiertas (p168)"
  end

  def d_p169
    return  "¿Con qué tipo de servicio sanitario cuenta el hogar y cuál es su estado actual? (p169)"
  end

  def d_p170
    return  "¿Y cuál es su estado actual:  servicio sanitario? (p170)"
  end

  def d_p171
    return  "Requieren Intervención: servicio sanitario? (p171)"
  end

  def d_p172
    return  "Fotografía 34: de los servicios sanitarios, enfatice en los que hay que  intervenir (p172)"
  end

  def d_p173
    return  "Fotografía 35: de los servicios sanitarios, enfatice en los que hay que  intervenir (p173)"
  end

  def d_p174
    return  "¿Cuántos de estos implementos y áreas funcionales tiene esta vivienda: Lavamanos (p174)"
  end

  def d_p175
    return  "Y cuál es su estado: Lavamanos? (p175)"
  end

  def d_p176
    return  "¿¿Requieren intervención: Lavamanos? (p176)"
  end

  def d_p177
    return  "¿Cuántos de estos implementos y áreas funcionales tiene esta vivienda: Duchas (p177)"
  end

  def d_p178
    return  "Y cuál es su estado: Duchas? (p178)"
  end

  def d_p179
    return  "¿¿Requieren intervención: Duchas? (p179)"
  end

  def d_p180
    return  "¿Cuántos de estos implementos y áreas funcionales tiene esta vivienda: Lavadero de Ropa (p180)"
  end

  def d_p181
    return  "Y cuál es su estado: Lavadero de Ropa? (p181)"
  end

  def d_p182
    return  "¿¿Requieren intervención: Lavadero de Ropa? (p182)"
  end

  def d_p183
    return  "Fotografía 36: de los implementos o áreas, enfatice en los que  requiere intervención: Lavamanos (p183)"
  end

  def d_p184
    return  "Fotografía 37: de los implementos o áreas, enfatice en los que  requiere intervención: Duchas (p184)"
  end

  def d_p185
    return  "Fotografía 38: de los implementos o áreas, enfatice en los que  requiere intervención: Lavadero de Ropa (p185)"
  end

  def d_p186
    return  "Esta vivienda, en el último año, se ha visto afectada por: Inundaciones (p186)"
  end

  def d_p187
    return  "Esta vivienda, en el último año, se ha visto afectada por: Avalancha (p187)"
  end

  def d_p188
    return  "Esta vivienda, en el último año, se ha visto afectada por: Deslizamiento (p188)"
  end

  def d_p189
    return  "Esta vivienda, en el último año, se ha visto afectada por: Hundimiento del Terreno (p189)"
  end

  def d_p190
    return  "Esta vivienda, en el último año, se ha visto afectada por: Falla Geológica (p190)"
  end

  def d_p191
    return  "Esta vivienda, en el último año, se ha visto afectada por: Afectaciones de lotes y/o viviendas vecinas (p191)"
  end

  def d_p192
    return  "¿Esta vivienda a sido atendida a través del Programa municipal 'Medellín Solidaria'? (p192)"
  end

  def d_p193
    return  "¿Esta vivienda ha sido visitada por el DAGRD? (p193)"
  end

  def d_p194
    return  "¿Qué tipo de ficha DAGRD tiene? (p194)"
  end

  def d_p198
    return  "Planta o piso en donde se ubica la vivienda de este hogar (p198)"
  end

  def d_p198_1
    return  "Número de Pisos totales (p198_1)"
  end

  def d_p199
    return  "Visita atendida por: (p199)"
  end

  def d_p200
    return  "Visita realizada por: (p200)"
  end

  def d_p201
    return  "Observaciones (p201)"
  end

  def d_p202
    return  "Estiquer (p202)"
  end

  def d_empadronador
    return  "Quién realizó la Encuesta (empadronador)"
  end

  def d_supervisor
    return  "Nombre del Supervisor (supervisor)"
  end

  def d_coordinador
    return  "Nombre del Coordinador en trabajo de Campo (coordinador)"
  end

  def verifieddoc(id)
    f1 = id.gsub("img","")
    f2 = f1.split("P")
    valor = "#{Sifi.find(34).valor.to_s}/#{f2[0].to_s}/min_#{id.to_s}.jpg"
    #valor = "d:/#{f2[0].to_s}/min_#{id.to_s}.jpg"
    return File.exist?(valor)
  end

  def self.search (fase2censo,fchinicial,fchfinal,areatotal1,areatotal2,areaconst1,areaconst2,areaocupa1,areaocupa2,pagina,page)
    cadena = ""
    if fase2censo.noform.to_s != ""
      if cadena != ""
        cadena = cadena + ' and noform = ' + "'#{fase2censo.noform.to_s}'"
      else
        cadena = ' noform = ' + "'#{fase2censo.noform.to_s}'"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      else
        cadena = ' substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      end
     end
     if areatotal1.to_s != "" and areatotal2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        else
          cadena = cadena + ' p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        end
      end
      if areaconst1.to_s != "" and areaconst2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        else
          cadena = cadena + ' p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        end
      end
      if areaocupa1.to_s != "" and areaocupa2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p62 between ' + "'#{areaocupa1.to_s}'" + ' and ' + "'#{areaocupa2.to_s}'"
        else
          cadena = cadena + ' p62 between ' + "'#{areaocupa1.to_s}'" + ' and ' + "'#{areaocupa2.to_s}'"
        end
      end
    if fase2censo.p4.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      else
        cadena = ' substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      end
    end
    if fase2censo.p5.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      else
        cadena = ' substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      end
    end
    if fase2censo.p11.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11 = ' + "'#{fase2censo.p11.to_s}'"
      else
        cadena = ' p11 = ' + "'#{fase2censo.p11.to_s}'"
      end
    end
    if fase2censo.p11_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      else
        cadena = ' p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      end
    end
    if fase2censo.p12.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12 = ' + "'#{fase2censo.p12.to_s}'"
      else
        cadena = ' p12 = ' + "'#{fase2censo.p12.to_s}'"
      end
    end
    if fase2censo.p12_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      else
        cadena = ' p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      end
    end
    if fase2censo.p13.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p13 = ' + "'#{fase2censo.p13.to_s}'"
      else
        cadena = ' p13 = ' + "'#{fase2censo.p13.to_s}'"
      end
    end
    if fase2censo.p50.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p50 = ' + "'#{fase2censo.p50.to_s}'"
      else
        cadena = ' p50 = ' + "'#{fase2censo.p50.to_s}'"
      end
    end
    if fase2censo.p52.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p52 = ' + "'#{fase2censo.p52.to_s}'"
      else
        cadena = ' p52 = ' + "'#{fase2censo.p52.to_s}'"
      end
    end
    if fase2censo.p53.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p53 = ' + "'#{fase2censo.p53.to_s}'"
      else
        cadena = ' p53 = ' + "'#{fase2censo.p53.to_s}'"
      end
    end
    if fase2censo.p54.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p54 = ' + "'#{fase2censo.p54.to_s}'"
      else
        cadena = ' p54 = ' + "'#{fase2censo.p54.to_s}'"
      end
    end
    if fase2censo.p55.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p55 = ' + "'#{fase2censo.p55.to_s}'"
      else
        cadena = ' p55 = ' + "'#{fase2censo.p55.to_s}'"
      end
    end
    if fase2censo.p56.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p56 = ' + "'#{fase2censo.p56.to_s}'"
      else
        cadena = ' p56 = ' + "'#{fase2censo.p56.to_s}'"
      end
    end
    if fase2censo.p57.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p57 = ' + "'#{fase2censo.p57.to_s}'"
      else
        cadena = ' p57 = ' + "'#{fase2censo.p57.to_s}'"
      end
    end
    if fase2censo.p58.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p58 = ' + "'#{fase2censo.p58.to_s}'"
      else
        cadena = ' p58 = ' + "'#{fase2censo.p58.to_s}'"
      end
    end
    if fase2censo.p59.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p59 = ' + "'#{fase2censo.p59.to_s}'"
      else
        cadena = ' p59 = ' + "'#{fase2censo.p59.to_s}'"
      end
    end
    if fase2censo.p60.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p60 = ' + "'#{fase2censo.p60.to_s}'"
      else
        cadena = ' p60 = ' + "'#{fase2censo.p60.to_s}'"
      end
    end
    if fase2censo.p61.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p61 = ' + "'#{fase2censo.p61.to_s}'"
      else
        cadena = ' p61 = ' + "'#{fase2censo.p61.to_s}'"
      end
    end
    if fase2censo.p63.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p63 = ' + "'#{fase2censo.p63.to_s}'"
      else
        cadena = ' p63 = ' + "'#{fase2censo.p63.to_s}'"
      end
    end
    if cadena != ""
      if pagina.to_s == 'SI'
        paginate :per_page => 10,
                 :page => page,
                 :conditions => [cadena],
                 :order => 'id'
      else
        find(:all, :conditions => [cadena], :order => "id")
      end
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
    end
  end

  def self.search2 (fase2censo,fchinicial,fchfinal,areatotal1,areatotal2,areaconst1,areaconst2,pagina,page)
    cadena = ""
    if fase2censo.noform.to_s != ""
      if cadena != ""
        cadena = cadena + ' and noform = ' + "'#{fase2censo.noform.to_s}'"
      else
        cadena = ' noform = ' + "'#{fase2censo.noform.to_s}'"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      else
        cadena = ' substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      end
     end
     if areatotal1.to_s != "" and areatotal2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        else
          cadena = cadena + ' p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        end
      end
      if areaconst1.to_s != "" and areaconst2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        else
          cadena = cadena + ' p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        end
      end    
    if fase2censo.p4.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      else
        cadena = ' substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      end
    end
    if fase2censo.p5.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      else
        cadena = ' substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      end
    end
    if fase2censo.p11.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11 = ' + "'#{fase2censo.p11.to_s}'"
      else
        cadena = ' p11 = ' + "'#{fase2censo.p11.to_s}'"
      end
    end
    if fase2censo.p11_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      else
        cadena = ' p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      end
    end
    if fase2censo.p12.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12 = ' + "'#{fase2censo.p12.to_s}'"
      else
        cadena = ' p12 = ' + "'#{fase2censo.p12.to_s}'"
      end
    end
    if fase2censo.p12_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      else
        cadena = ' p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      end
    end
    if fase2censo.p13.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p13 = ' + "'#{fase2censo.p13.to_s}'"
      else
        cadena = ' p13 = ' + "'#{fase2censo.p13.to_s}'"
      end
    end
    if fase2censo.p14.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p14 = ' + "'#{fase2censo.p14.to_s}'"
      else
        cadena = ' p14 = ' + "'#{fase2censo.p14.to_s}'"
      end
    end
    if fase2censo.p16.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p16 = ' + "'#{fase2censo.p16.to_s}'"
      else
        cadena = ' p16 = ' + "'#{fase2censo.p16.to_s}'"
      end
    end
    if fase2censo.p22.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p22 = ' + "'#{fase2censo.p22.to_s}'"
      else
        cadena = ' p22 = ' + "'#{fase2censo.p22.to_s}'"
      end
    end
    if fase2censo.p23.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p23 = ' + "'#{fase2censo.p23.to_s}'"
      else
        cadena = ' p23 = ' + "'#{fase2censo.p23.to_s}'"
      end
    end
    if fase2censo.p24.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p24 = ' + "'#{fase2censo.p24.to_s}'"
      else
        cadena = ' p24 = ' + "'#{fase2censo.p24.to_s}'"
      end
    end
    if fase2censo.p25.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p25 = ' + "'#{fase2censo.p25.to_s}'"
      else
        cadena = ' p25 = ' + "'#{fase2censo.p25.to_s}'"
      end
    end
    if fase2censo.p26.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p26 = ' + "'#{fase2censo.p26.to_s}'"
      else
        cadena = ' p26 = ' + "'#{fase2censo.p26.to_s}'"
      end
    end
    if fase2censo.p27.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p27 = ' + "'#{fase2censo.p27.to_s}'"
      else
        cadena = ' p27 = ' + "'#{fase2censo.p27.to_s}'"
      end
    end
    if fase2censo.p28.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p28 = ' + "'#{fase2censo.p28.to_s}'"
      else
        cadena = ' p28 = ' + "'#{fase2censo.p28.to_s}'"
      end
    end
    if fase2censo.p30.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p30 = ' + "'#{fase2censo.p30.to_s}'"
      else
        cadena = ' p30 = ' + "'#{fase2censo.p30.to_s}'"
      end
    end
    if fase2censo.p31.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p31 = ' + "'#{fase2censo.p31.to_s}'"
      else
        cadena = ' p31 = ' + "'#{fase2censo.p31.to_s}'"
      end
    end
    if fase2censo.p32.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p32 = ' + "'#{fase2censo.p32.to_s}'"
      else
        cadena = ' p32 = ' + "'#{fase2censo.p32.to_s}'"
      end
    end
    if fase2censo.p32.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p32 = ' + "'#{fase2censo.p32.to_s}'"
      else
        cadena = ' p32 = ' + "'#{fase2censo.p32.to_s}'"
      end
    end
    if fase2censo.p33.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p33 = ' + "'#{fase2censo.p33.to_s}'"
      else
        cadena = ' p33 = ' + "'#{fase2censo.p33.to_s}'"
      end
    end
    if fase2censo.p34.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p34 = ' + "'#{fase2censo.p34.to_s}'"
      else
        cadena = ' p34 = ' + "'#{fase2censo.p34.to_s}'"
      end
    end
    if fase2censo.p35.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p35 = ' + "'#{fase2censo.p35.to_s}'"
      else
        cadena = ' p35 = ' + "'#{fase2censo.p35.to_s}'"
      end
    end
    if fase2censo.p36.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p36 = ' + "'#{fase2censo.p36.to_s}'"
      else
        cadena = ' p36 = ' + "'#{fase2censo.p36.to_s}'"
      end
    end
    if fase2censo.p37.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p37 = ' + "'#{fase2censo.p37.to_s}'"
      else
        cadena = ' p37 = ' + "'#{fase2censo.p37.to_s}'"
      end
    end
    if fase2censo.p38.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p38 = ' + "'#{fase2censo.p38.to_s}'"
      else
        cadena = ' p38 = ' + "'#{fase2censo.p38.to_s}'"
      end
    end
    if fase2censo.p39.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p39 = ' + "'#{fase2censo.p39.to_s}'"
      else
        cadena = ' p39 = ' + "'#{fase2censo.p39.to_s}'"
      end
    end
    if fase2censo.p40.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p40 = ' + "'#{fase2censo.p40.to_s}'"
      else
        cadena = ' p40 = ' + "'#{fase2censo.p40.to_s}'"
      end
    end
    if fase2censo.p40_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p40_1 = ' + "'#{fase2censo.p40_1.to_s}'"
      else
        cadena = ' p40_1 = ' + "'#{fase2censo.p40_1.to_s}'"
      end
    end
    if fase2censo.p41.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p41 = ' + "'#{fase2censo.p41.to_s}'"
      else
        cadena = ' p41 = ' + "'#{fase2censo.p41.to_s}'"
      end
    end
    if fase2censo.p41_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p41_1 = ' + "'#{fase2censo.p41_1.to_s}'"
      else
        cadena = ' p41_1 = ' + "'#{fase2censo.p41_1.to_s}'"
      end
    end
    if fase2censo.p42.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p42 = ' + "'#{fase2censo.p42.to_s}'"
      else
        cadena = ' p42 = ' + "'#{fase2censo.p42.to_s}'"
      end
    end
    if fase2censo.p42_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p42_1 = ' + "'#{fase2censo.p42_1.to_s}'"
      else
        cadena = ' p42_1 = ' + "'#{fase2censo.p42_1.to_s}'"
      end
    end
    if fase2censo.p102.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p102 = ' + "'#{fase2censo.p102.to_s}'"
      else
        cadena = ' p102 = ' + "'#{fase2censo.p102.to_s}'"
      end
    end
    if fase2censo.p103.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p103 = ' + "'#{fase2censo.p103.to_s}'"
      else
        cadena = ' p103 = ' + "'#{fase2censo.p103.to_s}'"
      end
    end
    if fase2censo.p104.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p104 = ' + "'#{fase2censo.p104.to_s}'"
      else
        cadena = ' p104 = ' + "'#{fase2censo.p104.to_s}'"
      end
    end
    if fase2censo.p105.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p105 = ' + "'#{fase2censo.p105.to_s}'"
      else
        cadena = ' p105 = ' + "'#{fase2censo.p105.to_s}'"
      end
    end
    if fase2censo.p106.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p106 = ' + "'#{fase2censo.p106.to_s}'"
      else
        cadena = ' p106 = ' + "'#{fase2censo.p106.to_s}'"
      end
    end
    if fase2censo.p107.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p107 = ' + "'#{fase2censo.p107.to_s}'"
      else
        cadena = ' p107 = ' + "'#{fase2censo.p107.to_s}'"
      end
    end
    if fase2censo.p108.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p108 = ' + "'#{fase2censo.p108.to_s}'"
      else
        cadena = ' p108 = ' + "'#{fase2censo.p108.to_s}'"
      end
    end
    if fase2censo.p109.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p109 = ' + "'#{fase2censo.p109.to_s}'"
      else
        cadena = ' p109 = ' + "'#{fase2censo.p109.to_s}'"
      end
    end
    if fase2censo.p110.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p110 = ' + "'#{fase2censo.p110.to_s}'"
      else
        cadena = ' p110 = ' + "'#{fase2censo.p110.to_s}'"
      end
    end
    if fase2censo.p115.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p115 = ' + "'#{fase2censo.p115.to_s}'"
      else
        cadena = ' p115 = ' + "'#{fase2censo.p115.to_s}'"
      end
    end
    if fase2censo.p169.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p169 = ' + "'#{fase2censo.p169.to_s}'"
      else
        cadena = ' p169 = ' + "'#{fase2censo.p169.to_s}'"
      end
    end
    if fase2censo.p170.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p170 = ' + "'#{fase2censo.p170.to_s}'"
      else
        cadena = ' p170 = ' + "'#{fase2censo.p170.to_s}'"
      end
    end
    if fase2censo.p171.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p171 = ' + "'#{fase2censo.p171.to_s}'"
      else
        cadena = ' p171 = ' + "'#{fase2censo.p171.to_s}'"
      end
    end
    if fase2censo.p174.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p174 = ' + "'#{fase2censo.p174.to_s}'"
      else
        cadena = ' p174 = ' + "'#{fase2censo.p174.to_s}'"
      end
    end
    if fase2censo.p175.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p175 = ' + "'#{fase2censo.p175.to_s}'"
      else
        cadena = ' p175 = ' + "'#{fase2censo.p175.to_s}'"
      end
    end
    if fase2censo.p176.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p176 = ' + "'#{fase2censo.p176.to_s}'"
      else
        cadena = ' p176 = ' + "'#{fase2censo.p176.to_s}'"
      end
    end
    if fase2censo.p177.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p177 = ' + "'#{fase2censo.p177.to_s}'"
      else
        cadena = ' p177 = ' + "'#{fase2censo.p177.to_s}'"
      end
    end
    if fase2censo.p178.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p178 = ' + "'#{fase2censo.p178.to_s}'"
      else
        cadena = ' p178 = ' + "'#{fase2censo.p178.to_s}'"
      end
    end
    if fase2censo.p179.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p179 = ' + "'#{fase2censo.p179.to_s}'"
      else
        cadena = ' p179 = ' + "'#{fase2censo.p179.to_s}'"
      end
    end
    if fase2censo.p180.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p180 = ' + "'#{fase2censo.p180.to_s}'"
      else
        cadena = ' p180 = ' + "'#{fase2censo.p180.to_s}'"
      end
    end
    if fase2censo.p181.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p181 = ' + "'#{fase2censo.p181.to_s}'"
      else
        cadena = ' p181 = ' + "'#{fase2censo.p181.to_s}'"
      end
    end
    if fase2censo.p182.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p182 = ' + "'#{fase2censo.p182.to_s}'"
      else
        cadena = ' p182 = ' + "'#{fase2censo.p182.to_s}'"
      end
    end
    if cadena != ""
      if pagina.to_s == 'SI'
        paginate :per_page => 10,
                 :page => page,
                 :conditions => [cadena],
                 :order => 'id'
      else
        find(:all, :conditions => [cadena], :order => "id")
      end
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
    end
  end

  def self.search3 (fase2censo,fchinicial,fchfinal,areatotal1,areatotal2,areaconst1,areaconst2,pagina,page)
    cadena = ""
    if fase2censo.noform.to_s != ""
      if cadena != ""
        cadena = cadena + ' and noform = ' + "'#{fase2censo.noform.to_s}'"
      else
        cadena = ' noform = ' + "'#{fase2censo.noform.to_s}'"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      else
        cadena = ' substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      end
     end
     if areatotal1.to_s != "" and areatotal2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        else
          cadena = cadena + ' p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        end
      end
      if areaconst1.to_s != "" and areaconst2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        else
          cadena = cadena + ' p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        end
      end
    if fase2censo.p4.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      else
        cadena = ' substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      end
    end
    if fase2censo.p5.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      else
        cadena = ' substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      end
    end
    if fase2censo.p11.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11 = ' + "'#{fase2censo.p11.to_s}'"
      else
        cadena = ' p11 = ' + "'#{fase2censo.p11.to_s}'"
      end
    end
    if fase2censo.p11_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      else
        cadena = ' p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      end
    end
    if fase2censo.p12.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12 = ' + "'#{fase2censo.p12.to_s}'"
      else
        cadena = ' p12 = ' + "'#{fase2censo.p12.to_s}'"
      end
    end
    if fase2censo.p12_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      else
        cadena = ' p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      end
    end
    if fase2censo.p13.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p13 = ' + "'#{fase2censo.p13.to_s}'"
      else
        cadena = ' p13 = ' + "'#{fase2censo.p13.to_s}'"
      end
    end
    if fase2censo.p87.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p87 = ' + "'#{fase2censo.p87.to_s}'"
      else
        cadena = ' p87 = ' + "'#{fase2censo.p87.to_s}'"
      end
    end
    if fase2censo.p88.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p88 = ' + "'#{fase2censo.p88.to_s}'"
      else
        cadena = ' p88 = ' + "'#{fase2censo.p88.to_s}'"
      end
    end
    if fase2censo.p89.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p89 = ' + "'#{fase2censo.p89.to_s}'"
      else
        cadena = ' p89 = ' + "'#{fase2censo.p89.to_s}'"
      end
    end
    if fase2censo.p91.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p91 = ' + "'#{fase2censo.p91.to_s}'"
      else
        cadena = ' p91 = ' + "'#{fase2censo.p91.to_s}'"
      end
    end
    if fase2censo.p92.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p92 = ' + "'#{fase2censo.p92.to_s}'"
      else
        cadena = ' p92 = ' + "'#{fase2censo.p92.to_s}'"
      end
    end
    if fase2censo.p92_2.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p92_2 = ' + "'#{fase2censo.p92_2.to_s}'"
      else
        cadena = ' p92_2 = ' + "'#{fase2censo.p92_2.to_s}'"
      end
    end
    if fase2censo.p93.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p93 = ' + "'#{fase2censo.p93.to_s}'"
      else
        cadena = ' p93 = ' + "'#{fase2censo.p93.to_s}'"
      end
    end
    if fase2censo.p94.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p94 = ' + "'#{fase2censo.p94.to_s}'"
      else
        cadena = ' p94 = ' + "'#{fase2censo.p94.to_s}'"
      end
    end
    if fase2censo.p97.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p97 = ' + "'#{fase2censo.p97.to_s}'"
      else
        cadena = ' p97 = ' + "'#{fase2censo.p97.to_s}'"
      end
    end
    if fase2censo.p98.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p98 = ' + "'#{fase2censo.p98.to_s}'"
      else
        cadena = ' p98 = ' + "'#{fase2censo.p98.to_s}'"
      end
    end
    if fase2censo.p99.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p99 = ' + "'#{fase2censo.p99.to_s}'"
      else
        cadena = ' p99 = ' + "'#{fase2censo.p99.to_s}'"
      end
    end
    if fase2censo.p116.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p116 = ' + "'#{fase2censo.p116.to_s}'"
      else
        cadena = ' p116 = ' + "'#{fase2censo.p116.to_s}'"
      end
    end
    if fase2censo.p117.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p117 = ' + "'#{fase2censo.p117.to_s}'"
      else
        cadena = ' p117 = ' + "'#{fase2censo.p117.to_s}'"
      end
    end
    if fase2censo.p118.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p118 = ' + "'#{fase2censo.p118.to_s}'"
      else
        cadena = ' p118 = ' + "'#{fase2censo.p118.to_s}'"
      end
    end
    if fase2censo.p119.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p119 = ' + "'#{fase2censo.p119.to_s}'"
      else
        cadena = ' p119 = ' + "'#{fase2censo.p119.to_s}'"
      end
    end
    if fase2censo.p120.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p120 = ' + "'#{fase2censo.p120.to_s}'"
      else
        cadena = ' p120 = ' + "'#{fase2censo.p120.to_s}'"
      end
    end
    if fase2censo.p121.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p121 = ' + "'#{fase2censo.p121.to_s}'"
      else
        cadena = ' p121 = ' + "'#{fase2censo.p121.to_s}'"
      end
    end
    if fase2censo.p122.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p122 = ' + "'#{fase2censo.p122.to_s}'"
      else
        cadena = ' p122 = ' + "'#{fase2censo.p122.to_s}'"
      end
    end
    if fase2censo.p123.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p123 = ' + "'#{fase2censo.p123.to_s}'"
      else
        cadena = ' p123 = ' + "'#{fase2censo.p123.to_s}'"
      end
    end
    if fase2censo.p124.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p124 = ' + "'#{fase2censo.p124.to_s}'"
      else
        cadena = ' p124 = ' + "'#{fase2censo.p124.to_s}'"
      end
    end
    if fase2censo.p161.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p161 = ' + "'#{fase2censo.p161.to_s}'"
      else
        cadena = ' p161 = ' + "'#{fase2censo.p161.to_s}'"
      end
    end
    if fase2censo.p162.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p162 = ' + "'#{fase2censo.p162.to_s}'"
      else
        cadena = ' p162 = ' + "'#{fase2censo.p162.to_s}'"
      end
    end
    if fase2censo.p163.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p163 = ' + "'#{fase2censo.p163.to_s}'"
      else
        cadena = ' p163 = ' + "'#{fase2censo.p163.to_s}'"
      end
    end
    if fase2censo.p164.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p164 = ' + "'#{fase2censo.p164.to_s}'"
      else
        cadena = ' p164 = ' + "'#{fase2censo.p164.to_s}'"
      end
    end
    if fase2censo.p165.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p165 = ' + "'#{fase2censo.p165.to_s}'"
      else
        cadena = ' p165 = ' + "'#{fase2censo.p165.to_s}'"
      end
    end
    if fase2censo.p166.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p166 = ' + "'#{fase2censo.p166.to_s}'"
      else
        cadena = ' p166 = ' + "'#{fase2censo.p166.to_s}'"
      end
    end
    if cadena != ""
      if pagina.to_s == 'SI'
        paginate :per_page => 10,
                 :page => page,
                 :conditions => [cadena],
                 :order => 'id'
      else
        find(:all, :conditions => [cadena], :order => "id")
      end
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
    end
  end

  def self.search4 (fase2censo,fchinicial,fchfinal,areatotal1,areatotal2,areaconst1,areaconst2,pagina,page)
    cadena = ""
    if fase2censo.noform.to_s != ""
      if cadena != ""
        cadena = cadena + ' and noform = ' + "'#{fase2censo.noform.to_s}'"
      else
        cadena = ' noform = ' + "'#{fase2censo.noform.to_s}'"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      else
        cadena = ' substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      end
     end
     if areatotal1.to_s != "" and areatotal2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        else
          cadena = cadena + ' p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        end
      end
      if areaconst1.to_s != "" and areaconst2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        else
          cadena = cadena + ' p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        end
      end
    if fase2censo.p4.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      else
        cadena = ' substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      end
    end
    if fase2censo.p5.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      else
        cadena = ' substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      end
    end
    if fase2censo.p11.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11 = ' + "'#{fase2censo.p11.to_s}'"
      else
        cadena = ' p11 = ' + "'#{fase2censo.p11.to_s}'"
      end
    end
    if fase2censo.p11_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      else
        cadena = ' p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      end
    end
    if fase2censo.p12.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12 = ' + "'#{fase2censo.p12.to_s}'"
      else
        cadena = ' p12 = ' + "'#{fase2censo.p12.to_s}'"
      end
    end
    if fase2censo.p12_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      else
        cadena = ' p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      end
    end
    if fase2censo.p13.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p13 = ' + "'#{fase2censo.p13.to_s}'"
      else
        cadena = ' p13 = ' + "'#{fase2censo.p13.to_s}'"
      end
    end
    if fase2censo.p130.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p130 = ' + "'#{fase2censo.p130.to_s}'"
      else
        cadena = ' p130 = ' + "'#{fase2censo.p130.to_s}'"
      end
    end
    if fase2censo.p131.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p131 = ' + "'#{fase2censo.p131.to_s}'"
      else
        cadena = ' p131 = ' + "'#{fase2censo.p131.to_s}'"
      end
    end
    if fase2censo.p134.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p134 = ' + "'#{fase2censo.p134.to_s}'"
      else
        cadena = ' p134 = ' + "'#{fase2censo.p134.to_s}'"
      end
    end
    if fase2censo.p135.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p135 = ' + "'#{fase2censo.p135.to_s}'"
      else
        cadena = ' p135 = ' + "'#{fase2censo.p135.to_s}'"
      end
    end
    if fase2censo.p136.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p136 = ' + "'#{fase2censo.p136.to_s}'"
      else
        cadena = ' p136 = ' + "'#{fase2censo.p136.to_s}'"
      end
    end
    if fase2censo.p137.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p137 = ' + "'#{fase2censo.p137.to_s}'"
      else
        cadena = ' p137 = ' + "'#{fase2censo.p137.to_s}'"
      end
    end
    if fase2censo.p138.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p138 = ' + "'#{fase2censo.p138.to_s}'"
      else
        cadena = ' p138 = ' + "'#{fase2censo.p138.to_s}'"
      end
    end
    if fase2censo.p139.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p139 = ' + "'#{fase2censo.p139.to_s}'"
      else
        cadena = ' p139 = ' + "'#{fase2censo.p139.to_s}'"
      end
    end
    if fase2censo.p140.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p140 = ' + "'#{fase2censo.p140.to_s}'"
      else
        cadena = ' p140 = ' + "'#{fase2censo.p140.to_s}'"
      end
    end
    if fase2censo.p141.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p141 = ' + "'#{fase2censo.p141.to_s}'"
      else
        cadena = ' p141 = ' + "'#{fase2censo.p141.to_s}'"
      end
    end
    if fase2censo.p142.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p142 = ' + "'#{fase2censo.p142.to_s}'"
      else
        cadena = ' p142 = ' + "'#{fase2censo.p142.to_s}'"
      end
    end
    if fase2censo.p143.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p143 = ' + "'#{fase2censo.p143.to_s}'"
      else
        cadena = ' p143 = ' + "'#{fase2censo.p143.to_s}'"
      end
    end
    if fase2censo.p144.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p144 = ' + "'#{fase2censo.p144.to_s}'"
      else
        cadena = ' p144 = ' + "'#{fase2censo.p144.to_s}'"
      end
    end
    if fase2censo.p145.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p145 = ' + "'#{fase2censo.p145.to_s}'"
      else
        cadena = ' p145 = ' + "'#{fase2censo.p145.to_s}'"
      end
    end
    if fase2censo.p146.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p146 = ' + "'#{fase2censo.p146.to_s}'"
      else
        cadena = ' p146 = ' + "'#{fase2censo.p146.to_s}'"
      end
    end
    if fase2censo.p147.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p147 = ' + "'#{fase2censo.p147.to_s}'"
      else
        cadena = ' p147 = ' + "'#{fase2censo.p147.to_s}'"
      end
    end
    if fase2censo.p148.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p148 = ' + "'#{fase2censo.p148.to_s}'"
      else
        cadena = ' p148 = ' + "'#{fase2censo.p148.to_s}'"
      end
    end
    if fase2censo.p149.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p149 = ' + "'#{fase2censo.p149.to_s}'"
      else
        cadena = ' p149 = ' + "'#{fase2censo.p149.to_s}'"
      end
    end
    if fase2censo.p150.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p150 = ' + "'#{fase2censo.p150.to_s}'"
      else
        cadena = ' p150 = ' + "'#{fase2censo.p150.to_s}'"
      end
    end
    if fase2censo.p151.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p151 = ' + "'#{fase2censo.p151.to_s}'"
      else
        cadena = ' p151 = ' + "'#{fase2censo.p151.to_s}'"
      end
    end
    if fase2censo.p152.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p152 = ' + "'#{fase2censo.p152.to_s}'"
      else
        cadena = ' p152 = ' + "'#{fase2censo.p152.to_s}'"
      end
    end
    if fase2censo.p153.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p153 = ' + "'#{fase2censo.p153.to_s}'"
      else
        cadena = ' p153 = ' + "'#{fase2censo.p153.to_s}'"
      end
    end
    if fase2censo.p154.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p154 = ' + "'#{fase2censo.p154.to_s}'"
      else
        cadena = ' p154 = ' + "'#{fase2censo.p154.to_s}'"
      end
    end
    if fase2censo.p155.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p155 = ' + "'#{fase2censo.p155.to_s}'"
      else
        cadena = ' p155 = ' + "'#{fase2censo.p155.to_s}'"
      end
    end
    if fase2censo.p156.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p156 = ' + "'#{fase2censo.p156.to_s}'"
      else
        cadena = ' p156 = ' + "'#{fase2censo.p156.to_s}'"
      end
    end
    if fase2censo.p157.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p157 = ' + "'#{fase2censo.p157.to_s}'"
      else
        cadena = ' p157 = ' + "'#{fase2censo.p157.to_s}'"
      end
    end
    if cadena != ""
      if pagina.to_s == 'SI'
        paginate :per_page => 10,
                 :page => page,
                 :conditions => [cadena],
                 :order => 'id'
      else
        find(:all, :conditions => [cadena], :order => "id")
      end
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
    end
  end
  
  def self.search5 (fase2censo,fchinicial,fchfinal,areatotal1,areatotal2,areaconst1,areaconst2,pagina,page)
    cadena = ""
    if fase2censo.noform.to_s != ""
      if cadena != ""
        cadena = cadena + ' and noform = ' + "'#{fase2censo.noform.to_s}'"
      else
        cadena = ' noform = ' + "'#{fase2censo.noform.to_s}'"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      else
        cadena = ' substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      end
     end
     if areatotal1.to_s != "" and areatotal2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        else
          cadena = cadena + ' p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        end
      end
      if areaconst1.to_s != "" and areaconst2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        else
          cadena = cadena + ' p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        end
      end
    if fase2censo.p4.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      else
        cadena = ' substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      end
    end
    if fase2censo.p5.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      else
        cadena = ' substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      end
    end
    if fase2censo.p11.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11 = ' + "'#{fase2censo.p11.to_s}'"
      else
        cadena = ' p11 = ' + "'#{fase2censo.p11.to_s}'"
      end
    end
    if fase2censo.p11_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      else
        cadena = ' p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      end
    end
    if fase2censo.p12.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12 = ' + "'#{fase2censo.p12.to_s}'"
      else
        cadena = ' p12 = ' + "'#{fase2censo.p12.to_s}'"
      end
    end
    if fase2censo.p12_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      else
        cadena = ' p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      end
    end
    if fase2censo.p13.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p13 = ' + "'#{fase2censo.p13.to_s}'"
      else
        cadena = ' p13 = ' + "'#{fase2censo.p13.to_s}'"
      end
    end
    if fase2censo.p186.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p186 = ' + "'#{fase2censo.p186.to_s}'"
      else
        cadena = ' p186 = ' + "'#{fase2censo.p186.to_s}'"
      end
    end
    if fase2censo.p187.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p187 = ' + "'#{fase2censo.p187.to_s}'"
      else
        cadena = ' p187 = ' + "'#{fase2censo.p187.to_s}'"
      end
    end
    if fase2censo.p188.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p188 = ' + "'#{fase2censo.p188.to_s}'"
      else
        cadena = ' p188 = ' + "'#{fase2censo.p188.to_s}'"
      end
    end
    if fase2censo.p189.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p189 = ' + "'#{fase2censo.p189.to_s}'"
      else
        cadena = ' p189 = ' + "'#{fase2censo.p189.to_s}'"
      end
    end
    if fase2censo.p190.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p190 = ' + "'#{fase2censo.p190.to_s}'"
      else
        cadena = ' p190 = ' + "'#{fase2censo.p190.to_s}'"
      end
    end
    if fase2censo.p191.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p191 = ' + "'#{fase2censo.p191.to_s}'"
      else
        cadena = ' p191 = ' + "'#{fase2censo.p191.to_s}'"
      end
    end
    if fase2censo.p193.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p193 = ' + "'#{fase2censo.p193.to_s}'"
      else
        cadena = ' p193 = ' + "'#{fase2censo.p193.to_s}'"
      end
    end
    if fase2censo.p194.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p194 = ' + "'#{fase2censo.p194.to_s}'"
      else
        cadena = ' p194 = ' + "'#{fase2censo.p194.to_s}'"
      end
    end    
    if cadena != ""
      if pagina.to_s == 'SI'
        paginate :per_page => 10,
                 :page => page,
                 :conditions => [cadena],
                 :order => 'id'
      else
        find(:all, :conditions => [cadena], :order => "id")
      end
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
    end
  end

  def self.search6 (fase2censo,fchinicial,fchfinal,areatotal1,areatotal2,areaconst1,areaconst2,pagina,page)
    cadena = ""
    if fase2censo.noform.to_s != ""
      if cadena != ""
        cadena = cadena + ' and noform = ' + "'#{fase2censo.noform.to_s}'"
      else
        cadena = ' noform = ' + "'#{fase2censo.noform.to_s}'"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      else
        cadena = ' substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      end
     end
     if areatotal1.to_s != "" and areatotal2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        else
          cadena = cadena + ' p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        end
      end
      if areaconst1.to_s != "" and areaconst2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        else
          cadena = cadena + ' p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        end
      end
    if fase2censo.p4.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      else
        cadena = ' substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      end
    end
    if fase2censo.p5.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      else
        cadena = ' substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      end
    end
    if fase2censo.p11.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11 = ' + "'#{fase2censo.p11.to_s}'"
      else
        cadena = ' p11 = ' + "'#{fase2censo.p11.to_s}'"
      end
    end
    if fase2censo.p11_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      else
        cadena = ' p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      end
    end
    if fase2censo.p12.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12 = ' + "'#{fase2censo.p12.to_s}'"
      else
        cadena = ' p12 = ' + "'#{fase2censo.p12.to_s}'"
      end
    end
    if fase2censo.p12_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      else
        cadena = ' p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      end
    end
    if fase2censo.p13.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p13 = ' + "'#{fase2censo.p13.to_s}'"
      else
        cadena = ' p13 = ' + "'#{fase2censo.p13.to_s}'"
      end
    end
    if fase2censo.p78.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p78 = ' + "'#{fase2censo.p78.to_s}'"
      else
        cadena = ' p78 = ' + "'#{fase2censo.p78.to_s}'"
      end
    end
    if fase2censo.p79.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p79 = ' + "'#{fase2censo.p79.to_s}'"
      else
        cadena = ' p79 = ' + "'#{fase2censo.p79.to_s}'"
      end
    end
    if fase2censo.p80.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p80 = ' + "'#{fase2censo.p80.to_s}'"
      else
        cadena = ' p80 = ' + "'#{fase2censo.p80.to_s}'"
      end
    end
    if fase2censo.p81.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p81 = ' + "'#{fase2censo.p81.to_s}'"
      else
        cadena = ' p81 = ' + "'#{fase2censo.p81.to_s}'"
      end
    end
    if fase2censo.p82.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p82 = ' + "'#{fase2censo.p82.to_s}'"
      else
        cadena = ' p82 = ' + "'#{fase2censo.p82.to_s}'"
      end
    end
    if fase2censo.p83.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p83 = ' + "'#{fase2censo.p83.to_s}'"
      else
        cadena = ' p83 = ' + "'#{fase2censo.p83.to_s}'"
      end
    end
    if fase2censo.p108.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p108 = ' + "'#{fase2censo.p108.to_s}'"
      else
        cadena = ' p108 = ' + "'#{fase2censo.p108.to_s}'"
      end
    end
    if cadena != ""
      if pagina.to_s == 'SI'
        paginate :per_page => 10,
                 :page => page,
                 :conditions => [cadena],
                 :order => 'id'
      else
        find(:all, :conditions => [cadena], :order => "id")
      end
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
    end
  end

  def self.search7 (fase2censo,fchinicial,fchfinal,areatotal1,areatotal2,areaconst1,areaconst2,pagina,page)
    cadena = ""
    if fase2censo.noform.to_s != ""
      if cadena != ""
        cadena = cadena + ' and noform = ' + "'#{fase2censo.noform.to_s}'"
      else
        cadena = ' noform = ' + "'#{fase2censo.noform.to_s}'"
      end
    end
    if fchinicial.to_s != "" and fchfinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      else
        cadena = ' substr(p1,1,10) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}'"
      end
     end
     if areatotal1.to_s != "" and areatotal2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        else
          cadena = cadena + ' p9 between ' + "'#{areatotal1.to_s}'" + ' and ' + "'#{areatotal2.to_s}'"
        end
      end
      if areaconst1.to_s != "" and areaconst2.to_s != ""
        if cadena != ""
          cadena = cadena + ' and p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        else
          cadena = cadena + ' p10 between ' + "'#{areaconst1.to_s}'" + ' and ' + "'#{areaconst2.to_s}'"
        end
      end
    if fase2censo.p4.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      else
        cadena = ' substr(p5,3,2) = ' + "'#{fase2censo.p4.to_s}'"
      end
    end
    if fase2censo.p5.to_s != ""
      if cadena != ""
        cadena = cadena + ' and substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      else
        cadena = ' substr(p5,3,2)||substr(p5,6,2) = ' + "'#{fase2censo.p5.to_s}'"
      end
    end
    if fase2censo.p11.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11 = ' + "'#{fase2censo.p11.to_s}'"
      else
        cadena = ' p11 = ' + "'#{fase2censo.p11.to_s}'"
      end
    end
    if fase2censo.p11_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      else
        cadena = ' p11_1 = ' + "'#{fase2censo.p11_1.to_s}'"
      end
    end
    if fase2censo.p12.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12 = ' + "'#{fase2censo.p12.to_s}'"
      else
        cadena = ' p12 = ' + "'#{fase2censo.p12.to_s}'"
      end
    end
    if fase2censo.p12_1.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      else
        cadena = ' p12_1 = ' + "'#{fase2censo.p12_1.to_s}'"
      end
    end
    if fase2censo.p13.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p13 = ' + "'#{fase2censo.p13.to_s}'"
      else
        cadena = ' p13 = ' + "'#{fase2censo.p13.to_s}'"
      end
    end
    if fase2censo.p192.to_s != ""
      if cadena != ""
        cadena = cadena + ' and p192 = ' + "'#{fase2censo.p192.to_s}'"
      else
        cadena = ' p192 = ' + "'#{fase2censo.p192.to_s}'"
      end
    end
    if cadena != ""
      if pagina.to_s == 'SI'
        paginate :per_page => 10,
                 :page => page,
                 :conditions => [cadena],
                 :order => 'id'
      else
        find(:all, :conditions => [cadena], :order => "id")
      end
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
    end
  end
end
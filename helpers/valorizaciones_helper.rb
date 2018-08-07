module ValorizacionesHelper

   def select_valorizacionesestado
     is_select_valorizacionesestado
   end

   def select_valorizacionesobra
     is_select_valorizacionesobra
   end
   
   def select_tipo_gravamen
     [
       ["ACTOS DE MOVILIZACION","ACTOS DE MOVILIZACION"],
       ["DECRETOS QUE CONCEDAN EL BENEFICIO DE SEPARACION","DECRETOS QUE CONCEDAN EL BENEFICIO DE SEPARACION"],
       ["HIPOTECAS","HIPOTECAS"],
       ["LIQUIDACION DEL EFECTO DE PLUSVALIA.","LIQUIDACION DEL EFECTO DE PLUSVALIA."],
       ["VALORIZACIONES","VALORIZACIONES"]
     ]
   end
   
   def select_tipo_limdominio
     [
       ["AFECTACION A VIVIENDA FAMILIAR","AFECTACION A VIVIENDA FAMILIAR"],
       ["CONDICIONES","CONDICIONES"],
       ["CONDOMINIO","CONDOMINIO"],
       ["DECLARATORIAS DE INMINENCIA DE DESPLAZAMIENTO O DESPLAZAMIENTO FORZADO","DECLARATORIAS DE INMINENCIA DE DESPLAZAMIENTO O DESPLAZAMIENTO FORZADO"],
       ["DEMANDA INSCRITA","DEMANDA INSCRITA"],
       ["PATRIMONIO DE FAMILIA INEMBARGABLE","PATRIMONIO DE FAMILIA INEMBARGABLE"],
       ["PROPIEDAD HORIZONTAL","PROPIEDAD HORIZONTAL"],
       ["RELACIONES DE VECINDAD","RELACIONES DE VECINDAD"],
       ["SERVIDUMBRES","SERVIDUMBRES"],
       ["USO Y HABITACION","USO Y HABITACION"],
       ["USUFRUCTO","USUFRUCTO"]
     ]
   end

   def select_tipo_medcautelar
      [
        ["DEMANDAS CIVILES","DEMANDAS CIVILES"],
        ["EMBARGOS","EMBARGOS"],
        ["PROHIBICIONES","PROHIBICIONES"],
        ["PROHIBICIONES JUDICIALES Y ADMINISTRATIVAS","PROHIBICIONES JUDICIALES Y ADMINISTRATIVAS"],
        ["VALORIZACIONES QUE AFECTEN LA ENAJENABILIDAD","VALORIZACIONES QUE AFECTEN LA ENAJENABILIDAD"]
      ]
   end

   def select_resultado_revision
     [
       ["SUBIO","SUBIO"],
       ["BAJO","BAJO"],
       ["RATIFICADO","RATIFICADO"]
     ]
   end

   def select_tiponotificacion
     [
       ["PERSONAL","PERSONAL"],
       ["AVISO","AVISO"]
     ]
   end
   
   def select_reposicion
     [
       ["REPONE","REPONE"],
       ["NO REPONE","NO REPONE"]
     ]
   end   
   
   def select_entidadb
     [
       ["RECLAMO PROPIETARIO","RECLAMO PROPIETARIO"],
       ["TITULO / BANCO AGRARIO","TITULO / BANCO AGRARIO"]
     ]     
   end
  

end

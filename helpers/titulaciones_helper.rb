module TitulacionesHelper
   def select_procedimiento
      [
        ["RECONOCIMIENTO","RECONOCIMIENTO"],
        ["RPH","RPH"],
        ["SANEAMIENTO","SANEAMIENTO"]
      ]
   end

   def select_tipoproceso
      [
        ["FISCAL","FISCAL"],
        ["PERTENENCIA","PERTENENCIA"],
        ["SANTA ELENA","SANTA ELENA"],
        ["SIN DEFINIR","SIN DEFINIR"]
      ]
   end

   def select_situacionproceso
      [
        ["CRUZADO","CRUZADO"],
        ["PUBLICADO","PUBLICADO"],
        ["INTERPUSO RECURSO","INTERPUSO RECURSO"],
        ["NOTIFICADO","NOTIFICADO"]
      ]
   end

   def select_estadovisita
      [
        ["ASIGNADO","ASIGNADO"],
        ["EFECTIVO","EFECTIVO"],
        ["FALLIDO","FALLIDO"],
        ["INCOMPLETO","INCOMPLETO"],
        ["REASIGNADO","REASIGNADO"]
      ]
   end

   def select_estadotit
      [
        ["ADECUACIONES EJE","ADECUACIONES EJE"],
        ["CENTRALIDAD VECINAL","CENTRALIDAD VECINAL"],
        ["COMERCIO","COMERCIO"],
        ["CRUCE","CRUCE"],
        ["COMPLETO","COMPLETO"],
        ["COMPLETO PARA TITULAR","COMPLETO PARA TITULAR"],
        ["DOBLE MATRICULACION","DOBLE MATRICULACION"],
        ["EQUIPAMIENTO GENERAL","EQUIPAMIENTO GENERAL"],
        ["ESTUDIO DE SUELO","ESTUDIO DE SUELO"],
        ["EN PROCESO JURIDICO","EN PROCESO JURIDICO"],
        ["FALLIDO","FALLIDO"],
        ["INCOMPLETO","INCOMPLETO"],
        ["HABILITADO","HABILITADO"],
        ["MUTACION REGISTRADA","MUTACION REGISTRADA"],
        ["NO CUMPLE POR AREA","NO CUMPLE POR AREA"],
        ["OTROS USOS","OTROS USOS"],
        ["PARCIAL PARQUE AMBIENTAL","PARCIAL PARQUE AMBIENTAL"],
        ["PARCIAL POR VIA","PARCIAL POR VIA"],
        ["PARQUE AMBIENTAL","PARQUE AMBIENTAL"],
        ["POSITIVO","POSITIVO"],
        ["PROTECCION AMBIENTAL","PROTECCION AMBIENTAL"],
        ["RETIRO DE QUEBRADA","RETIRO DE QUEBRADA"],
        ["SISTEMA COLECTOR","SISTEMA COLECTOR"],
        ["SUSPENDIDO","SUSPENDIDO"],
        ["TITULADA","TITULADA"],
        ["TIENE ESCRITURA","TIENE ESCRITURA"],
        ["ZONA VERDE","ZONA VERDE"],
        ["ZONA VERDE-PLAZOLETA","ZONA VERDE-PLAZOLETA"]
      ]
   end
end

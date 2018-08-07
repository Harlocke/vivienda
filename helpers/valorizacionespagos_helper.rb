module ValorizacionespagosHelper
   def select_tipopago
     [
       ["DANO EMERGENTE OTROS","DANO EMERGENTE OTROS"],
       ["DANO EMERGENTE NOTARIADO","DANO EMERGENTE NOTARIADO"],
       ["LUCRO CESANTE","LUCRO CESANTE"],
       ["AVALUO COMERCIAL","AVALUO COMERCIAL"],
       ["AVALUO CATASTRAL","AVALUO CATASTRAL"]
     ]
   end
   
   def select_fonvalestado
     [
       ["PENDIENTE","PENDIENTE"],
       ["PAGADO","PAGADO"]
     ]
   end

end

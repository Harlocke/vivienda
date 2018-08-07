class Titulacionespoligono < ActiveRecord::Base
  belongs_to :titulacion
  belongs_to :user
  belongs_to :potdato
  
  validates_presence_of :potdato_id, :pot_categoria, :pot_tratamiento
  validate :regusosuelo

  def usosuelo
    cadena = ""
    if self.suelo_mixto == "SI"
      cadena = cadena + "Mixto Urbano Rural - "
    end
    if self.suelo_protector == "SI"
      cadena = cadena + "Forestal Protector - "
    end
    if self.suelo_productor == "SI"
      cadena = cadena + "Forestal Productor - "
    end
    if self.suelo_agroforestal == "SI"
      cadena = cadena + "Agroforestal - "
    end
    if self.suelo_agricola == "SI"
      cadena = cadena + "Agricola - "
    end
    if self.suelo_agropecuario == "SI"
      cadena = cadena + "Agropecuario - "
    end
    return cadena
  end

  def regusosuelo
    if self.suelo_mixto == "NO" and self.suelo_protector == "NO" and self.suelo_productor == "NO" and
       self.suelo_agroforestal == "NO" and self.suelo_agricola == "NO" and self.suelo_agropecuario == "NO"
      errors.add :usos, "Debe seleccionar minimo un 1 uso del suelo..."
    end
  end

  def mensajedealerta
    return nil
#    if (self.potdato.descripcion.to_s == "SE-API-04" or self.potdato.descripcion.to_s == "SE-API-05") and
#        self.pot_tratamiento.to_s == "AREA PARA LA PRESERVACION DE  INFRAESTRUCTURA (API)" and self.suelo_protector.to_s == "SI"
#       return "No se puede reconocer (DESTINADO A EQUIPAMIENTO)"
#    elsif (self.potdato.descripcion.to_s == "SE-CNS1-01" or self.potdato.descripcion.to_s == "SE-CNS1-02" or self.potdato.descripcion.to_s == "SE-CNS1-03") and
#           self.pot_tratamiento.to_s == "CONSOLIDACION SUBURBANA NIVEL 1" and self.suelo_mixto.to_s == "SI"
#       return "No se puede reconocer (DESTINADO A PARCELACIÓN)"
##    elsif  self.potdato.descripcion.to_s == "SE-CNS1-41" and
##           self.pot_tratamiento.to_s == "CONSOLIDACION SUBURBANA NIVEL 1" and self..to_s == "SI"
##       return "1 edificación destinada a vivienda  100m2 de área minima de Lote "
#    elsif (self.potdato.descripcion.to_s == "SE-CNS2-05" or self.potdato.descripcion.to_s == "SE-CNS2-06" or self.potdato.descripcion.to_s == "SE-CNS2-07" or self.potdato.descripcion.to_s == "SE-CNS2-08" or self.potdato.descripcion.to_s == "SE-CNS2-09") and
#           self.pot_tratamiento.to_s == "CONSOLIDACION SUBURBANA NIVEL 2" and self.suelo_mixto.to_s == "SI"
#       return "1 edificación destinada a vivienda 100m2 de área minima de Lote "
#    elsif  (self.potdato.descripcion.to_s == "SE-CNS3-08" or self.potdato.descripcion.to_s == "SE-CNS3-09" or self.potdato.descripcion.to_s == "SE-CNS3-10" or self.potdato.descripcion.to_s == "SE-CNS3-11") and
#           self.pot_tratamiento.to_s == "CONSOLIDACION SUBURBANA NIVEL 3" and self.suelo_mixto.to_s == "SI"
#       return "1 edificación destinada a vivienda 100m2 de área minima de Lote"
#    elsif  self.potdato.descripcion.to_s == "SE-CNS4-04" and
#           self.pot_tratamiento.to_s == "CONSOLIDACION SUBURBANA NIVEL 4" and self.suelo_mixto.to_s == "SI"
#       return "1 edificación destinada a vivienda 2 de área minima de Lote"
#    elsif  self.potdato.descripcion.to_s == "SE-CRNM-08" and
#           self.pot_tratamiento.to_s == "CONSERVACION POR ALTO RIESGO NO MITIGABLE" and self.suelo_protector.to_s == "SI"
#       return "No se puede reconocer por estar en alto riesgo no m"
#    elsif  (self.potdato.descripcion.to_s == "SE-CS-09" or self.potdato.descripcion.to_s == "SE-CS-10" or self.potdato.descripcion.to_s == "SE-CS-11" or
#            self.potdato.descripcion.to_s == "SE-CS-12" or self.potdato.descripcion.to_s == "SE-CS-13" or self.potdato.descripcion.to_s == "SE-CS-14" or
#            self.potdato.descripcion.to_s == "SE-CS-14(B)" or self.potdato.descripcion.to_s == "SE-CS-15" or self.potdato.descripcion.to_s == "SE-CS-16" or
#            self.potdato.descripcion.to_s == "SE-CS-16(B)") and
#            self.pot_tratamiento.to_s == "CONSERVACION" and self.suelo_protector.to_s == "SI"
#       return "1 edificación destinada a vivienda 38 ha de área minima de Lote, en aplicación de la resolución 9328 de 2007"
#    elsif  (self.potdato.descripcion.to_s == "SE-GARS-12" or self.potdato.descripcion.to_s == "SE-GARS-13" or self.potdato.descripcion.to_s == "SE-GARS-14" or
#            self.potdato.descripcion.to_s == "SE-GARS-14(B)" or self.potdato.descripcion.to_s == "SE-GARS-15" or self.potdato.descripcion.to_s == "SE-GARS-16" or
#            self.potdato.descripcion.to_s == "SE-GARS-17" or self.potdato.descripcion.to_s == "SE-GARS-18" or self.potdato.descripcion.to_s == "SE-GARS-19" or
#            self.potdato.descripcion.to_s == "SE-GARS-20" or self.potdato.descripcion.to_s == "SE-GARS-21") and
#            self.pot_tratamiento.to_s == "GENERACION DE ACTIVIDADES RURALES SOSTENIBLES (GARS)" and self.suelo_agroforestal.to_s == "SI"
#       return "1 edificación destinada a vivienda 1 ha de área minima de Lote"
#    elsif  (self.potdato.descripcion.to_s == "SE-RAR-25" or self.potdato.descripcion.to_s == "SE-RAR-26" or self.potdato.descripcion.to_s == "SE-RAR-27" or
#            self.potdato.descripcion.to_s == "SE-RAR-28" or self.potdato.descripcion.to_s == "SE-RAR-30" or self.potdato.descripcion.to_s == "SE-RAR-31") and
#            self.pot_tratamiento.to_s == "RESTAURACION DE ACTIVIDADES RURALES (RAR)" and self.suelo_agricola.to_s == "SI"
#       return "1 edificación destinada a vivienda 6.400 m2 de área minima de Lote"
#    elsif  (self.potdato.descripcion.to_s == "SE-RAR-22" or self.potdato.descripcion.to_s == "SE-RAR-23" or self.potdato.descripcion.to_s == "SE-RAR-24" or
#            self.potdato.descripcion.to_s == "SE-RAR-28" or self.potdato.descripcion.to_s == "SE-RAR-29" or self.potdato.descripcion.to_s == "SE-RAR-30" or
#            self.potdato.descripcion.to_s == "SE-RAR-32" or self.potdato.descripcion.to_s == "SE-RAR-33" or self.potdato.descripcion.to_s == "SE-RAR-34" or
#            self.potdato.descripcion.to_s == "SE-RAR-35") and
#            self.pot_tratamiento.to_s == "RESTAURACION DE ACTIVIDADES RURALES (RAR)" and self.suelo_productor.to_s == "SI"
#       return "1 edificación destinada a vivienda 6.400 m2 de área minima de Lote"
#    end
  end

end

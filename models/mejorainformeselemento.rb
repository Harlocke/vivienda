class Mejorainformeselemento < ActiveRecord::Base
  belongs_to :user
  belongs_to :mejoramientosinforme
  belongs_to :mejoramientoselemento
  has_many :mejorainformescriterios, :dependent =>:destroy
  has_many :mejorainformesimagenes, :dependent =>:destroy

  validates_numericality_of :cantidad
  validate_on_update :validaingreso, :validaestado
#
#  def superacant
#    @cantidad = 0
#    @cantidad = Mejorainformeslemento.sum('cantidad',:conditions => ["mejoramientoselemento_id = #{self.mejoramientoselemento_id} and id != #{self.id}"]) rescue nil
#    @cantidad = @cantidad.to_i + self.cantidad.to_i
#    if self.mejoramientoselemento.cantidad.to_i < @cantidad.to_i
#      errors.add :cantidad, "* La cantidad ingresada mas el acumulado supera la cantidad Total Validad del Item."
#    end
#  end

  def validaingreso
    if self.id
      @mejoele = Mejoramientoselemento.find(self.mejoramientoselemento_id)
      #valorregmejora = Mejorainformeselemento.sum('valor_total', :conditions=>["id != #{self.id} and mejoramientosinforme_id in (select id from mejoramientosinformes where mejoramiento_id = #{@mejoele.mejoramiento_id})"]) rescue 0
      #Se incluye esta linea el 2017-01-31 Fabian Fernandez
      if @mejoele.mejoramiento.calculo.to_s == "EJECUCION 2015"
        valorregmejora = Mejorainformeselemento.sum('trunc(valor_total)',:conditions => ["id != #{self.id} and mejoramientoselemento_id in (select id from mejoramientoselementos where mejoramiento_id = #{@mejoele.mejoramiento_id} and mejoramientositem_id not in (10043,2))"]).to_f
      else
        valorregmejora = Mejorainformeselemento.sum('trunc(valor_total)',:conditions => ["id != #{self.id} and mejoramientoselemento_id in (select id from mejoramientoselementos where mejoramiento_id = #{@mejoele.mejoramiento_id} and mejoramientositem_id !=  10043)"]).to_f
      end      
      #valordiag      = Mejoramientoselemento.sum('valor_total', :conditions=>["mejoramiento_id = #{@mejoele.mejoramiento_id} and mejoramientositem_id = 10043"]) rescue 0
      valordiag      = @mejoele.mejoramiento.valordiag.to_i rescue 0
      valor4pormileje   = @mejoele.mejoramiento.valor4pormileje.to_i rescue 0
#      logger.error("valor....valortotal ....."+self.valor_total.to_s)
#      logger.error("valor....valorregmejora ....."+valorregmejora.to_s)
      valortotal = valorregmejora.to_i + self.valor_total.to_i
#      logger.error("valor....valortotal22222 ....."+valortotal.to_s)
      # 2014-12-02 Verifica si requiere el 10% de mano de obra no calificada
      if @mejoele.mejoramiento.especial.to_s == 'SI'
        @valorejec = (valortotal.to_i * 0.10).to_i rescue 0
        valortotal = valortotal.to_i + @valorejec.to_i
      end
      if @mejoele.mejoramiento.incremento_corregimiento.to_s == 'SI' and @mejoele.mejoramiento.calculo.to_s == "EJECUCION 2015"
        valortransporte_eje =  (valortotal * 3)/100 rescue 0
      else
        valortransporte_eje = 0
      end
      if @mejoele.mejoramiento.incremento_adicional.to_s == 'SI' and @mejoele.mejoramiento.calculo.to_s == "EJECUCION 2015"
        valortransporteadd_eje = (valortransporte_eje * 50)/100 rescue 0
      else
        valortransporteadd_eje = 0
      end
      #Calcula el 13%
      #trece = @mejoele.mejoramiento.valoradmin.to_i
      #logger.error("valor....valortotal Ant....."+valortotal.to_s)
      trece = @mejoele.mejoramiento.valoradmineje.to_i #Pilas que este problema sucedio 11-11-2015 y volvio a pasar el 20-11-2015
      valortotal = valortotal.to_i + trece.to_i + valordiag.to_i + valor4pormileje.to_i + valortransporte_eje.to_i + valortransporteadd_eje.to_i
      #logger.error("valor....valorejec10%....."+@valorejec.to_s)
      #logger.error("valor....valortotal ....."+valortotal.to_s)
      #logger.error("valor....trece ....."+trece.to_s)
      #logger.error("valor....valordiag ....."+valordiag.to_s)
      #logger.error("valor....valor4pormileje ....."+valor4pormileje.to_s)
      #logger.error("valor....valortransporte_eje ....."+valortransporte_eje.to_s)
      #logger.error("valor....valortransporteadd_eje ....."+valortransporteadd_eje.to_s)
      if valortotal.to_i > @mejoele.mejoramiento.valor_resolucion.to_i
        errors.add :cantidad, "La cantidad supera el valor del Subsidio. Verifique!! ($#{valortotal.to_i})"
      end
    end
  end

  def validaestado
    if self.id
      if self.estado.to_s == ""
        errors.add :estado, "Debe indicar el estado del item"
      end
    end
  end
end

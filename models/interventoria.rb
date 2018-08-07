class Interventoria < ActiveRecord::Base
  belongs_to :contrato
  belongs_to :user
  belongs_to :empleado
  has_many :interactividades, :dependent =>:destroy
  has_many :interbitacoras

  def self.search(identificacion,nombre)
    cadena = ""
    if identificacion != ""
      if cadena != ""
        cadena = cadena + ' and empleado_id in (select id
                                                 from   empleados
                                                 where  identificacion = '+ "'#{identificacion.strip}'" +')'
      else
        cadena = cadena + ' empleado_id in (select id
                                             from   empleados
                                             where  identificacion = '+ "'#{identificacion.strip}'" +')'
      end
    end
    if nombre.to_s != ""
      s = nombre.to_s.upcase
      if cadena != ""
        cadena = cadena + ' and empleado_id in (select id
                                                 from   empleados
                                                 where  autobuscar like '+ "'%%#{replacespace(s.to_s)}%%'" +')'
      else
        cadena = cadena + ' empleado_id in (select id
                                             from   empleados
                                             where  autobuscar like '+ "'%%#{replacespace(s.to_s)}%%'" +')'
      end
    end
    if cadena != ""
      find(:all, :conditions => [cadena], :order => "empleado_id, anno, mes desc")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "anno, mes")
    end
  end

  def limite_prepagada
    vlr_uvt = 16 * Sifi.find(58).valor.to_i
    return vlr_uvt.to_i
  end

  def limite_vivienda
    vlr_uvt = 100 * Sifi.find(58).valor.to_i
    return vlr_uvt.to_i
  end

  def limite_dependencia
    vlr_uvt = 32 * Sifi.find(58).valor.to_i
    return vlr_uvt.to_i
  end

  def salud_auto
    cuarenta = (self.valor_mes*40)/100
    docepuntocinco = (cuarenta * 12.5)/100
    return docepuntocinco.to_i
  end

  def arl_auto
    cuarenta = (self.valor_mes*40)/100
    puntocinco = (cuarenta * 0.522)/100
    return puntocinco.to_i
  end

  def pension_auto
    cuarenta = (self.valor_mes*40)/100
    dieciseis = (cuarenta * 16)/100
    return dieciseis.to_i
  end

  def acceso
    if self.estado.to_s == "REVISION" or self.estado.to_s == "APROBADO"
      return 'N'
    else
      return 'S'
    end
  end

  def nombreinterventor
    empleado = Empleado.find(self.interventorempleado_id)
    #logger.error("ingresso a nombreinterventor")
    #logger.error("ingresso a nombreinterventor.. con el id "+empleado.nombres.to_s)
    return empleado.nombres.to_s + " <br/>" + empleado.cargo.to_s
  end

  def descmesinforme
     if self.mes.to_s == '1'
       return 'ENERO'
     elsif self.mes.to_s == '2'
       return 'FEBRERO'
     elsif self.mes.to_s == '3'
       return 'MARZO'
     elsif self.mes.to_s == '4'
       return 'ABRIL'
     elsif self.mes.to_s == '5'
       return 'MAYO'
     elsif self.mes.to_s == '6'
       return 'JUNIO'
     elsif self.mes.to_s == '7'
       return 'JULIO'
     elsif self.mes.to_s == '8'
       return 'AGOSTO'
     elsif self.mes.to_s == '9'
       return 'SEPTIEMBRE'
     elsif self.mes.to_s == '10'
       return 'OCTUBRE'
     elsif self.mes.to_s == '11'
       return 'NOVIEMBRE'
     elsif self.mes.to_s == '12'
       return 'DICIEMBRE'
     else
       return '------'
     end
   end

  def vencido
    objetoid = ""
    if Time.now.strftime("%Y").to_i == self.anno.to_i and self.mes.to_i < Time.now.strftime("%m").to_i
      objetoid = Objeto.find_by_descripcion('interventoriaperiodovencido').id
      if objetoid.to_s != ""
        if Userspermiso.exists?(["user_id = #{self.user_id} and objeto_id = #{objetoid}"]) == true
          return 'N'
        else
          return 'S'
        end
      else
        return 'S'
      end
    else
      return 'N'
    end    
  end

  def habilitadofinal
    if self.estado.to_s == 'PREPARAFINAL'
      vlr = ""
      cantidad = self.interactividades.find(:all,:conditions=>["actividad like '%%PAGOS%%DE%%SEGURIDAD%%SOCIAL%%'"]).count
      cant = 0
      for interactividad in self.interactividades.find(:all,:conditions=>["actividad like '%%PAGOS%%DE%%SEGURIDAD%%SOCIAL%%'"])
        if interactividad.desarrollo.to_s == ""
          vlr = 'N'
        else
          if cantidad > 1
            if interactividad.interactimagenes.exists?
               vlr = 'S'
            end
          else
           if interactividad.interactimagenes.exists?
             vlr = 'S'
           else
             vlr = 'N'
           end
          end
        end
      end
      if vlr.to_s == 'S'
        if self.salud.to_i > 0 and self.observaciones.to_s != ""
          vlr = 'S'
        else
          vlr = 'N'
        end
      end
    end
    return vlr
  end


  def self.replacespace(campo)
    b = campo.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    return b
  end

  def validainforme
    @validacioninforme = Objeto.find_by_sql("select fnc_validainformes(#{self.contrato_id}) dato from dual") rescue nil
    if @validacioninforme
      @validacioninforme.each do |validacioninforme|
         return validacioninforme.dato.to_s
      end
    end
  end

  def periodoactual
    ' Mes: ' + self.descmesinforme.to_s + ' - Año: ' +self.anno.to_s
  end

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

  def contratoactual
    self.contrato.nro_contrato.to_s + ' de ' + self.contrato.fecha_firma.strftime("%d").to_s + ' de ' + descmesmin(self.contrato.fecha_firma.strftime("%m")) + ' de ' + self.contrato.fecha_firma.strftime("%Y").to_s
  end

  def bitacora
    "CONTRATO: "+self.contratoactual.to_s + " - PERIODO: " +self.periodoactual.to_s rescue nil
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end

end


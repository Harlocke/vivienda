class Correspondenciasenviada < ActiveRecord::Base
  belongs_to :persona
  belongs_to :benevivienda
  belongs_to :user
  belongs_to :correspondenciasremitente
  belongs_to :dependencia
  has_many :correspondenciasradicados, :dependent =>:destroy
  has_many :corresenviadasimagenes, :dependent =>:destroy

  validates_presence_of :fecha_elaboracion, :asunto, :dependencia_id
  #validates_presence_of :persona_autobuscar, :if => :in_us?
  #validates_presence_of :correspondenciasremitente_id, :if => :in_us2?
  validates_uniqueness_of :nro_radicado, :scope => :anno
  validates_numericality_of :nro_radicado

#  def in_us?
#    correspondenciasremitente_id.to_s  == ""
#  end
#
#  def in_us2?
#    persona_autobuscar.to_s  == ""
#  end

  def self.search (nroradicado, identificacion, identificacionb, correspondenciasremitenteid, fchelainicial, fchelafinal, dependenciaid, asunto, observacion, empresa, empresar, userfirma,userelabora,devolucion,reenvio,anexo,causal,page)
      cadena = ""
      if nroradicado.to_s != ""
        if cadena != ""
          cadena = cadena + ' and nro_radicado = '+ "'#{nroradicado.strip}'"
        else
          cadena = cadena + ' nro_radicado = '+ "'#{nroradicado.strip}'"
        end
      end
      if identificacion.to_s != ""
        if cadena != ""
          cadena = cadena + ' and persona_id in (select id from personas where identificacion = '+ "'#{identificacion.strip}'" +')'
        else
          cadena = cadena + ' persona_id in (select id from personas where identificacion = '+ "'#{identificacion.strip}'" +')'
        end
      end
      if identificacionb.to_s != ""
        if cadena != ""
          cadena = cadena + ' and benevivienda_id in (select id from beneviviendas where identificacion is not null and identificacion = '+ "'#{identificacionb.strip}'" +')'
        else
          cadena = cadena + ' benevivienda_id in (select id from beneviviendas where identificacion is not null and identificacion = '+ "'#{identificacionb.strip}'" +')'
        end
      end
      if correspondenciasremitenteid.to_s != ""
        if cadena != ""
          cadena = cadena + ' and correspondenciasremitente_id = '+ "'#{correspondenciasremitenteid}'"
        else
          cadena = cadena + ' correspondenciasremitente_id = '+ "'#{correspondenciasremitenteid}'"
        end
      end
      if fchelainicial.to_s != "" and fchelafinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and fecha_elaboracion between ' + "'#{fchelainicial}'" + ' and ' + "'#{fchelafinal}'"
        else
          cadena = cadena + ' fecha_elaboracion between ' + "'#{fchelainicial}'" + ' and ' + "'#{fchelafinal}'"
        end
      end
      if dependenciaid.to_s != ""
        if cadena != ""
          cadena = cadena + ' and dependencia_id = '+ "'#{dependenciaid}'"
        else
          cadena = cadena + ' dependencia_id = '+ "'#{dependenciaid}'"
        end
      end
      if asunto.to_s != ""
        s = asunto.upcase
        if cadena != ""
          cadena = cadena + ' and upper(asunto) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(asunto) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if observacion.to_s != ""
        s = observacion.upcase
        if cadena != ""
          cadena = cadena + ' and upper(observacion) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(observacion) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if empresa.to_s != ""
        s = empresa.upcase
        if cadena != ""
          cadena = cadena + ' and correspondenciasremitente_id in (select id from correspondenciasremitentes where entidad like '+ "'%%#{s.to_s.strip}%%'"+')'
        else
          cadena = cadena + ' correspondenciasremitente_id in (select id from correspondenciasremitentes where entidad like '+ "'%%#{s.to_s.strip}%%'"+')'
        end
      end
      if empresar.to_s != ""
        s = empresar.upcase
        if cadena != ""
          cadena = cadena + ' and correspondenciasremitente_id in (select id from correspondenciasremitentes where nombre like '+ "'%%#{s.to_s.strip}%%'"+')'
        else
          cadena = cadena + ' correspondenciasremitente_id in (select id from correspondenciasremitentes where nombre like '+ "'%%#{s.to_s.strip}%%'"+')'
        end
      end
      if userfirma.to_s != ""
        if cadena != ""
          cadena = cadena + ' and userdependencia_id = '+ "'#{userfirma}'"
        else
          cadena = cadena + ' userdependencia_id = '+ "'#{userfirma}'"
        end
      end
      if userelabora.to_s != ""
        if cadena != ""
          cadena = cadena + ' and userelabora_id = '+ "'#{userelabora}'"
        else
          cadena = cadena + ' userelabora_id = '+ "'#{userelabora}'"
        end
      end
      if anexo.to_s != ""
        s = anexo.upcase
        if cadena != ""
          cadena = cadena + ' and upper(anexo) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(anexo) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if devolucion.to_s != ""
         if devolucion.to_s == "SI"
            if cadena != ""
              cadena = cadena + ' and devolucion is not null '
            else
              cadena = cadena + ' devolucion is not null '
            end
         elsif devolucion.to_s == "NO"
            if cadena != ""
              cadena = cadena + ' and devolucion is null '
            else
              cadena = cadena + ' devolucion is null '
            end
         end
      end
      if reenvio.to_s != ""
         if reenvio.to_s == "SI"
            if cadena != ""
              cadena = cadena + ' and reenvio is not null '
            else
              cadena = cadena + ' reenvio is not null '
            end
         elsif reenvio.to_s == "NO"
            if cadena != ""
              cadena = cadena + ' and reenvio is null '
            else
              cadena = cadena + ' reenvio is null '
            end
         end
      end
      if causal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and causal_devolucion = '+ "'#{causal}'"
        else
          cadena = cadena + ' causal_devolucion = '+ "'#{causal}'"
        end
      end
      if cadena != ""
        paginate :per_page => 10, :page => page, :conditions => [cadena], :order=>'to_number(nro_radicado), created_at desc'
      else
        paginate :per_page => 10, :page => page, :conditions => ["id = '-1'"]
      end 
  end

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def benevivienda_autobuscar
    benevivienda.autobuscar if benevivienda
  end

  def benevivienda_autobuscar=(autobuscar)
    self.benevivienda = Benevivienda.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

  def correspondenciasremitente_autobuscar
    correspondenciasremitente.autobuscar if correspondenciasremitente
  end

  def correspondenciasremitente_autobuscar=(autobuscar)
    self.correspondenciasremitente = Correspondenciasremitente.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end


  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end

end

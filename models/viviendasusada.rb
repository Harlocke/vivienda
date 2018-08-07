class Viviendasusada < ActiveRecord::Base
  has_many :viviendasusadaspersonas, :dependent =>:destroy
  has_many :viviendasusadastramites, :dependent =>:destroy
  has_many :viviendasusadaspagos, :dependent =>:destroy
  has_many :viviendasusadasnotas, :dependent =>:destroy
  has_many :viviendasusadasimagenes, :dependent =>:destroy
  belongs_to :tipospoblacion
  belongs_to :viviendasusadasestado
  belongs_to :familiar
  belongs_to :comuna

  validates_presence_of :viviendasusadasestado_id, :comuna_id #:tipospoblacion_id,

  def self.search(viviendasusada, identificacion, codigo, visitainicial, visitafinal, escinicial, escfinal, fchinicial, fchfinal, valorinicial, valorfinal,page,perpage)
      cadena = ""
      if viviendasusada.tipospoblacion_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and tipospoblacion_id = ' + viviendasusada.tipospoblacion_id.to_s
        else
          cadena = ' tipospoblacion_id = ' + viviendasusada.tipospoblacion_id.to_s
        end
      else
        if cadena != ""
          cadena = cadena + ' and nvl(tipospoblacion_id,0) = nvl(tipospoblacion_id,0)'
        else
          cadena = ' nvl(tipospoblacion_id,0) = nvl(tipospoblacion_id,0)'
        end
      end
      if viviendasusada.viviendasusadasestado_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and viviendasusadasestado_id = ' + viviendasusada.viviendasusadasestado_id.to_s
        else
          cadena = ' viviendasusadasestado_id = ' + viviendasusada.viviendasusadasestado_id.to_s
        end
      end
      if viviendasusada.familiar_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and familiar_id = ' + viviendasusada.familiar_id.to_s
        else
          cadena = ' familiar_id = ' + viviendasusada.familiar_id.to_s
        end
      end
      if codigo != ""
        if cadena != ""
          cadena = cadena + ' and id = ' + codigo
        else
          cadena = ' id = ' + codigo
        end
      end
      if viviendasusada.sector != ""
         s = viviendasusada.sector.upcase
        if cadena != ""
          cadena = cadena + ' and upper(sector) like '+ "'%%#{s.to_s}%%'"
        else
          cadena = ' upper(sector) like '+ "'%%#{s.to_s}%%'"
        end
      end
      if identificacion.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id in (select distinct v.viviendasusada_id
                                         from  viviendasusadaspersonas v, personas p 
                                         where v.persona_id = p.id
                                         and   p.identificacion = '+ "'#{identificacion.strip}'" +')'
        else
          cadena = cadena + ' id in (select distinct v.viviendasusada_id
                                         from  viviendasusadaspersonas v, personas p 
                                         where v.persona_id = p.id
                                         and   p.identificacion = '+ "'#{identificacion.strip}'" +')'
        end
      end
      if viviendasusada.resultado_concepto != ""
        if cadena != ""
          cadena = cadena + ' and resultado_concepto = '+ "'#{viviendasusada.resultado_concepto}'"
        else
          cadena = ' resultado_concepto = '+ "'#{viviendasusada.resultado_concepto}'"
        end
      end
      if visitainicial != "" and visitafinal != ""
        if cadena != ""
          cadena = cadena + ' and fecha_visita_tecnica between ' + "'#{visitainicial}'" + ' and ' + "'#{visitafinal}'"
        else
          cadena = ' fecha_visita_tecnica between ' + "'#{visitainicial}'" + ' and ' + "'#{visitafinal}'"
        end
      end
      if escinicial != "" and escfinal != ""
        if cadena != ""
          cadena = cadena + ' and escritura_elaboracion between '+ "'#{escinicial}'" + ' and '+ "'#{escfinal}'"
        else
          cadena = ' escritura_elaboracion between '+ "'#{escinicial}'" + ' and '+ "'#{escfinal}'"
        end
      end
      if viviendasusada.resultado_estudio != ""
        if cadena != ""
          cadena = cadena + ' and resultado_estudio = '+ "'#{viviendasusada.resultado_estudio}'"
        else
          cadena = ' resultado_estudio = '+ "'#{viviendasusada.resultado_estudio}'"
        end
      end
      if viviendasusada.entregada != ""
        if cadena != ""
          cadena = cadena + ' and entregada = '+ "'#{viviendasusada.entregada}'"
        else
          cadena = ' entregada = '+ "'#{viviendasusada.entregada}'"
        end
      end
      if fchinicial != "" and fchfinal != ""
        if cadena != ""
          cadena = cadena + ' and fecha_final between '+ "'#{fchinicial}'" + ' and '+ "'#{fchfinal}'"
        else
          cadena = ' fecha_final between '+ "'#{fchinicial}'" + ' and '+ "'#{fchfinal}'"
        end
      end
      if viviendasusada.modo_adquisicion != ""
        if cadena != ""
          cadena = cadena + ' and modo_adquisicion = '+ "'#{viviendasusada.modo_adquisicion}'"
        else
          cadena = ' modo_adquisicion = '+ "'#{viviendasusada.modo_adquisicion}'"
        end
      end
      if valorinicial != "" and valorfinal != ""
        if cadena != ""
          cadena = cadena + ' and valor_vivienda between '+ "'#{valorinicial}'" + ' and '+ "'#{valorfinal}'"
        else
          cadena = ' valor_vivienda between '+ "'#{valorinicial}'" + ' and '+ "'#{valorfinal}'"
        end
      end
    if cadena != ""
      paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "created_at"
    else
      paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at"
    end
  end


  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
  
  def descomuna
    return Comuna.find(self.comunadestino_id).descripcion rescue nil
  end



end

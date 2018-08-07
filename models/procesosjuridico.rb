class Procesosjuridico < ActiveRecord::Base
  belongs_to :tiposproceso
  belongs_to :poblacionesespecial
  has_many :procesosetapas, :dependent =>:destroy
  has_many :procesospersonas, :dependent =>:destroy
  
  validates_presence_of :tiposproceso_id

  def self.search(procesosjuridico, estadoproceso,page,perpage)
      cadena = ""
      if procesosjuridico.tiposproceso_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and tiposproceso_id = ' + procesosjuridico.tiposproceso_id.to_s
        else
          cadena = ' tiposproceso_id = ' + procesosjuridico.tiposproceso_id.to_s
        end
      end
      if procesosjuridico.nro_radicado != ""
        s = procesosjuridico.nro_radicado.upcase
        if cadena != ""
          cadena = cadena + ' and upper(nro_radicado) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(nro_radicado) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.anno_radicado != ""
        s = procesosjuridico.anno_radicado.upcase
        if cadena != ""
          cadena = cadena + ' and upper(anno_radicado) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(anno_radicado) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.juzgado != ""
        s = procesosjuridico.juzgado.upcase
        if cadena != ""
          cadena = cadena + ' and upper(juzgado) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(juzgado) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.demandante  != ""
        s = procesosjuridico.demandante.upcase
        if cadena != ""
          cadena = cadena + ' and upper(demandante) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(demandante) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.demandado != ""
        s = procesosjuridico.demandado.upcase
        if cadena != ""
          cadena = cadena + ' and upper(demandado) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(demandado) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.poblacionesespecial_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and upper(poblacionesespecial_id = ' + procesosjuridico.poblacionesespecial_id.to_s.strip
        else
          cadena = ' upper(poblacionesespecial_id = ' + procesosjuridico.poblacionesespecial_id.to_s.strip
        end
      end
      if procesosjuridico.observacion_proceso.to_s != ""
        s = procesosjuridico.observacion_proceso.upcase
        if cadena != ""
          cadena = cadena + ' and upper(observacion_proceso) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(observacion_proceso) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.pretension != ""
        s = procesosjuridico.pretension.upcase
        if cadena != ""
          cadena = cadena + ' and upper(pretension) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(pretension) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.cuantia.to_s != ""
        s = procesosjuridico.cuantia.upcase
        if cadena != ""
          cadena = cadena + ' and upper(cuantia) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(cuantia) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.etapa.to_s != ""
        s = procesosjuridico.etapa.upcase
        if cadena != ""
          cadena = cadena + ' and upper(etapa) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(etapa) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.subetapa.to_s != ""
        s = procesosjuridico.subetapa.upcase
        if cadena != ""
          cadena = cadena + ' and upper(subetapa) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(subetapa) like '+ "'%%#{s.to_s.strip}%%'"
        end
      end
      if procesosjuridico.estado.to_s != ""
        if cadena != ""
          cadena = cadena + ' and estado = ' + procesosjuridico.estado
        else
          cadena = ' estado = ' + procesosjuridico.estado
        end
      end
      if estadoproceso.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id in (select procesosjuridico_id from procesosetapas where estado = ' + "'#{estadoproceso.to_s}'"+')'
        else
          cadena = ' id in (select procesosjuridico_id from procesosetapas where estado = ' + "'#{estadoproceso.to_s}'"+')'
        end
      end
      if cadena != ""
        paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "created_at"
      else
        paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at"
      end      
  end
end
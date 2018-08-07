class Resolucion < ActiveRecord::Base
  has_many :resolucionespersonas, :dependent =>:destroy
  has_many :resolucionescontratistas, :dependent =>:destroy
  has_many :temporales
  has_many :resolucionesimagenes, :dependent =>:destroy
  has_many :mejoramientos
  has_many :licitaciones
  has_many :conveniosformas
  has_many :conveniosresolintenciones
  belongs_to :resolucionesclase
  belongs_to :user

  validates_presence_of :fecha, :resolucionesclase_id, :resuelve, :dependencia_id, :user_id
  validates_uniqueness_of :nro_resolucion, :scope => :anno

  def self.search (resolucion, identificacion, fchinicial, fchfinal, page, perpage)
      cadena = ""
      if resolucion.nro_resolucion != ""
        if cadena != ""
          cadena = cadena + ' and nro_resolucion = ' + "'#{resolucion.nro_resolucion.to_s.strip}'"
        else
          cadena = ' nro_resolucion = ' + "'#{resolucion.nro_resolucion.to_s.strip}'"
        end
      end
      if resolucion.modalidad != ""
        if cadena != ""
          cadena = cadena + ' and modalidad = ' + "'#{resolucion.modalidad.to_s.strip}'"
        else
          cadena = ' modalidad = ' + "'#{resolucion.modalidad.to_s.strip}'"
        end
      end
      if resolucion.anno != ""
        if cadena != ""
          cadena = cadena + ' and anno = ' + "'#{resolucion.anno.to_s.strip}'"
        else
          cadena = ' anno = ' + "'#{resolucion.anno.to_s.strip}'"
        end
      end
      if resolucion.resolucionesclase_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and resolucionesclase_id = ' + resolucion.resolucionesclase_id.to_s
        else
          cadena = ' resolucionesclase_id = ' + resolucion.resolucionesclase_id.to_s
        end
      end
      if resolucion.user_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and user_id = ' + resolucion.user_id.to_s
        else
          cadena = ' user_id = ' + resolucion.user_id.to_s
        end
      end
      if identificacion != ""
        if cadena != ""
          cadena = cadena + ' and id in (select r.resolucion_id
                                         from   resolucionespersonas r, relaciones a
                                         where  r.persona_id = a.persona_id
                                         and    a.identificacion = '+ "'#{identificacion.strip}'" +')'
        else
          cadena = cadena + ' id in (select r.resolucion_id
                                     from   resolucionespersonas r, relaciones a
                                     where  r.persona_id = a.persona_id
                                     and    a.identificacion = '+ "'#{identificacion.strip}'" +')'
        end
      end
      if fchinicial.to_s != "" and fchfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(fecha) between ' + "'#{fchinicial.to_s}'" + ' and ' + "'#{fchfinal.to_s}'"
        else
          cadena = ' trunc(fecha) between ' + "'#{fchinicial.to_s}'" + ' and ' + "'#{fchfinal.to_s}'"
        end
      end
      if cadena != ""
        #find(:all, :conditions => [cadena], :order => "to_number(caja), to_number(carpeta), barrio")
        paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "anno desc"
      else
        paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at"
      end
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
  
end

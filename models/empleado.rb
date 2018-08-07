class Empleado < ActiveRecord::Base

  belongs_to :documento
  has_many :contratos
  has_many :contratosvinculados
  has_many :empleadoscapacitaciones
  has_many :empleadosactividades
  has_many :contratosretefuentes
  has_many :nominasnovedades
  has_many :nominas
  has_many :almacenesentradas
  has_many :resolucionescontratistas
  has_many :archivosempleados
  has_many :estudiosprevios
  has_many :empleadosimagenes
  has_many :interventorias
  has_many :empleadobitacoras
  belongs_to :dependencia

  validates_presence_of :identificacion, :primer_nombre
  validates_uniqueness_of :identificacion
  validates_numericality_of :identificacion
  
  def self.searchv(search, page)
      paginate :per_page => 15,
                 :page => page,
                 :conditions => ["tipo= 'V' and autobuscar like '%%#{replacespace(search.to_s)}%%'"],
                 :order => 'primer_nombre'
  end

  def self.replacespace(campo)
    b = campo.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    b = b.sub(" ","%%")
    return b
  end


  def dtipo
     if self.tipo == "V"
       return "VINCULADO"
     elsif self.tipo == "C"
       return "CONTRATISTA"
     else
       return "****"
     end
  end

  def destado
     if self.estado == "P"
       return "PERFECCIONADO"
     elsif self.estado == "E"
       return "EN EJECUCION"
     elsif self.estado == "L"
       return "EN LIQUIDACION"
     elsif self.estado == "I"
       return "LIQUIDADO"
     elsif self.estado == "C"
       return "ANULADO"
     elsif self.estado == "T"
       return "TERMINADO"
     else
       return "****"
     end
  end

  def self.search (empleado, tipo, nrocontrato)
    cadena = ""
    if empleado.identificacion != ""
      if cadena != ""
        cadena = cadena + ' and identificacion = ' + "'#{empleado.identificacion.to_s.strip}'"
      else
        cadena = ' identificacion = ' + "'#{empleado.identificacion.to_s.strip}'"
      end
    end
    if nrocontrato != ""
      if cadena != ""
        cadena = cadena + ' and id in (select empleado_id from contratos where nro_contrato = ' + "'#{nrocontrato.strip}'" + ')'
      else
        cadena = ' id in (select empleado_id from contratos where nro_contrato = ' + "'#{nrocontrato.strip}'" + ')'
      end
    end
    if empleado.nombre != ""
      s = empleado.nombre.upcase
      if cadena != ""
        cadena = cadena + ' and upper(autobuscar) like '+ "'%%#{replacespace(s.to_s)}%%'"
      else
        cadena = ' upper(autobuscar) like '+ "'%%#{replacespace(s.to_s)}%%'"
      end
    end
    if cadena != ""
      cadena = cadena + ' and (tipo = '+ "'#{tipo.to_s.strip}'" + ' or id in (select distinct empleado_id from contratos))'
      find(:all, :conditions => [cadena], :order => "created_at")
    else
      find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
    end
  end

  def self.searchcontratos(fchinicial, fchfinal)
      cadena = ""
      if fchinicial.to_s != "" and fchfinal.to_s != ""
          cadena = ' id in (select empleado_id from contratos where fecha_inicio between ' + "'#{fchinicial.to_s}'" + ' and ' + "'#{fchfinal.to_s}'"+')'
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end

  def before_save
    nom =  ""
    if self.identificacion.nil? == false
      nom = self.identificacion.to_s
    end
    if self.primer_nombre.nil? == false
      nom = nom + ' ' + self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom = nom + ' ' + self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom = nom + ' ' + self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom = nom + ' ' + self.segundo_apellido.to_s
    end
    self.autobuscar = nom
#    @user = User.find_by_identificacion(self.identificacion)
#    if @user.id.to_i > 0
#      self.userinterventor_id = @user.id
#    end
  end

  def nombres
    nom =  ""
    if self.primer_nombre.nil? == false
      nom = nom + ' ' + self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom = nom + ' ' + self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom = nom + ' ' + self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom = nom + ' ' + self.segundo_apellido.to_s
    end
    return nom
  end

  def nombrecompleto
    return self.identificacion.to_s + " " + self.nombres.to_s
  end

  def estadoact
    if Contrato.exists?(["empleado_id = #{self.id} and to_char(decode(fecha_masmodi,null,fecha_final,fecha_masmodi),'YYYYMM') >= to_char(trunc(sysdate),'YYYYMM')"])
      return "<div align='center'><img src='/images/verde1.png' title='Activo'/> ACTIVO</div>"
    else
      if Contratosvinculado.exists?(["empleado_id = #{self.id} and fecha_final is null"])
        return "<div align='center'><img src='/images/verde1.png' title='Activo'/> ACTIVO</div>"
      else
        return "<div align='center'><img src='/images/rojo1.png' title='Inactivo'/> INACTIVO</div>"
      end
    end
  end

  def estadoinf
    if Contrato.exists?(["empleado_id = #{self.id} and to_char(decode(fecha_masmodi,null,fecha_final,fecha_masmodi),'YYYYMM') >= to_char(trunc(sysdate),'YYYYMM')"])
      return "ACTIVO"
    else
      if Contratosvinculado.exists?(["empleado_id = #{self.id} and fecha_final is null"])
        return "ACTIVO"
      else
        return "INACTIVO"
      end
    end
  end  

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
 
end

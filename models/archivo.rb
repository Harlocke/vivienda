class Archivo < ActiveRecord::Base
  belongs_to :persona
  belongs_to :archivosserie
  belongs_to :user
  has_many :archivosprestamos, :dependent =>:destroy
  has_many :archivosimagenes, :dependent =>:destroy
  has_many :archivospersonas, :dependent =>:destroy
  has_many :archivosempleados, :dependent =>:destroy
  has_many :archivosactualizaciones, :dependent =>:destroy

  validates_presence_of :caja, :carpeta, :tipo, :archivosserie_id
  validates_numericality_of :caja, :carpeta

  def self.search (identificacion,caja,carpeta,barrio,archivosserieid,usercrea,creainicial,creafinal,manzana,lote,identificacionc,convenio,nombrec,resolucion,consecutivo,imagen,page,perpage,cobama)
    cadena = ""
    if caja != ""
      if cadena != ""
        cadena = cadena + ' and caja  = '+ "'#{caja.strip}'"
      else
        cadena = cadena + ' caja  = '+ "'#{caja.strip}'"
      end
    end
    if carpeta != ""
      if cadena != ""
        cadena = cadena + ' and carpeta  = '+ "'#{carpeta.strip}'"
      else
        cadena = cadena + ' carpeta  = '+ "'#{carpeta.strip}'"
      end
    end
    if manzana != ""
      if cadena != ""
        cadena = cadena + ' and manzana  = '+ "'#{manzana.strip}'"
      else
        cadena = cadena + ' manzana  = '+ "'#{manzana.strip}'"
      end
    end
    if lote != ""
      if cadena != ""
        cadena = cadena + ' and lote  = '+ "'#{lote.strip}'"
      else
        cadena = cadena + ' lote  = '+ "'#{lote.strip}'"
      end
    end
    if barrio != ""
      s = barrio.upcase
      if cadena != ""
        cadena = cadena + ' and upper(barrio) like '+ "'%%#{s.to_s.strip}%%'"
      else
        cadena = cadena + ' upper(barrio) like '+ "'%%#{s.to_s.strip}%%'"
      end
    end
    if identificacion != ""
      if cadena != ""

        cadena = cadena + ' and id in (select archivo_id
                                       from   archivospersonas a, personas p
                                       where  a.persona_id = p.id
                                       and    p.identificacion = '+ "'#{identificacion.strip}'" +')'
      else
        cadena = cadena + ' id in (select archivo_id
                                   from   archivospersonas a, personas p
                                   where  a.persona_id = p.id
                                   and    p.identificacion = '+ "'#{identificacion.strip}'" +')'
      end
    end
    if usercrea.to_s != ""
      if cadena != ""
        cadena = cadena + ' and usercrea  = ' + "'#{usercrea}'"
      else
        cadena = cadena + ' usercrea  = ' + "'#{usercrea}'"
      end
    end
    if creainicial.to_s != "" and creafinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and trunc(created_at) between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
      else
        cadena = cadena + ' trunc(created_at) between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
      end
    end
    if archivosserieid.to_s != ""
      if cadena != ""
        cadena = cadena + ' and archivosserie_id = '+ "'#{archivosserieid}'"
      else
        cadena = cadena + ' archivosserie_id = '+ "'#{archivosserieid}'"
      end
    end
    if identificacionc != ""
      if cadena != ""
        cadena = cadena + ' and id in (select distinct a.archivo_id
                                       from   archivosempleados a, empleados e
                                       where  a.empleado_id = e.id
                                       and    e.identificacion = '+ "'#{identificacionc.strip}'" +')'
      else
        cadena = cadena + ' id in (select distinct a.archivo_id
                                   from   archivosempleados a, empleados e
                                   where  a.empleado_id = e.id
                                   and    e.identificacion = '+ "'#{identificacionc.strip}'" +')'
      end
    end
    if nombrec != ""
      s = nombrec.upcase
      if cadena != ""
        cadena = cadena + ' and id in (select distinct a.archivo_id
                                       from   archivosempleados a, empleados e
                                       where  a.empleado_id = e.id
                                       and    e.nombre like '+ "'%%#{s.to_s.strip}%%'" +')'
      else
        cadena = cadena + ' id in (select distinct a.archivo_id
                                   from   archivosempleados a, empleados e
                                   where  a.empleado_id = e.id
                                   and    e.nombre like '+ "'%%#{s.to_s.strip}%%'" +')'
      end
    end
    if convenio != ""
      s = convenio.upcase
      if cadena != ""
        cadena = cadena + ' and upper(convenio) like '+ "'%%#{s.to_s.strip}%%'"
      else
        cadena = cadena + ' upper(convenio) like '+ "'%%#{s.to_s.strip}%%'"
      end
    end
    if resolucion != ""
      if cadena != ""
        cadena = cadena + " and #{resolucion.to_i} between resol_inicial and resol_final "
      else
        cadena = cadena + " #{resolucion.to_i} between resol_inicial and resol_final "
      end
    end
    if consecutivo != ""
      if cadena != ""
        cadena = cadena + " and #{consecutivo.to_i} between conse_inicial and conse_final "
      else
        cadena = cadena + " #{consecutivo.to_i} between conse_inicial and conse_final "
      end
    end
    if cobama != ""
      if cadena != ""
        cadena = cadena + ' and cobama  = '+ "'#{cobama.strip}'"
      else
        cadena = cadena + ' cobama  = '+ "'#{cobama.strip}'"
      end
    end
    if imagen != ""
      if imagen.to_s == 'SI'
        if cadena != ""
          cadena = cadena + ' and id in (select distinct archivo_id from archivosimagenes)'
        else
          cadena = cadena + ' id in (select distinct archivo_id from archivosimagenes)'
        end
      elsif imagen.to_s == 'NO'
        if cadena != ""
          cadena = cadena + ' and id not in (select distinct archivo_id from archivosimagenes)'
        else
          cadena = cadena + ' id not in (select distinct archivo_id from archivosimagenes)'
        end
      end
    end
    if cadena != ""
      #find(:all, :conditions => [cadena], :order => "to_number(caja), to_number(carpeta), barrio")
      paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "to_number(caja), to_number(carpeta), barrio"
    else
      paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at"
    end
  end
  
  def dtipo
    if self.tipo == "A"
      return "SEDE CENTRAL"
    elsif self.tipo == "T"
      return "SEDE 2"
    elsif self.tipo == "M"
      return "SEDE 3"
    elsif self.tipo == "U"
      return "UNIDAD PERMANENTE DE JUSTIFICA - UPJ"
    elsif self.tipo == "C"
      return "CENTRAL DE INVERSIONES - CISA"
    elsif self.tipo == "S"
      return "SECRETARIA DE HACIENDA"
    elsif self.tipo == "AR"
      return "ARRENDAMIENTO TEMPORAL"
    elsif self.tipo == "SL"
      return "SEDE SAN LUIS"    
    end
  end
  
  def actualizacion(userid)
    arc = Archivosactualizacion.new
    arc.archivo_id = self.id
    arc.user_id = userid
    arc.save
  end

  def prestadoa
    cadena = ""
    #@archivo = Archivo.find(self.id)
    self.archivospersonas.each do |archivospersona|
      if cadena != ""
        cadena = cadena + '<br/>' + archivospersona.persona.autobuscar rescue nil
      else
        cadena = archivospersona.persona.autobuscar rescue nil
      end
    end
    if cadena.to_s == ""
      self.archivosempleados.each do |archivosempleado|
        if cadena != ""
          cadena = cadena + '<br/>' + archivosempleado.empleado.autobuscar
        else
          cadena = archivosempleado.empleado.autobuscar
        end
      end
    end
    return cadena
  end

  def prestadoanombres
    cadena = ""
    #@archivo = Archivo.find(self.id)
    self.archivospersonas.each do |archivospersona|
      if cadena != ""
        cadena = cadena + '<br/>' + archivospersona.persona.nombres rescue nil
      else
        cadena = archivospersona.persona.nombres rescue nil
      end
    end
    if cadena.to_s == ""
      self.archivosempleados.each do |archivosempleado|
        if cadena != ""
          cadena = cadena + '<br/>' + archivosempleado.empleado.nombres
        else
          cadena = archivosempleado.empleado.nombres
        end
      end
    end
    return cadena
  end

  def prestadoaident
    cadena = ""
    #@archivo = Archivo.find(self.id)
    self.archivospersonas.each do |archivospersona|
      if cadena != ""
        cadena = cadena + '<br/>' + archivospersona.persona.identificacion rescue nil
      else
        cadena = archivospersona.persona.identificacion rescue nil
      end
    end
    if cadena.to_s == ""
      self.archivosempleados.each do |archivosempleado|
        if cadena != ""
          cadena = cadena + '<br/>' + archivosempleado.empleado.identificacion
        else
          cadena = archivosempleado.empleado.identificacion
        end
      end
    end
    return cadena
  end

  def personasfull
    cadena = ""
    #@archivo = Archivo.find(self.id)
    self.archivospersonas.each do |archivospersona|
      if cadena != ""
        cadena = cadena + '<br/>' + archivospersona.persona.autobuscar rescue nil
      else
        cadena = archivospersona.persona.autobuscar rescue nil
      end
    end
    if cadena.to_s == ""
      self.archivosempleados.each do |archivosempleado|
        if cadena != ""
          cadena = cadena + '<br/>' + archivosempleado.empleado.autobuscar
        else
          cadena = archivosempleado.empleado.autobuscar
        end
      end
    end
    return cadena
  end

  def prestadodocumentoa
    cadena = ""
    #archivo = Archivo.find(self.id)
    for archivosprestamo in self.archivosprestamos.find(:all, :conditions=>["fecha_devolucion is null"])
      if cadena != ""
        cadena = cadena + '<br/>' + archivosprestamo.userprestamoname rescue nil
      else
        cadena = archivosprestamo.userprestamoname rescue nil
      end
    end
    return cadena
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end

end


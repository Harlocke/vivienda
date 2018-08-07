class Iguana < ActiveRecord::Base
  has_many :iguanaspersonas, :dependent =>:destroy
  has_many :iguanaspagos, :dependent =>:destroy
  has_many :iguanasobservaciones, :dependent =>:destroy
  has_many :iguanasimagenes, :dependent =>:destroy
  has_many :iguanasrentistas, :dependent =>:destroy
  has_many :iguanasmejoras, :dependent =>:destroy
  has_many :asigtemporales
  has_many :asigdemandas
  has_many :asigfiscales
  has_many :asigprestamos
  belongs_to :iguanasestado

  
 validates_presence_of :proyecto, :sector, :encuesta, :cobama, :if => :is_adquisicion?
 validates_presence_of :proyecto, :social_asignado, :sector, :entidad_adquiere, :fecha_remision,
                       :encuesta, :cobama, :if => :is_obrapublica?
 validates_uniqueness_of :nro_registro, :cobama, :if => :is_obrapublica?
 validates_numericality_of :nro_registro, :cobama, :if => :is_obrapublica?
 validates_numericality_of :valor_compensacion, :allow_nil => true, :if => :is_adquisicion?
 validates_numericality_of :valor_avaluo, :allow_nil => true, :if => :is_adquisicion?
 validates_numericality_of :radicado_nro, :allow_nil => true, :if => :is_adquisicion?


  def is_adquisicion?
    self.tipo.to_s == "ADQUISICION"
  end

  def is_obrapublica?
    self.tipo.to_s == "OBRAPUBLICA"
  end

  def self.search (proyecto,nro_registro,encuesta,cobama,clasereasentamiento,identificacion,inmueble,ficticia,page,perpage)
    if proyecto.to_s == "" and nro_registro.to_s == "" and encuesta.to_s == "" and cobama.to_s == "" and clasereasentamiento.to_s == "" and identificacion.to_s == ""
      paginate :per_page => 10, :page => page, :conditions => ["id = '-1'"]
    else
      cadena = ""
      if nro_registro != ""
        if cadena != ""
          cadena = cadena + ' and nro_registro = ' + "'#{nro_registro.to_s.strip}'"
        else
          cadena = ' nro_registro = ' + "'#{nro_registro.to_s.strip}'"
        end
      end
      if proyecto != ""
        if cadena != ""
          cadena = cadena + ' and proyecto = ' + "'#{proyecto.to_s.strip}'"
        else
          cadena = ' proyecto = ' + "'#{proyecto.to_s.strip}'"
        end
      end
      #Recibe el tipo de clasereasentamiento
       if clasereasentamiento != ""
        if cadena != ""
          cadena = cadena + ' and clasereasentamiento = ' + "'#{clasereasentamiento.to_s.strip}'"
        else
          cadena = ' clasereasentamiento = ' + "'#{clasereasentamiento.to_s.strip}'"
        end
      end
      if encuesta != ""
        s = encuesta.to_s.upcase
        if cadena != ""
          cadena = cadena + ' and upper(encuesta) like '+ "'%%#{s.to_s.strip}%%'" +
                             ' or id in (select iguana_id from iguanasmejoras
                                 where upper(encuesta) like '+ "'%%#{s.to_s.strip}%%'"+")"
        else
          cadena = ' upper(encuesta) like '+ "'%%#{s.to_s.strip}%%'" +
                   ' or id in (select iguana_id from iguanasmejoras
                               where upper(encuesta) like '+ "'%%#{s.to_s.strip}%%'"+")"
        end
      end
      if cobama != ""
        s = cobama.to_s.upcase
        if cadena != ""
          cadena = cadena + ' and upper(cobama) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(cobama) like '+ "'%%#{s.to_s}%%'"
        end
      end
      if inmueble != ""
        s = inmueble.to_s.upcase
        if cadena != ""
          cadena = cadena + ' and upper(matricula) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(matricula) like '+ "'%%#{s.to_s}%%'"
        end
      end
      if ficticia != ""
        s = ficticia.to_s.upcase
        if cadena != ""
          cadena = cadena + ' and upper(nro_catastral) like '+ "'%%#{s.to_s.strip}%%'"
        else
          cadena = ' upper(nro_catastral) like '+ "'%%#{s.to_s}%%'"
        end
      end
      if identificacion != ""
        if cadena != ""
          cadena = cadena + ' and id in (select i.iguana_id
                                         from iguanaspersonas i, personas p
                                         where i.persona_id  = p.id
                                         and   p.identificacion = '+ "'#{identificacion.strip}'" +')
                               or id in (select i.iguana_id
                                         from iguanasrentistas i, personas p
                                         where i.persona_id  = p.id
                                         and   p.identificacion = '+ "'#{identificacion.strip}'" +')'
        else
          cadena = cadena + ' id in (select i.iguana_id
                                     from   iguanaspersonas i, personas p
                                     where  i.persona_id  = p.id
                                     and    p.identificacion = '+ "'#{identificacion.strip}'" +')
                              or id in (select i.iguana_id
                                        from  iguanasrentistas i, personas p
                                        where i.persona_id  = p.id
                                        and   p.identificacion = '+ "'#{identificacion.strip}'" +')'
        end
      end
      #logger.error("Cadenaaaaa..."+cadena.to_s)
      paginate :per_page => perpage, :page => page, :conditions => [cadena], :order=>'created_at desc'
    end
  end

  def fechaprogiguana(fechainicial, dias)
     if fechainicial.to_s != "" and dias.to_s != ""
       fechawork = fechainicial.to_time
       minutosmas = dias.to_i * 86400
       fechaprog = (fechawork + minutosmas.to_i)
       cantidad = Festivo.count(:conditions =>['fecha between ? and ?', fechawork, fechaprog])
       if cantidad > 0
         minutosadd = cantidad.to_i * 86400
         fechaprogramacion = fechawork + minutosmas.to_i + minutosadd.to_i
         fecha = fechaprogramacion.strftime("%d-%m-%Y")
         cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         while cantidad1.to_i > 0
           fechaprogramacion = fechaprogramacion + 86400
           fecha = fechaprogramacion.strftime("%d-%m-%Y")
           cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         end
       else
         fechaprogramacion = fechaprog
         fecha = fechaprog.strftime("%d-%m-%Y")
         cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         while cantidad1.to_i > 0
           fechaprogramacion = fechaprogramacion + 86400
           fecha = fechaprogramacion.strftime("%d-%m-%Y")
           cantidad1 = Festivo.count(:conditions =>['fecha = ?', fecha])
         end
       end
     end
     return fecha
   end

  def before_update
    self.fecha_limite = fechaprogiguana(self.fecha_sol_avaluo,214)
  end

  def dsolicituddesccatastro
    if self.solicitud_desccatastro.to_s == 'S'
      return 'SI'
    elsif self.solicitud_desccatastro.to_s == 'N'
      return 'NO'
    end
  end

  def dresolucion_ofercompra
    if self.resolucion_ofercompra.to_s == 'S'
      return 'SI'
    elsif self.resolucion_ofercompra.to_s == 'N'
      return 'NO'
    elsif self.resolucion_ofercompra.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dacepta_oferta_compra
    if self.acepta_oferta_compra.to_s == 'S'
      return 'SI'
    elsif self.acepta_oferta_compra.to_s == 'N'
      return 'NO'
    elsif self.acepta_oferta_compra.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dresolucion_notificada
    if self.resolucion_notificada.to_s == 'S'
      return 'SI'
    elsif self.resolucion_notificada.to_s == 'N'
      return 'NO'
    elsif self.resolucion_notificada.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dsolicitud_revision_avaluo
    if self.solicitud_revision_avaluo.to_s == 'S'
      return 'SI'
    elsif self.solicitud_revision_avaluo.to_s == 'N'
      return 'NO'
    elsif self.solicitud_revision_avaluo.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def descritura
    if self.escritura.to_s == 'S'
      return 'SI'
    elsif self.escritura.to_s == 'N'
      return 'NO'
    elsif self.escritura.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dexpropiacion
    if self.expropiacion.to_s == 'S'
      return 'SI'
    elsif self.expropiacion.to_s == 'N'
      return 'NO'
    elsif self.expropiacion.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dcruzado
    if self.cruzado.to_s == 'S'
      return 'SI'
    elsif self.cruzado.to_s == 'N'
      return 'NO'
    elsif self.cruzado.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dreasentado
    if self.reasentado.to_s == 'S'
      return 'SI'
    elsif self.reasentado.to_s == 'N'
      return 'NO'
    elsif self.reasentado.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def ddeshabilitado
    if self.deshabilitado.to_s == 'S'
      return 'SI'
    elsif self.deshabilitado.to_s == 'N'
      return 'NO'
    elsif self.deshabilitado.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def ddemolido
    if self.demolido.to_s == 'S'
      return 'SI'
    elsif self.demolido.to_s == 'N'
      return 'NO'
    elsif self.demolido.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dsolicitud_desccatastro
    if self.solicitud_desccatastro.to_s == 'S'
      return 'SI'
    elsif self.solicitud_desccatastro.to_s == 'N'
      return 'NO'
    elsif self.solicitud_desccatastro.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dpredio_lote
    if self.predio_lote.to_s == 'S'
      return 'SI'
    elsif self.predio_lote.to_s == 'N'
      return 'NO'
    elsif self.predio_lote.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dpaga_catastro
    if self.paga_catastro.to_s == 'S'
      return 'SI'
    elsif self.paga_catastro.to_s == 'N'
      return 'NO'
    elsif self.paga_catastro.to_s == 'NA'
      return 'NO APLICA'
    end
  end

  def dresultado_revision
    if self.resultado_revision.to_s == 'S'
      return 'SUBIO'
    elsif self.resultado_revision.to_s == 'B'
      return 'BAJO'
    elsif self.resultado_revision.to_s == 'R'
      return 'RATIFICADO'
    end
  end

  def dtratamiento
    if self.tratamiento.to_s == 'N'
      return 'NEGOCIACION DIRECTA'
    elsif self.tratamiento.to_s == 'P'
      return 'POSEEDOR'
    elsif self.tratamiento.to_s == 'R'
      return 'RENTISTA'
    elsif self.tratamiento.to_s == 'U'
      return 'UNIPERSONAL'
    end
  end

  def dsocial_asignado
    return User.find(self.social_asignado).nombre rescue nil
  end

  def djuridico_asignado
    return User.find(self.juridico_asignado).nombre rescue nil
  end

  def duseract_id
    return User.find(self.useract_id).username rescue nil
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
  
end

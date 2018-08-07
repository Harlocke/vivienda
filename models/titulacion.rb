class Titulacion < ActiveRecord::Base
  has_many :titulacionespersonas, :dependent =>:destroy
  has_many :titulacionesobservaciones, :dependent =>:destroy
  has_many :titulacionesimagenes, :dependent =>:destroy
  has_many :anttitulacionespersonas, :dependent =>:destroy
  has_many :titulacionesasignaciones, :dependent =>:destroy
  has_many :titulacionesfallidos, :dependent =>:destroy
  has_many :titulacionesprestamos, :dependent =>:destroy
  has_many :titulacionesdemandas, :dependent =>:destroy
  has_many :titulacionesusers, :dependent =>:destroy
  has_many :titulacionesvecinos, :dependent =>:destroy
  has_many :titulacionesprofesionales, :dependent =>:destroy
  has_many :titulacionesdocumentos, :dependent =>:destroy
  has_many :titulacionespoligonos, :dependent =>:destroy
  has_many :titulacionessuenos, :dependent =>:destroy
  has_many :titulacionesriesgos, :dependent =>:destroy
  has_many :titulacionesespacios, :dependent =>:destroy
  has_many :titulacionesafectas, :dependent =>:destroy
  has_many :titulacionesvisitas, :dependent =>:destroy
  has_many :asigtemporales
  has_many :asigdemandas
  has_many :asigfiscales
  has_many :asigprestamos
  has_many :titulacionescargues
  belongs_to :user
  belongs_to :titulacionesbarrio
  belongs_to :comuna

  validates_presence_of :cobama,:estado,:tipoproceso, :manzana, :lote, :direccion, :unidades, :area, :comuna_id
  validates_uniqueness_of :cobama
  validates_numericality_of :cobama
  validates_length_of :cobama, :maximum => 11, :message=> "* El cobama debe ser de 11 digitos"#, :if => :in_us1?
  validates_length_of :cobama, :minimum => 11, :message=> "* El cobama debe ser de 11 digitos"#, :if => :in_us1?
  validate :validatipoproceso
  validate :estadoproceso

  def calculo_vur
   c = Catastros2017dato.find(:first, :conditions=>["cbml = '#{self.cobama}'"]).arealote
   v = self.area_vur.to_i
   if v.to_i > c.to_i
     r = v.to_i - c.to_i
     t = r.to_i * 100
     p = t.to_i / v.to_i
     return p
   elsif c.to_i > v.to_i
     r = c.to_i - v.to_i
     t = r.to_i * 100
     p = t.to_i / c.to_i
     return p
    else
      return 0
    end
  end

  def valida_pisos
    c = Catastros2017dato.find(:first, :conditions=>["cbml = '#{self.cobama}'"])
    if c
      c = Catastros2017dato.find(:first, :conditions=>["cbml = '#{self.cobama}'"]).numpisos 
      return c.to_i
    else
      c = -1
      return c.to_i
    end  
  end

  def valida_matricula
    c = Catastros2017dato.find(:first, :conditions=>["cbml = '#{self.cobama}'"]).matricula
    return c.length.to_i
  end

  def valida_pot
    c = Catastros2017dato.find(:first, :conditions=>["cbml = '#{self.cobama}'"]).pot
    return c.to_s
  end


  def valida_mreales
    c = Catastros2017dato.find(:first, :conditions=>["cbml = '#{self.cobama}'"]).matricula
    matriculas = Catastros2017dato.find(:all, :conditions=>["cbml = '#{self.cobama}'"])
    matriculas.each do |p|
      if c == p.matricula
        return true
      end  
    end
  end

  def valida_porce
    if self.calculo_vur <= 15 and self.acto_pot.to_s == "SI" and self.embargo.to_s == "NO" and self.rph.to_s == "NO"
      return true
    end
  end

  def fases1
    if self.ficha_radicado.to_s == 'SI' and self.acta_obs.to_s == 'SI' and self.alineamiento.to_s == 'SI'
      return true
    end
  end

  def fases3
    if self.viabilidad.to_s == 'SI'
      return true
    end
  end

  def tpprocedimiento
    if self.procedimiento.to_s != "" and self.tipoproceso.to_s == "SIN DEFINIR"
      errors.add :tipoproceso, "* Debe seleccionar un tipo de proceso diferente a SIN DEFINIR"
    end
  end

  def in_us1?
    self.comuna_id != 4 and self.comuna_id != 3
  end

  def validatipoproceso
    @cobama = self.cobama[0,2].to_s
    if @cobama.to_s != '90' and self.tipoproceso.to_s == "SANTA ELENA"
      errors.add :tipoproceso, "* Según el tipo de proceso el cobama no corresponde"
    end
  end

  def estadoproceso
    if self.estado.to_s != ""
      if self.estado.to_s == "EN PROCESO JURIDICO" and self.tipoproceso.to_s != "PERTENENCIA"
        errors.add :estado, "* Según el tipo de proceso el estado no Aplica."
      end
    end
  end

  def self.search (titulacion, identificacion, matricula, demanda, estadovisita, coba, fchinicial, fchfinal, page,perpage)
      cadena = ""
      if titulacion.id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id = ' + "#{titulacion.id.to_s.strip}"
        else
          cadena = ' id = ' + "#{titulacion.id.to_s.strip}"
        end
      end
      if titulacion.cobama != ""
        if cadena != ""
          cadena = cadena + ' and to_number(cobama) = ' + "'#{titulacion.cobama.to_i}'"
        else
          cadena = ' to_number(cobama) = ' + "'#{titulacion.cobama.to_i}'"
        end
      end
      if titulacion.manzana != ""
        if cadena != ""
          cadena = cadena + ' and manzana = ' + "'#{titulacion.manzana.to_s.strip}'"
        else
          cadena = ' manzana = ' + "'#{titulacion.manzana.to_s.strip}'"
        end
      end
      if titulacion.gestion_caja != ""
        if cadena != ""
          cadena = cadena + ' and gestion_caja = ' + "'#{titulacion.gestion_caja.to_s.strip}'"
        else
          cadena = ' gestion_caja = ' + "'#{titulacion.gestion_caja.to_s.strip}'"
        end
      end
      if titulacion.lote != ""
        if cadena != ""
          cadena = cadena + ' and lote = ' + "'#{titulacion.lote.to_s.strip}'"
        else
          cadena = ' lote = ' + "'#{titulacion.lote.to_s.strip}'"
        end
      end
      if titulacion.comuna_id.to_s != ""
        if cadena != ""
          cadena = cadena + ' and comuna_id = ' + "'#{titulacion.comuna_id.to_s}'"
        else
          cadena = ' comuna_id = ' + "'#{titulacion.comuna_id.to_s}'"
        end
      end
      if titulacion.estado != ""
        if cadena != ""
          cadena = cadena + ' and estado = ' + "'#{titulacion.estado.to_s.strip}'"
        else
          cadena = ' estado = ' + "'#{titulacion.estado.to_s.strip}'"
        end
      end
      if titulacion.tipoproceso != ""
        if cadena != ""
          cadena = cadena + ' and tipoproceso = ' + "'#{titulacion.tipoproceso.to_s.strip}'"
        else
          cadena = ' tipoproceso = ' + "'#{titulacion.tipoproceso.to_s.strip}'"
        end
      end
      if titulacion.situacionproceso != ""
        if cadena != ""
          cadena = cadena + ' and situacionproceso = ' + "'#{titulacion.situacionproceso.to_s.strip}'"
        else
          cadena = ' situacionproceso = ' + "'#{titulacion.situacionproceso.to_s.strip}'"
        end
      end
      if titulacion.procedimiento != ""
        if cadena != ""
          cadena = cadena + ' and procedimiento = ' + "'#{titulacion.procedimiento.to_s.strip}'"
        else
          cadena = ' procedimiento = ' + "'#{titulacion.procedimiento.to_s.strip}'"
        end
      end
      if titulacion.user_juridico.to_s != ""
        if cadena != ""
          cadena = cadena + ' and user_juridico = ' + "'#{titulacion.user_juridico.to_s}'"
        else
          cadena = ' user_juridico = ' + "'#{titulacion.user_juridico.to_s}'"
        end
      end
      if identificacion != ""
        if cadena != ""
          cadena = cadena + ' and id in (select distinct t.titulacion_id
                                         from   titulacionespersonas t, personas p
                                         where  t.persona_id = p.id
                                         and    p.identificacion = '+ "'#{identificacion.strip}'" +')'
        else
          cadena = cadena + ' id in (select distinct t.titulacion_id
                                     from   titulacionespersonas t, personas p
                                     where  t.persona_id = p.id
                                     and    p.identificacion = '+ "'#{identificacion.strip}'" +')'
        end
      end
      if matricula != ""
        if cadena != ""
          cadena = cadena + ' and id in (select titulacion_id from titulacionespersonas where matricula = '+ "'#{matricula.strip}'" +')'
        else
          cadena = cadena + ' id in (select titulacion_id from titulacionespersonas where matricula = '+ "'#{matricula.strip}'" +')'
        end
      end
      if demanda != ""
        if cadena != ""
          cadena = cadena + ' and id in (select titulacion_id from titulacionesdemandas where radicado like '+ "'%%#{demanda.strip}%%'" +')'
        else
          cadena = cadena + ' id in (select titulacion_id from titulacionesdemandas where radicado like '+ "'%%#{demanda.strip}%%'" +')'
        end
      end
      if estadovisita != ""
        if cadena != ""
          cadena = cadena + ' and id in (select distinct titulacion_id from titulacionesfallidos where estado_visita = '+ "'#{estadovisita.strip}'" +')'
        else
          cadena = cadena + ' id in (select distinct titulacion_id from titulacionesfallidos where estado_visita = '+ "'#{estadovisita.strip}'" +')'
        end
      end
      if coba != ""
        if cadena != ""
          cadena = cadena + ' and cobama like ' + "'#{coba.to_s}%%'"
        else
          cadena = ' cobama like ' + "'#{coba.to_s}%%'"
        end
      end
      if fchinicial.to_s != "" and fchfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id in (select titulacion_id from titulacionesvisitas where trunc(created_at) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}')"
        else
          cadena = ' id in (select titulacion_id from titulacionesvisitas where trunc(created_at) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}')"
        end
      end
      if cadena != ""
        #find(:all, :conditions => [cadena], :order => "to_number(caja), to_number(carpeta), barrio")
        paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "id"
      else
        paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at"
      end      
  end

  def self.searchgeo (titulacion, coba)
      cadena = ""
      if titulacion.estado != ""
        if cadena != ""
          cadena = cadena + ' and estado = ' + "'#{titulacion.estado.to_s.strip}'"
        else
          cadena = ' estado = ' + "'#{titulacion.estado.to_s.strip}'"
        end
      end
      if titulacion.tipoproceso != ""
        if cadena != ""
          cadena = cadena + ' and tipoproceso = ' + "'#{titulacion.tipoproceso.to_s.strip}'"
        else
          cadena = ' tipoproceso = ' + "'#{titulacion.tipoproceso.to_s.strip}'"
        end
      end
      if coba != ""
        if cadena != ""
          cadena = cadena + ' and cobama like ' + "'#{coba.to_s}%%'"
        else
          cadena = ' cobama like ' + "'#{coba.to_s}%%'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "id")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "id")
      end
  end

  def prestadoa
    cadena = ""
    @titulacion = Titulacion.find(self.id)
    @titulacion.titulacionespersonas.each do |titulacionespersona|
      if cadena != ""
        cadena = cadena + '<br/>' + titulacionespersona.persona.autobuscar rescue nil
      else
        cadena = titulacionespersona.persona.autobuscar rescue nil
      end
    end
    return cadena
  end

  def aplicasantaelena
    @cobama = self.cobama[0,2].to_s
    if @cobama.to_s == '90' and self.tipoproceso.to_s == "SANTA ELENA"
      return 'SI'
    else
     return 'NO'
    end
  end

  def variablesimagenes
    cadena = ""
    if self.prediag_reconocimiento.to_s == 'SI'
      if cadena != ""
        cadena = cadena + " union select * from titulacionesdoctipos where reconocimiento = 'SI'"
      else
        cadena = " select * from titulacionesdoctipos where reconocimiento = 'SI' "
      end
    end
    if self.prediag_rph.to_s == 'SI'
      if cadena != ""
        cadena = cadena + " union select * from titulacionesdoctipos where rph = 'SI'"
      else
        cadena = " select * from titulacionesdoctipos where rph = 'SI' "
      end
    end
    if self.prediag_pertenencia.to_s == 'SI'
      if cadena != ""
        cadena = cadena + " union select * from titulacionesdoctipos where pertenencia = 'SI'"
      else
        cadena = " select * from titulacionesdoctipos where pertenencia = 'SI'"
      end
    end
    if self.prediag_sucesion.to_s == 'SI'
      if cadena != ""
        cadena = cadena + " union select * from titulacionesdoctipos where sucesion = 'SI'"
      else
        cadena = " select * from titulacionesdoctipos where sucesion = 'SI' "
      end
    end
    if self.prediag_conformacion.to_s == 'SI'
      if cadena != ""
        cadena = cadena + " union select * from titulacionesdoctipos where conformacion = 'SI'"
      else
        cadena = " select * from titulacionesdoctipos where conformacion = 'SI' "
      end
    end
    if self.prediag_divisorio.to_s == 'SI' or self.prediag_particion.to_s == 'SI'
      if cadena != ""
        cadena = cadena + " union select * from titulacionesdoctipos where divisorio = 'SI'"
      else
        cadena = " select * from titulacionesdoctipos where divisorio = 'SI' "
      end
    end
    if cadena != ""
      return "union "+cadena.to_s
    end
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end

  def self.seachvisit(fchinicial,fchfinal,tipo,clase,user_id)
      cadena = ""
      if tipo != ""
        if cadena != ""
          cadena = cadena + ' and procedimiento ='+ "'RECONOCIMIENTO'"+' and id in (select titulacion_id from titulacionesvisitas where soc_estado = '+ "'#{tipo}'"+')'
        else
          cadena = cadena + ' procedimiento ='+ "'RECONOCIMIENTO'"+' and id in (select titulacion_id from titulacionesvisitas where soc_estado = '+ "'#{tipo}'"+')'
        end
      end
      if fchinicial.to_s != "" and fchfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id in (select titulacion_id from titulacionesvisitas where trunc(created_at) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}')"
        else
          cadena = cadena + ' id in (select titulacion_id from titulacionesvisitas where trunc(created_at) between ' + "'#{fchinicial.to_date}'" + ' and ' + "'#{fchfinal.to_date}')"
        end
      end
      if clase.to_s != ""
        if cadena !=""
          cadena = cadena + ' and procedimiento ='+ "'RECONOCIMIENTO'"+' and id in (select titulacion_id from titulacionesvisitas where clase = '+ "'#{clase}'"+')'
        else
          cadena = cadena + 'procedimiento ='+ "'RECONOCIMIENTO'"+'and id in (select titulacion_id from titulacionesvisitas where clase = '+ "'#{clase}'"+')'
        end
      end
      if user_id.to_i > 0
        if cadena != ""
          cadena = cadena + ' and procedimiento ='+ "'RECONOCIMIENTO'"+' and id in (select titulacion_id from titulacionesvisitas where user_id = '+ "'#{user_id}')"
        else
          cadena = cadena + 'procedimiento ='+ "'RECONOCIMIENTO'"+' and id in (select titulacion_id from titulacionesvisitas where user_id = '+ "'#{user_id}')"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
   end
end
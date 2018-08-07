class Ayuda < ActiveRecord::Base
  has_many :ayudaspagos, :dependent =>:destroy
  has_many :ayudasviviendas, :dependent =>:destroy
  has_many :ayudasnovedades, :dependent =>:destroy
  has_many :ayudasobservaciones, :dependent =>:destroy
  has_many :ayudasfichas, :dependent =>:destroy
  has_many :ayudastalleres, :dependent =>:destroy
  has_many :ayudasadicionales, :dependent =>:destroy
  has_many :ayudassociales, :dependent =>:destroy
  has_many :ayudaseventos, :dependent =>:destroy
  has_many :ayudasorientaciones, :dependent =>:destroy
  has_many :ayudascontratos, :dependent =>:destroy
  has_many :ayudasetapas, :dependent =>:destroy
  has_many :ayudasdocumentos, :dependent =>:destroy
  belongs_to :user
  belongs_to :persona
 # belongs_to :comuna

  validates_presence_of :persona_autobuscar
  #validate :comuna_exist, :persona_exist
  #validates_numericality_of :telefono_evento

  #validate :comuna_exist
  #validates_presence_of :acreditado, :quien_acredita, :atiende_como, :if => :in_acredita_si?
  #validates_presence_of :fecha_no_acreditacion, :atiende_como, :if => :in_acredita_no?
  #validates_presence_of :valorpredio_evac, :valorpredio_evac_seg, :if => :in_valorseg?
  #validates_presence_of :nro_matricula, :porc_derecho, :if => :in_predial?
  #validates_presence_of :nro_matricula, :porc_derecho, :if => :in_certificado_libertad?
  #validates_presence_of :autoriza_vivienda, :autor_isvimed, :if => :in_autorizacion?
  #validates_presence_of :no_autoriza_vivienda,:autor_isvimed, :if => :in_no_autorizacion?
  #validates_presence_of :fecha_declaracion, :if => :in_declaracion_juramentada?
  #validates_presence_of :entidad_postulacion, :if => :in_postulado?
  #validates_presence_of :fecha_envio, :if => :in_envio_postulacion?
  #validates_presence_of :fecha_devolucion, :if => :in_devuelto?
=begin
  def comuna_exist
    if self.comuna_id
      if !Comuna.exists?(["id = #{self.comuna_id}"])
         errors.add :comuna_descripcion2, "* El barrio no es valido"
      end
    else
      errors.add :comuna_descripcion2, "* El barrio no es valido"
    end
  end  
=end
  def persona_exist
    if self.persona_id
      if !Persona.exists?(["id = #{self.persona_id}"])
         errors.add :persona_autobuscar, "* El usuario no es valido"
      end
    else
      errors.add :persona_autobuscar, "* El usuario no es valido"
    end
  end   
=begin
  def comuna_descripcion2
    comuna.descripcion2 if comuna
  end

  def comuna_descripcion2=(descripcion2)
    self.comuna = Comuna.find_or_create_by_descripcion2(descripcion2) unless descripcion2.blank?
  end
=end
  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

#Busqueda
  def self.search (identificacion,nombre,tiporelacion,carpeta,direccion,nroficha)
      cadena = ""
      if identificacion != ""
        if cadena != ""
          cadena = cadena + " and persona_id in (select persona_id from relaciones where identificacion = '#{identificacion.strip}')"
        else
          cadena = cadena + " persona_id in (select persona_id from relaciones where identificacion = '#{identificacion.strip}')"
        end
      end

     if nombre != ""
        if cadena != ""
          cadena = cadena + " and persona_id in (select persona_id from relaciones where identificacion = '#{identificacion.strip}')"
        else
          cadena = cadena + " persona_id in (select persona_id from relaciones where identificacion = '#{identificacion.strip}')"
        end
      end

      if tiporelacion.to_s != ""
        if cadena != ""
          cadena = cadena + ' and categorias_isvimed = '+ "'#{categoriaisvimed}'"
        else
          cadena = cadena + ' categorias_isvimed = '+ "'#{categoriaisvimed}'"
        end
      end
      if carpeta.to_s != ""
        if cadena != ""
          cadena = cadena + ' and trunc(fecha_de_remision) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
        else
          cadena = cadena + ' trunc(fecha_de_remision) between ' + "'#{fchinicial}'" + ' and ' + "'#{fchfinal}'"
        end
      end

      if direccion.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id in (select ayuda_id from ayudasfichas where ayudastiposevento_id = '+ "'#{ayudastiposevento_id}'" +')'
        else
          cadena = cadena + ' id in (select ayuda_id from ayudasfichas where ayudastiposevento_id = '+ "'#{ayudastiposevento_id}'" +')'
        end
      end
      
      if nroficha.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id in (select ayuda_id from ayudasfichas where nro_ficha like '+ "'%%#{nroficha.to_s}%%'" +')'
        else
          cadena = cadena + ' id in (select ayuda_id from ayudasfichas where nro_ficha like '+ "'%%#{nroficha.to_s}%%'" +')'
        end
      end

      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end
#finbusqueda

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end


  def in_acredita_si?
    self.acreditado.to_s == "SI"
  end

  def in_acredita_no?
    self.acreditado.to_s == "NO"
  end

  def in_valorseg?
    self.valorpredio_evac_seg.to_s != ""
  end

  def in_predial?
    self.predial.to_s == "SI"
  end

  def in_certificado_libertad?
    self.certificado_libertad.to_s == "SI"
  end

  def in_autorizacion?
    return self.autoriza.to_s == "SI"
  end

  def in_no_autorizacion?
    return self.autoriza.to_s == "NO"
  end

  def in_declaracion_juramentada?
    return self.declara_juramentada.to_s == "SI"
  end

  def in_postulado?
    return self.entidad_postulacion.to_s == "SI"
  end

  def in_envio_postulacion?
    return self.enviado_a_postulacion.to_s == "SI"
  end

  def in_devuelto?
    return self.devuelto_por_isvimed.to_s == "SI"
  end
end


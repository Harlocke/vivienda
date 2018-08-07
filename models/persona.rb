class Persona < ActiveRecord::Base

  def to_param
    a = ("a".."z")
    s = ("A".."Z")
    b = (0..9)
    c = a.to_a + b.to_a + s.to_a+ b.to_a + b.to_a + s.to_a
    key = c.shuffle[0,15].join
    "#{id}!#{key}"
  end

  belongs_to :caja
  belongs_to :documento
  belongs_to :especial
  belongs_to :estados_civil
  belongs_to :familiar
  belongs_to :ocupacion
  belongs_to :parentesco
  belongs_to :sisben
  belongs_to :comuna

  has_many :moravias
  has_many :requerimientos
  has_many :viviendas
  has_many :subsidios
  has_many :creditos
  has_many :beneviviendas
  has_many :beneficiarios
  has_many :calificaciones
  has_many :rechazados
  has_many :viviendaspersonas
  has_many :viviendasrenuncias
  has_many :relaciones
  has_many :resolucionespersonas
  has_many :temporales
  has_many :iguanaspersonas
  has_many :iguanasrentistas
  has_many :viviendasusadaspersonas
  has_many :feria2009jefes
  has_many :feria2010jefes
  has_many :feria2014jefes
  has_many :feria2014beneficiarios
  has_many :feria2014puntajes
  has_many :feria2014imagenes
  has_many :feriadocentejefes
  has_many :viviendasreportes
  has_many :personasobservaciones
  has_many :antbeneviviendas
  has_many :antsubsidios
  has_many :antcreditos
  has_many :desplazados
  has_many :personasclasificaciones
  has_many :archivos
  has_many :archivospersonas
  has_many :obraspublicas
  has_many :correspondenciasrecibidas
  has_many :correspondenciasenviadas
  has_many :titulacionespersonas
  has_many :titulacionesdocumentos
  has_many :personastramites
  has_many :personassesiones
  has_many :ayudas
  has_many :procesospersonas
  has_many :personasretornos
  has_many :personascensos
  has_many :quejas
  has_many :cruces
  has_many :inmobiliario
  has_many :mejoramientos
  has_many :conveniospersonas
  has_many :personaslistas
  has_many :licitaciones
  has_many :personasbases
  has_many :fase2censos
  has_many :fase2beneficiarios
  has_many :valorizacionespersonas
  has_many :valorizacionesrentistas
  has_many :personasencuestas
  has_many :corvides
  has_many :corvidespersonas
  has_many :repartosinmuebles
  belongs_to :user

  #has_many :personasarrendamientos

  validates_presence_of :identificacion, :primer_nombre, :primer_apellido, :especial_id, :direccion,:grupo_etnico,:especial_id,:familiar_id,:sisben_id,:caja_id,:estrato, :tipo_discapacidad
  validates_uniqueness_of :identificacion
  validates_length_of :identificacion, :in=> 6...11, :message=>"La identificación debe ser entre 6 y 11 digitos. Verifique!!"
  validates_numericality_of :identificacion, :ingresos
  validates_numericality_of :telefonos1, :if => :in_us1?
  validates_numericality_of :telefonos2, :if => :in_us2?
  validates_numericality_of :celular, :if => :in_us3?
  validates_presence_of :proyecto_vipa, :vinculacion_opv, :miembro_jal, :carta_ahorro, :carta_credito, :feriavipa, :valor_ahorro, :valor_credito,:info_permamedellin2, :if => :in_usvipa?
  validates_presence_of :nombre_opv, :if => :in_usvipa1?
  validates_numericality_of :valor_ahorro, :valor_credito,:info_permamedellin2, :if => :in_usvipa?
  
  validates_presence_of :subsidio_familiar, :subsidio_invertido, :subsidio_restituido, :condicionfamiliar, 
                        :beneficiario_arrtemp, :feria_sisben,
                        :organizacion_vivienda, :recursos_complementarios, 
                        :recursos_programado, :recursos_ahorro, :recursos_credito,
                        :recursos_cesantias, :recursos_donaciones, :recursos_nacional,
                        :recursos_municipal, :recursos_otros, :recursos_especie_desc,
                        :recursos_especie_cuan, :recursos_especie_entidad, :recursos_materiales,
  # Campos de Actualizacion de Feria
                        :genero, :fecha_nacimiento, :lugar_nacimiento, :estado_civil_id, :ocupacion_id, :lgbti, :ciudad, :tipo_contrato, :tipo_discapacidad,
                        :caja_id, :subsidio_aspira, :if => :in_usferia?                        
  #validates_format_of :e_mail, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => '* Correo electronico invalido', :if => :in_usemail?

  validate :identificacions
  validate :telefons
  validate :validaahorro, :if => :in_usvipa?
  validate :comuna_exist
  validate :datosferia, :if => :in_usferia?

  def in_usferia?
    self.habilitado_feria.to_s == "SI" and self.recursos_complementarios.to_s == 'SI'
  end

  def datosferia
    if self.recursos_complementarios.to_s == 'SI'
      if self.subsidio_invertido.to_s == "SI" and self.subsidio_invertido_en.to_s == ""
        errors.add :subsidio_invertido_en, "* El dato es obligatorio"
      end
      if self.subsidio_restituido.to_s == "SI" and self.subsidio_restituido_fecha.to_s == ""
        errors.add :subsidio_restituido_fecha, "* El dato es obligatorio"
      end
      if self.recursos_programado.to_s == "SI" and self.recursos_programado_entidad.to_s == ""
        errors.add :recursos_programado_entidad, "* El dato es obligatorio"
      end
      if self.recursos_ahorro.to_s == "SI" and self.recursos_ahorro_entidad.to_s == ""
        errors.add :recursos_ahorro_entidad, "* El dato es obligatorio"
      end 
      if self.recursos_credito.to_s == "SI" and self.recursos_credito_entidad.to_s == ""
        errors.add :recursos_credito_entidad, "* El dato es obligatorio"
      end
      if self.recursos_cesantias.to_s == "SI" and self.recursos_cesantias_entidad.to_s == ""
        errors.add :recursos_cesantias_entidad, "* El dato es obligatorio"
      end
      if self.recursos_donaciones.to_s == "SI" and self.recursos_donaciones_entidad.to_s == ""
        errors.add :recursos_donaciones_entidad, "* El dato es obligatorio"
      end
      if self.recursos_nacional.to_s == "SI" and self.recursos_nacional_fecha.to_s == "" and self.recursos_nacional_resol.to_s == ""
        errors.add :recursos_nacional_fecha, "* El dato es obligatorio"
        errors.add :recursos_nacional_resol, "* El dato es obligatorio"
      end
      if self.recursos_municipal.to_s == "SI" and self.recursos_municipal_fecha.to_s == "" and self.recursos_municipal_resol.to_s == ""
        errors.add :recursos_municipal_fecha, "* El dato es obligatorio"
        errors.add :recursos_municipal_resol, "* El dato es obligatorio"
      end
      if self.recursos_otros.to_s == "SI" and self.recursos_otros_entidad.to_s == ""
        errors.add :recursos_otros_entidad, "* El dato es obligatorio"
      end
      if self.recursos_materiales.to_s == "SI" and self.recursos_materiales_entidad.to_s == ""
        errors.add :recursos_materiales_entidad, "* El dato es obligatorio"
      end
      if self.organizacion_vivienda.to_s == "SI" and self.organizacion_cual.to_s == ""
        errors.add :organizacion_cual, "* El dato es obligatorio"
      end

      
    end        
  end

  def comuna_exist
    if self.comuna_id
      if !Comuna.exists?(["id = #{self.comuna_id}"])
         errors.add :comuna_descripcion2, "* El barrio no es valido"
      end
    else
      errors.add :comuna_descripcion2, "* El barrio no es valido"
    end
  end  

  def comuna_descripcion2
    comuna.descripcion2 if comuna
  end

  def comuna_descripcion2=(descripcion2)
    self.comuna = Comuna.find_or_create_by_descripcion2(descripcion2) unless descripcion2.blank?
  end

  def validaahorro
    if self.valor_ahorro.to_i < 2156000
      errors.add :valor_ahorro, "* El Ahorro programado no puede ser inferior a 2.156.000"
    end
  end

  def identificacions
    if Benevivienda.exists?(["ltrim(rtrim(identificacion)) = ?", self.identificacion]) == true
      errors.add :identificacion, "Identificacion ya registrada como beneficiarios"
    end
  end

  def telefons
    if self.telefonos1.to_s == "" and self.telefonos2.to_s == "" and self.celular.to_s == ""
      errors.add :telefonos1, "Debe tener minimo 1 Telefono"
      errors.add :telefonos2, "Debe tener minimo 1 Telefono"
      errors.add :celular, "Debe tener minimo 1 Telefono"
    end
  end

  def in_us1?
    self.telefonos1.to_s != ""
  end

  def in_us2?
    self.telefonos2.to_s != ""
  end

  def in_us3?
    self.celular.to_s != ""
  end

  def in_usvipa?
    self.feriavipa.to_s == "SI"
  end

  def in_usvipa1?
    self.feriavipa.to_s == "SI" and self.vinculacion_opv.to_s == "SI"
  end

  def in_usemail?
    self.e_mail.to_s != ""
  end

  def after_create
    logger.error("Ingreso con el ID.."+self.id.to_s)
    ActiveRecord::Base.connection.execute("begin prc_relaciones(#{self.id.to_i}); end;")
    #habilitarelaciones(self.id, self.identificacion)
  end

  def before_save
    identi = (self.identificacion.to_i).to_s.strip
    self.identificacion = identi
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
    #habilitarelaciones(self.id, self.identificacion)    
  end

  def after_save
    ActiveRecord::Base.connection.execute("begin prc_relaciones(#{self.id.to_i}); end;")    
  end

=begin
  def habilitarelaciones(id_persona, identificacion)
      begin
        Relacion.destroy_all("persona_id = #{id_persona}")
      rescue
        a = "no Existe"
      end
      u = Relacion.new
      u.persona_id = id_persona
      u.identificacion = identificacion
      u.save
      ActiveRecord::Base.connection.execute("begin prc_cruceverifica(#{identificacion.to_i}); end;")
      beneviviendas = Benevivienda.find_all_by_persona_id(id_persona)
      beneviviendas.each do |data|
        if data.identificacion.nil? == false
          u = Relacion.new
          u.persona_id = id_persona
          u.identificacion = data.identificacion
          u.benevivienda_id = data.id
          u.save
          ActiveRecord::Base.connection.execute("begin prc_cruceverifica(#{data.identificacion.to_i}); end;")
          #actualizacruce(data.identificacion,id_persona)
        end
      end
  end
=end  

  def self.search(search, page)
      if search.nil?
         s = search.strip
         s = s.strip
      else
         s = search.upcase
         s = s.strip
      end
      paginate :per_page => 10,
               :page => page,
               :conditions => ['primer_nombre like ? or segundo_nombre like ?
                               or primer_apellido like ?
                               or identificacion = ?', "%#{s}%", "%#{s}%", "%#{s}%", "#{s}"],
               :order => 'primer_nombre'
  end

  def telefonos
    tel =  ""
    if self.telefonos1.nil? == false
      tel = tel + self.telefonos1.to_s + " - "
    end
    if self.telefonos2.nil? == false
      tel = tel + self.telefonos2.to_s + " - "
    end
    if self.celular.nil? == false
      tel = tel + self.celular.to_s
    end
    return tel
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

  def self.buscar(buscarident, buscarnombre, buscargrupo,page)
    cadena = ""
    if buscarident.to_s == "" and buscarnombre.to_s == "" and buscargrupo.to_s == ""
      paginate :per_page => 10, :page => page, :conditions => ["id = '-1'"]
    else
      if buscarident != ""
        cadena = "id in (select persona_id from relaciones where identificacion = '#{buscarident.strip}')"
      elsif buscarnombre != ""
        s = buscarnombre.upcase
        cadena = "autobuscar like '%%#{s.to_s.strip}%%'"
      else
        if buscargrupo != ""
          s = buscargrupo.upcase
          cadena = "id in (select persona_id from beneviviendas where autobuscar like '%%#{s.to_s.strip}%%')"
        end
      end
      paginate :per_page => 10, :page => page, :conditions => [cadena], :order=>'primer_nombre, segundo_nombre,primer_apellido,segundo_apellido'
    end
  end

  def self.buscarferia(buscarident)
    if buscarident != ""
      find(:all, :conditions => [' id in (select persona_id from relaciones where identificacion = ?) ', "#{buscarident.strip}"], :order=>'primer_nombre, segundo_nombre,primer_apellido,segundo_apellido')
    end
  end

  def generos
    case self.genero
    when true then "MASCULINO"
    when false then "FEMENINO"
    end
  end

  def fchsubnacionalres
    return Subsidio.find(:first, :conditions=>["persona_id = #{self.id} and tipos_subsidio_id = 4 and valor > 0"]).resolucion rescue nil
  end

  def fchsubnacionalfch
    @objetos = Subsidio.find_by_sql(["select to_char(fecha_asig,'dd/mm/YYYY') fch, fecha_asig
                                      from   subsidios
                                      where  persona_id = #{self.id} and tipos_subsidio_id = 4 and valor > 0"])
    @objetos.each do |objeto|
      return objeto.fecha_asig
    end
#    #@var = Subsidio.find(:first, :conditions=>["persona_id = #{self.id} and tipos_subsidio_id = 4 and valor > 0"]).fecha_asig
#    #@var1 = @var.to_date
#    logger.error("varrrr..."+@var.to_s)
#    return @var.to_s rescue nil
  end

  def validaregpqrs
    valida = ""
    if self.telefonos1.to_s == "" and self.telefonos2.to_s == "" and self.celular.to_s == ""
      valida = valida + "* Falta registrar minimo un (1) telefono.<br/>"
    end
    if self.e_mail.to_s == ""
      valida = valida + "* Falta registrar el email o registrar N/A en dicho campo.<br/>"
    end
    if self.direccion.to_s == ""
      valida = valida + "* Falta registrar dirección de ubicación.<br/>"
    end
    return valida
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end

  def existeresolucionespersona
    return self.resolucionespersonas.exists?
  end

end

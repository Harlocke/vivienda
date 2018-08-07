class Queja < ActiveRecord::Base
  has_many :quejasobservaciones
  has_many :quejasbitacoras
  belongs_to :persona
  belongs_to :comuna
  belongs_to :correspondenciasrecibida
  has_many :quejasimagenes

  validates_presence_of :tipopqrs, :primer_nombre, :primer_apellido, :descripcion, :direccion, :email
  validates_numericality_of :identificacion, :message => "* La identificación no debe tener ni espacios ni caracteres diferentes a numeros"
  validates_length_of :identificacion, :in=> 6...11, :message=>"La identificación debe ser entre 6 y 11 digitos. Verifique!!"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => '* Correo electrónico invalido', :if => :in_usemail?
  validate :telefons

  #validate :oo
  #validate :identificacions

  def in_usemail?
    self.procedencia.to_s != "OTRO"
  end

  def identificacions
    if Benevivienda.exists?(["ltrim(rtrim(identificacion)) = ?", self.identificacion]) == true
      errors.add :identificacion, "Identificacion ya registrada como beneficiarios"
    end
  end

  def telefons
    if self.telefono.to_s == "" and self.celular.to_s == ""
      errors.add :telefono, "Debe tener minimo 1 Telefono"
      errors.add :celular, "Debe tener minimo 1 Telefono"
    end
  end

  def in_us1?
    self.telefono.to_s != ""
  end

  def in_us2?
    self.celular.to_s != ""
  end
  
  def oo
    if (self.dependencia_direccion == 'NO' and self.dependencia_comunicaciones == 'NO' and self.dependencia_control == 'NO' and self.dependencia_administrativa == 'NO' and self.dependencia_tecnica == 'NO' and self.dependencia_social == 'NO' and self.dependencia_juridica == 'NO' and self.dependencia_titulaciones == 'NO')
        errors.add :area, "* Debe seleccionar minimo 1 Dependencia"
    end
  end

  def before_create
    if Persona.exists?(["identificacion = '#{self.identificacion}'"])
      self.persona_id = Persona.find_by_identificacion(self.identificacion).id
    elsif Benevivienda.exists?(["identificacion = '#{self.identificacion}'"])
      self.benevivienda_id = Benevivienda.find_by_identificacion(self.identificacion).id
    else
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
      ActiveRecord::Base.connection.execute(
      "insert into personas (id, identificacion, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, autobuscar, created_at, updated_at, direccion, telefonos1, celular, e_mail, comuna_id)
       values (personas_seq.nextval,'#{self.identificacion}','#{self.primer_nombre}','#{self.segundo_nombre}','#{self.primer_apellido}','#{self.segundo_apellido}','#{nom}',sysdate,sysdate,'#{self.direccion}',
               '#{self.telefono}','#{self.celular}','#{self.email}','#{self.comuna_id}')")
      id_persona = Persona.find_by_identificacion(self.identificacion).id
      relaciones = Relacion.find_all_by_persona_id(id_persona)
      relaciones.each do |data|
        data.destroy
      end
      u = Relacion.new
      u.persona_id = id_persona
      u.identificacion = self.identificacion
      u.save
      self.persona_id = id_persona
    end
  end

  def self.search (creainicial,creafinal,tipopqrs,identificacion,observacion,radicado,page,perpage)
    cadena = ""
    if creainicial.to_s != "" and creafinal.to_s != ""
      if cadena != ""
        cadena = cadena + ' and trunc(created_at) between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
      else
        cadena = cadena + ' trunc(created_at) between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
      end
    end
    if tipopqrs.to_s != ""
      if cadena != ""
        cadena = cadena + ' and tipopqrs = '+ "'#{tipopqrs.strip}'"
      else
        cadena = cadena + ' tipopqrs = '+ "'#{tipopqrs.strip}'"
      end
    end
    if identificacion.to_s != ""
      if cadena != ""
        cadena = cadena + ' and identificacion = '+ "'#{identificacion.strip}'"
      else
        cadena = cadena + ' identificacion = '+ "'#{identificacion.strip}'"
      end
    end
    if observacion.to_s != ""
      s = observacion.upcase
      if cadena != ""
        cadena = cadena + ' and upper(descripcion) like '+ "'%%#{s.to_s.strip}%%'"
      else
        cadena = ' upper(descripcion) like '+ "'%%#{s.to_s}%%'"
      end
    end
    if radicado.to_s != ""
      if cadena != ""
        cadena = cadena + ' and id = '+ "'#{radicado.strip}'"
      else
        cadena = cadena + ' id = '+ "'#{radicado.strip}'"
      end
    end
     if cadena != ""
      paginate :per_page => perpage, :page => page, :conditions => [cadena], :order => "created_at"
    else
      paginate :per_page => perpage, :page => page, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at"
    end
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

  def self.mensajepqrs(queja)
    @correos = Parametro.find(28).valor.to_s
    begin
      Notifier.deliver_queja_message(@correos,queja)
    rescue Exception => exc
      logger.error("SIFI ERROR Queja - No enviado")
    end
  end

  def after_create
    quejasbitacora = Quejasbitacora.new
    quejasbitacora.consecutivo = 1
    quejasbitacora.queja_id = self.id
    quejasbitacora.actividad = 'CREACION DE PQRS - PROCEDENCIA: '+self.procedencia.to_s+", ESTADO: "+self.estado.to_s
    quejasbitacora.inicio = self.created_at
    quejasbitacora.user_id = self.user_id
    quejasbitacora.save
    if self.solucion.to_s != "" and self.tema_p.to_s == "SI"
      quejasobservacion = Quejasobservacion.new
      quejasobservacion.queja_id = self.id
      quejasobservacion.tipo_atencion = '1'
      quejasobservacion.observacion = self.solucion
      quejasobservacion.user_id = self.user_id
      quejasobservacion.save
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id}")
      quejasbitacora = Quejasbitacora.new
      quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
      quejasbitacora.queja_id = self.id
      quejasbitacora.actividad = 'CIERRE PQRS '
      quejasbitacora.inicio = self.created_at
      quejasbitacora.user_id = self.user_id
      quejasbitacora.save
    end
  end

  def after_save
    queja = Queja.find(self.id)
    dato1 = ""
    dato2 = ""
    dato3 = ""
    dato4 = ""
    dato5 = ""
    dato6 = ""
    dato7 = ""
    dato8 = ""
    dato9 = ""
    dato10 = ""
    dato11 = ""
    dato12 = ""
    dato13 = ""
    dato14 = ""
    dato15 = ""    
    dato16 = ""    
    dato17 = ""    
    dato18 = ""    
    dato19 = ""    
    dato20 = ""    
    dato21 = ""    
    dato22 = ""    
    dato23 = ""    
    dato24 = ""    
    dato25 = ""    
    dato26 = ""
    dato27 = "" 
    ingreso = 0
    if self.tema_vn1.to_s == 'SI' and self.tema_vn1_env.to_s == ""
      ingreso = ingreso + 1
      #Enviar email y marcar enviado....
      begin
        dato1 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO VIVIENDA NUEVA '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_vn2.to_s == 'SI' and self.tema_vn2_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato2 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO VIVIENDA NUEVA POSTULACION - ASIGNACION'
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_vu.to_s == 'SI' and self.tema_vu_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato3 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO VIVIENDA USADA'
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_m.to_s == 'SI' and self.tema_m_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato4 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO MEJORAMIENTO '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_msb.to_s == 'SI' and self.tema_msb_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato5 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO MEJORAMIENTO SIN BARRERAS '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_t.to_s == 'SI' and self.tema_t_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato6 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO TITULACION '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_l.to_s == 'SI' and self.tema_l_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato7 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO LEGALIZACION'
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_d.to_s == 'SI' and self.tema_d_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato8 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO DESENGLOBE '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_at.to_s == 'SI' and self.tema_at_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato9 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO ARRENDAMIENTO TEMPORAL '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_po.to_s == 'SI' and self.tema_po_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato10 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO POSTVENTAS '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_e.to_s == 'SI' and self.tema_e_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato11 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO ESCRITURACION '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_ga.to_s == 'SI' and self.tema_ga_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato12 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO GESTION ADMINISTRATIVA Y FINANCIERA '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_gi.to_s == 'SI' and self.tema_gi_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato13 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO GESTION DE INFRAESTRUCTURA INTERNA '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_gd.to_s == 'SI' and self.tema_gd_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato14 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO GESTION DOCUMENTAL '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_gt.to_s == 'SI' and self.tema_gt_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato15 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO GESTION DE LAS TICS '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_gh.to_s == 'SI' and self.tema_gh_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato16 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO GESTION HUMANA '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_ava.to_s == 'SI' and self.tema_ava_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato17 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO AUTORIZACION PARA VENTA O ARRENDAMIENTO '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_ch.to_s == 'SI' and self.tema_ch_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato18= 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO CANCELACION DE HIPOTECAS '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_rs.to_s == 'SI' and self.tema_rs_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato19 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO RENUNCIA A SUBSIDIOS '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_te.to_s == 'SI' and self.tema_te_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato20 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PROCESO TRAMITES DE ESCRITURACION '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_opv.to_s == 'SI' and self.tema_opv_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato21 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE OPV '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end    
    if self.tema_cop.to_s == 'SI' and self.tema_cop_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato22 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE COPROPIEDADES '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end    
    if self.tema_pos.to_s == 'SI' and self.tema_pos_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato23 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE POSTULACIONES '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end     
    if self.tema_des.to_s == 'SI' and self.tema_des_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato24 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE DESPLAZADOS '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end 
    if self.tema_rea.to_s == 'SI' and self.tema_rea_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato25 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE REASENTAMIENTO '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end 
    if self.tema_pla.to_s == 'SI' and self.tema_pla_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato26 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE PLANEACION '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end
    if self.tema_entr.to_s == 'SI' and self.tema_entr_env.to_s == ""
      ingreso = ingreso + 1
      begin
        dato27 = 'SI'
        quejasbitacora = Quejasbitacora.new
        quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
        quejasbitacora.queja_id = self.id
        quejasbitacora.actividad = 'ASIGNACION DE ENTREGAS '
        quejasbitacora.inicio = Time.now
        quejasbitacora.user_id = self.useract_id
        quejasbitacora.save
        rescue Exception => exc
           logger.error("SIFI PQRS #{queja.id} NO enviado")
      end
    end 

    if ingreso > 0 and self.correspondenciasrecibida_id.to_s == ""
      #Radica documento
      c = Correspondenciasrecibida.new
      c.user_id = self.useract_id
      c.useract_id = self.useract_id
      c.respuesta = 'NO'
      c.fecha_recibido = Time.now
      c.nro_radicado = local_nextrecibida
      c.fecha_elaboracion = self.created_at
      c.persona_id = self.persona_id
      c.asunto = self.tipopqrs.to_s + " NRO #{self.id} SOLICITADA POR (" + self.procedencia.to_s + ') ASOCIADA A EL(LOS) TEMA(S) '+ self.temadesc.gsub("<br/>","").upcase.to_s
      c.dependencia_id = 10002
      if self.tipopqrs.to_s == 'QUEJA' or self.tipopqrs.to_s == 'RECLAMO'
        c.correspondenciasclase_id = 10002
      elsif self.tipopqrs.to_s == 'PETICION'
        c.correspondenciasclase_id = 10000
      elsif self.tipopqrs.to_s == 'DENUNCIA'
        c.correspondenciasclase_id = 10005
      elsif self.tipopqrs.to_s == 'SUGERENCIA'
        c.correspondenciasclase_id = 10041
      end
      dias = 10
      begin
        festivos = Festivo.find_by_sql("select fnc_dias(to_date('#{Time.now}','dd/mm/yyyy'),#{dias}) fch from dual")
        festivos.each do |festivo|
          c.fecha_limite = festivo.fch
        end
      rescue
        c.fecha_limite = ""
      end
      c.anno = Time.now.strftime("%Y")
      c.observacion = self.descripcion
      c.save
      ActiveRecord::Base.connection.execute("update quejas set correspondenciasrecibida_id = #{c.id} where id = #{self.id}")
    end
    queja = Queja.find(self.id)
    if dato1.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(38).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_vn1_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato2.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(39).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_vn2_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato3.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(40).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_vu_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato4.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(41).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_m_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato5.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(42).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_msb_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato6.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(43).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_t_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato7.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(44).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_l_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato8.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(45).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_d_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato9.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(46).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_at_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato10.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(47).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_po_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato11.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(48).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_e_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato12.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(49).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_ga_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato13.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(50).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_gi_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato14.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(51).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_gd_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato15.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(52).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_gt_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato16.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(53).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_gh_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato17.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(61).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_ava_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")        
    end
    if dato18.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(62).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_ch_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato19.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(63).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_rs_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato20.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(64).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_te_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato21.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(90).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_opv_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato22.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(94).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_cop_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato23.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(95).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_pos_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato24.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(96).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_des_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato25.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(97).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_rea_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end    
    if dato26.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(103).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_pla_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end
    if dato27.to_s == 'SI'
      Notifier.deliver_queja_message(Sifi.find(105).valor.to_s,queja)
      ActiveRecord::Base.connection.execute("update quejas set tema_entr_env = 'SI' where id = #{self.id}")
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = sysdate where queja_id = #{self.id} and fin is null")
    end   

    if self.estado.to_s == "CERRADO"
      ActiveRecord::Base.connection.execute("update quejasbitacoras set fin = '#{self.created_at}' where queja_id = #{self.id} and fin is null")
      quejasbitacora = Quejasbitacora.new
      quejasbitacora.consecutivo = Quejasbitacora.maximum("consecutivo", :conditions=>["queja_id = #{self.id}"]).to_i + 1
      quejasbitacora.queja_id = self.id
      quejasbitacora.actividad = 'CIERRE PQRS '
      quejasbitacora.inicio = Time.now
      quejasbitacora.user_id = self.useract_id
      quejasbitacora.save
    end
  end

  def temadesc
    cadena = ""
    if self.tema_vn1.to_s == "SI"
      cadena = cadena + '* Vivienda Nueva<br/>'
    end
    if self.tema_vn2.to_s == "SI"
      cadena = cadena + '* Vivienda Nueva ( Postulacion - Asignacion )<br/>'
    end
    if self.tema_vu.to_s == "SI"
      cadena = cadena + '* Vivienda Usada<br/>'
    end
    if self.tema_m.to_s == "SI"
      cadena = cadena + '* Mejoramiento<br/>'
    end
    if self.tema_msb.to_s == "SI"
      cadena = cadena + '* Mejoramiento Sin Barreras<br/>'
    end
    if self.tema_t.to_s == "SI"
      cadena = cadena + '* Titulacion<br/>'
    end
    if self.tema_l.to_s == "SI"
      cadena = cadena + '* Legalizacion<br/>'
    end
    if self.tema_d.to_s == "SI"
      cadena = cadena + '* Desenglobe<br/>'
    end
    if self.tema_at.to_s == "SI"
      cadena = cadena + '* Arrendamiento Temporal<br/>'
    end
    if self.tema_p.to_s == "SI"
      cadena = cadena + '* PQRS<br/>'
    end
    if self.tema_po.to_s == "SI"
      cadena = cadena + '* Postventas<br/>'
    end
    if self.tema_e.to_s == "SI"
      cadena = cadena + '* Escrituracion<br/>'
    end
    if self.tema_ga.to_s == "SI"
      cadena = cadena + '* Gestion administrativa y financiera<br/>'
    end
    if self.tema_gi.to_s == "SI"
      cadena = cadena + '* Gestion de infraestructura interna<br/>'
    end
    if self.tema_gd.to_s == "SI"
      cadena = cadena + '* Gestion documental<br/>'
    end
    if self.tema_gt.to_s == "SI"
      cadena = cadena + '* Gestion de las Tics<br/>'
    end
    if self.tema_gh.to_s == "SI"
      cadena = cadena + '* Gestion humana<br/>'
    end
    if self.tema_ava.to_s == "SI"
      cadena = cadena + '* Autorizacion para venta o arrendamiento<br/>'
    end
    if self.tema_ch.to_s == "SI"
      cadena = cadena + '* Cancelacion de hipotecas<br/>'
    end
    if self.tema_rs.to_s == "SI"
      cadena = cadena + '* Renuncia a subsidios<br/>'
    end
    if self.tema_te.to_s == "SI"
      cadena = cadena + '* Tramites de escrituracion<br/>'
    end
    if self.tema_opv.to_s == "SI"
      cadena = cadena + '* OPV<br/>'
    end    
    if self.tema_cop.to_s == "SI"
      cadena = cadena + '* Copropiedades<br/>'
    end    
    if self.tema_pos.to_s == "SI"
      cadena = cadena + '* Postulaciones<br/>'
    end    
    if self.tema_des.to_s == "SI"
      cadena = cadena + '* Desplazados<br/>'
    end    
    if self.tema_rea.to_s == "SI"
      cadena = cadena + '* Reasentamiento<br/>'
    end       
    if self.tema_pla.to_s == "SI"
      cadena = cadena + '* Planeacion<br/>'
    end
    if self.tema_entr.to_s == "SI"
      cadena = cadena + '* Entregas<br/>'
    end      
    return cadena.to_s
  end

  def temadesc_informe
    cadena = ""
    if self.tema_vn1.to_s == "SI"
      cadena = cadena + 'Vivienda Nueva - '
    end
    if self.tema_vn2.to_s == "SI"
      cadena = cadena + 'Vivienda Nueva ( Postulacion - Asignacion ) - '
    end
    if self.tema_vu.to_s == "SI"
      cadena = cadena + 'Vivienda Usada - '
    end
    if self.tema_m.to_s == "SI"
      cadena = cadena + 'Mejoramiento - '
    end
    if self.tema_msb.to_s == "SI"
      cadena = cadena + 'Mejoramiento Sin Barreras - '
    end
    if self.tema_t.to_s == "SI"
      cadena = cadena + 'Titulacion - '
    end
    if self.tema_l.to_s == "SI"
      cadena = cadena + 'Legalizacion - '
    end
    if self.tema_d.to_s == "SI"
      cadena = cadena + 'Desenglobe - '
    end
    if self.tema_at.to_s == "SI"
      cadena = cadena + 'Arrendamiento Temporal - '
    end
    if self.tema_p.to_s == "SI"
      cadena = cadena + 'PQRS - '
    end
    if self.tema_po.to_s == "SI"
      cadena = cadena + 'Postventas - '
    end
    if self.tema_e.to_s == "SI"
      cadena = cadena + 'Escrituracion - '
    end
    if self.tema_ga.to_s == "SI"
      cadena = cadena + 'Gestion administrativa y financiera - '
    end
    if self.tema_gi.to_s == "SI"
      cadena = cadena + 'Gestion de infraestructura interna - '
    end
    if self.tema_gd.to_s == "SI"
      cadena = cadena + 'Gestion documental - '
    end
    if self.tema_gt.to_s == "SI"
      cadena = cadena + 'Gestion de las Tics - '
    end
    if self.tema_gh.to_s == "SI"
      cadena = cadena + 'Gestion humana - '
    end
    if self.tema_ava.to_s == "SI"
      cadena = cadena + 'Autorizacion para venta o arrendamiento - '
    end
    if self.tema_ch.to_s == "SI"
      cadena = cadena + 'Cancelacion de hipotecas - '
    end
    if self.tema_rs.to_s == "SI"
      cadena = cadena + 'Renuncia a subsidios - '
    end
    if self.tema_te.to_s == "SI"
      cadena = cadena + 'Tramites de escrituracion - '
    end
    if self.tema_opv.to_s == "SI"
      cadena = cadena + 'OPV - '
    end    
    if self.tema_cop.to_s == "SI"
      cadena = cadena + 'Copropiedades - '
    end    
    if self.tema_pos.to_s == "SI"
      cadena = cadena + 'Postulaciones - '
    end    
    if self.tema_des.to_s == "SI"
      cadena = cadena + 'Desplazados - '
    end    
    if self.tema_rea.to_s == "SI"
      cadena = cadena + 'Reasentamiento - '
    end    
    if self.tema_pla.to_s == "SI"
      cadena = cadena + 'Planeacion - '
    end
    if self.tema_entr.to_s == "SI"
      cadena = cadena + 'Entregas - '
    end    
    return cadena.to_s
  end  

  def envio_tema_vn1
    if self.tema_vn1_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_vn2
    if self.tema_vn2_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_vu
    if self.tema_vu_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_m
    if self.tema_m_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_msb
    if self.tema_msb_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_t
    if self.tema_t_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_l
    if self.tema_l_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_d
    if self.tema_d_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_at
    if self.tema_at_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end


  def envio_tema_po
    if self.tema_po_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_e
    if self.tema_e_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_ga
    if self.tema_ga_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_gi
    if self.tema_gi_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_gd
    if self.tema_gd_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_gt
    if self.tema_gt_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_gh
    if self.tema_gh_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_ava
    if self.tema_ava_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_ch
    if self.tema_ch_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_rs
    if self.tema_rs_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_te
    if self.tema_te_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_opv
    if self.tema_opv_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end  

  def envio_tema_cop
    if self.tema_cop_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end  

  def envio_tema_pos
    if self.tema_pos_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end  

  def envio_tema_des
    if self.tema_des_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end  

  def envio_tema_rea
    if self.tema_rea_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end  

  def envio_tema_pla
    if self.tema_pla_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end

  def envio_tema_entr
    if self.tema_entr_env.to_s == 'SI'
      return "<img src='/images/connect.png' tittle='Enviado'/>"
    end
  end 

  def quejaidentificacion
    if self.persona_id
      return Persona.find(self.persona_id).identificacion.to_s
    elsif self.benevivienda_id
      return Benevivienda.find(self.benevivienda_id).identificacion.to_s
    end
  end

  def quejanombre
    if self.persona_id
      return Persona.find(self.persona_id).nombres.to_s
    elsif self.benevivienda_id
      return Benevivienda.find(self.benevivienda_id).nombres.to_s
    end
  end

  def local_nextrecibida
    last_id = Correspondenciasrecibida.maximum('id')
    begin
      objeto = Correspondenciasrecibida.find(last_id)
      if objeto.created_at.strftime("%Y") == Time.now.strftime("%Y")
        nextdato = objeto.nro_radicado.to_i + 1
      else
        nextdato = '1'
      end
    rescue
      nextdato = '1'
    end
    return nextdato
  end

  def desc_tema_vn1
    return Sifi.find(38).valor.to_s
  end

  def desc_tema_vn2
    return Sifi.find(39).valor.to_s
  end

  def desc_tema_vu
    return Sifi.find(40).valor.to_s
  end

  def desc_tema_m
    return Sifi.find(41).valor.to_s
  end

  def desc_tema_msb
    return Sifi.find(42).valor.to_s
  end

  def desc_tema_t
    return Sifi.find(43).valor.to_s
  end

  def desc_tema_l
    return Sifi.find(44).valor.to_s
  end

  def desc_tema_d
    return Sifi.find(45).valor.to_s
  end

  def desc_tema_at
    return Sifi.find(46).valor.to_s
  end

  def desc_tema_po
    return Sifi.find(47).valor.to_s
  end

  def desc_tema_e
    return Sifi.find(48).valor.to_s
  end

  def desc_tema_ga
    return Sifi.find(49).valor.to_s
  end

  def desc_tema_gi
    return Sifi.find(50).valor.to_s
  end

  def desc_tema_gd
    return Sifi.find(51).valor.to_s
  end

  def desc_tema_gt
    return Sifi.find(52).valor.to_s
  end

  def desc_tema_gh
    return Sifi.find(53).valor.to_s
  end

  def desc_tema_ava
    return Sifi.find(61).valor.to_s
  end

  def desc_tema_ch
    return Sifi.find(62).valor.to_s
  end

  def desc_tema_rs
    return Sifi.find(63).valor.to_s
  end

  def desc_tema_te
    return Sifi.find(64).valor.to_s
  end  

  def desc_tema_opv
    return Sifi.find(90).valor.to_s
  end    

  def desc_tema_cop
    return Sifi.find(94).valor.to_s
  end    

  def desc_tema_pos
    return Sifi.find(95).valor.to_s
  end    

  def desc_tema_des
    return Sifi.find(96).valor.to_s
  end    

  def desc_tema_rea
    return Sifi.find(97).valor.to_s
  end    

  def desc_tema_pla
    return Sifi.find(103).valor.to_s
  end

  def desc_tema_entr
    return Sifi.find(105).valor.to_s
  end  

  def radsalida
    if Correspondenciasradicado.exists?(["correspondenciasrecibida_id = ? ", self.correspondenciasrecibida_id]) == true
      cr = Correspondenciasradicado.find(:first, :conditions=>["correspondenciasrecibida_id = #{self.correspondenciasrecibida_id}"])
      return cr.correspondenciasenviada.nro_radicado.to_s
    end
  end

  def fecharadsalida
    if Correspondenciasradicado.exists?(["correspondenciasrecibida_id = ? ", self.correspondenciasrecibida_id]) == true
      cr = Correspondenciasradicado.find(:first, :conditions=>["correspondenciasrecibida_id = #{self.correspondenciasrecibida_id}"])
      return cr.correspondenciasenviada.fecha_elaboracion
    end
  end

  def diasrespuesta
    if self.fecharadsalida
      objetos = Objeto.find_by_sql(["select fnc_pqrsdiasatencion(#{self.id},'#{self.fecharadsalida.to_date}') valor from dual"])
      objetos.each do |objeto|
        return objeto.valor.to_f rescue 0
      end
    else
      if self.estado.to_s == 'CERRADO'
        objetos = Objeto.find_by_sql(["select fnc_pqrsdiasatencion(#{self.id},'#{self.updated_at.to_date}') valor from dual"])
        objetos.each do |objeto|
          return objeto.valor.to_f rescue 0
        end
      else
        objetos = Objeto.find_by_sql(["select fnc_pqrsdiasatencion(#{self.id},sysdate) valor from dual"])
        objetos.each do |objeto|
          return objeto.valor.to_f rescue 0
        end
      end
    end 
  end
end

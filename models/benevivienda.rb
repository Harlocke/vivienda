class Benevivienda < ActiveRecord::Base
  belongs_to :persona
  belongs_to :documento
  belongs_to :estados_civil
  belongs_to :ocupacion
  belongs_to :user
  belongs_to :especial
  belongs_to :parentesco
  belongs_to :sisben
  belongs_to :caja

  has_many :relaciones, :dependent =>:destroy
  has_many :viviendasreportes
  has_many :correspondenciasrecibidas
  has_many :correspondenciasenviadas

  validates_presence_of :identificacion, :primer_nombre, :primer_apellido
  validates_uniqueness_of :identificacion
  validates_numericality_of :identificacion
  validates_length_of :identificacion, :in=> 6...11, :message=>"La identificación debe ser entre 6 y 11 digitos. Verifique!!"
  validates_numericality_of :ingresos, :allow_nil => true
  validate :identificacions

  def identificacions
    if Persona.exists?(["ltrim(rtrim(identificacion)) = ?", self.identificacion]) == true
      errors.add :identificacion, "Identificacion ya registrada como Jefe de Hogar"
    end
  end

  def respaldo(userid)
    antbenevivienda = Antbenevivienda.new
    antbenevivienda.persona_id = self.persona_id
    antbenevivienda.documento_id = self.documento_id
    antbenevivienda.identificacion = self.identificacion
    antbenevivienda.primer_nombre = self.primer_nombre
    antbenevivienda.segundo_nombre = self.segundo_nombre
    antbenevivienda.primer_apellido = self.primer_apellido
    antbenevivienda.segundo_apellido = self.segundo_apellido
    antbenevivienda.fecha_nacimiento = self.fecha_nacimiento
    antbenevivienda.parentesco_id = self.parentesco_id
    antbenevivienda.especial_id = self.especial_id
    antbenevivienda.cedula = self.cedula
    antbenevivienda.autobuscar = self.autobuscar
    antbenevivienda.ocupacion_id = self.ocupacion_id
    antbenevivienda.estado_civil_id = self.estado_civil_id
    antbenevivienda.ingresos = self.ingresos
    antbenevivienda.user_id = userid
    antbenevivienda.save
  end

  
  def before_save
    identi = (self.identificacion.to_i).to_s.strip
    self.identificacion = identi
    self.autobuscar = self.identificacion.to_s + ' ' + self.primer_nombre.to_s + ' ' + self.segundo_nombre.to_s + ' ' + self.primer_apellido.to_s + ' ' + self.segundo_apellido.to_s rescue nil
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

  def after_save
    ActiveRecord::Base.connection.execute("begin prc_relaciones(#{self.persona_id.to_i}); end;")
    #habilitarelaciones1(self.persona_id)
  end

  def after_create
    ActiveRecord::Base.connection.execute("begin prc_relaciones(#{self.persona_id.to_i}); end;")
    #habilitarelaciones1(self.persona_id)
  end

=begin
  def habilitarelaciones1(id_persona)
      Relacion.destroy_all("persona_id = #{id_persona}")
      persona = Persona.find(id_persona)
      u = Relacion.new
      u.persona_id = id_persona
      u.identificacion = persona.identificacion
      u.save
      ActiveRecord::Base.connection.execute("begin prc_cruceverifica(#{persona.identificacion.to_i}); end;")
      beneviviendas = Benevivienda.find_all_by_persona_id(id_persona)
      beneviviendas.each do |data|
        if data.identificacion.nil? == false
          r = Relacion.new
          r.benevivienda_id =data.id
          r.persona_id = id_persona
          r.identificacion = data.identificacion
          r.save
          ActiveRecord::Base.connection.execute("begin prc_cruceverifica(#{data.identificacion.to_i}); end;")
          #actualizacruce(data.identificacion,data.id)
        end
      end
  end
=end

#  def actualizacruce(identificacion,beneviviendaid)
#    @cruces = Cruce.find_all_by_identificacion(identificacion)
#    @cruces.each do |cruce|
#      cruce.benevivienda_id = beneviviendaid
#      cruce.save
#    end
#  end

  def generos
    case self.genero
    when true then "MASCULINO"
    when false then "FEMENINO"
    end
  end

end

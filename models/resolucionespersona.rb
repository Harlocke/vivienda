class Resolucionespersona < ActiveRecord::Base
  belongs_to :resolucion
  belongs_to :persona

  validates_presence_of :persona_autobuscar

  validate :persona_exist

  def persona_exist
    if self.persona_id
      if !Persona.exists?(["id = #{self.persona_id}"])
         errors.add :persona_autobuscar, "* El usuario no es valido"
      end
    else
      errors.add :persona_autobuscar, "* El usuario no es valido"
    end
  end  

  def self.search( page)
      paginate   :per_page => 30,
                 :page => page,
                 :order => 'created_at'
  end

  def before_create
    @resolucion = Resolucion.find(self.resolucion_id)
    #Crea las resoluciones de Subsidios
    if @resolucion.resolucionesclase_id.to_s == '10004'
    # 10004 REVOCATORIA
      logger.error("Eliminado")
#      ActiveRecord::Base.connection.execute(
#        "update subsidios set estado = '3', restringue ='X'
#         where  persona_id =  #{self.persona_id}
#         and    tipos_subsidio_id in (1,3,6)#");
#      viviendaspersonas = Viviendaspersona.find_all_by_persona_id(self.persona_id);
#      viviendaspersonas.each do |data|
#        data.vivienda.limpiavivienda(data.vivienda_id)
#        data.destroy
#      end
#      personasclasificaciones = Personasclasificacion.find_all_by_persona_id_and_clasificacion_id(self.persona_id,'10002')
#      personasclasificaciones.each do |data|
#        data.destroy
#      end
#      viviendasusadaspersonas = Viviendasusadaspersona.find_all_by_persona_id(self.persona_id);
#      viviendasusadaspersonas.each do |data|
#        data.destroy
#      end
#      creditos = Credito.find_all_by_persona_id(self.persona_id)
#      creditos.each do |data|
#        if data.restringue == "X"
#          data.respaldo(self.user_id)
#          data.destroy
#        end
#      end
    elsif @resolucion.resolucionesclase_id.to_s == '10021'
    # 10021 RENUNCIA
      ActiveRecord::Base.connection.execute(
        "update subsidios set estado = 'RENUNCIA O REVOCADO', restringue ='X'
         where  persona_id =  #{self.persona_id}
         and    tipos_subsidio_id in (1,3,6)");
      if @resolucion.anno.to_s == '2012'
        objetos = Objeto.find_by_sql("select vivienda_id, persona_id
                                      from   viviendaspersonas
                                      where  persona_id = #{self.persona_id}")
        objetos.each do |objeto|
          #ActiveRecord::Base.connection.execute("delete from viviendaspersonas where vivienda_id = #{objeto.vivienda_id}");
          ActiveRecord::Base.connection.execute("update viviendas set estado = 'D' where id = #{objeto.vivienda_id}");
          ActiveRecord::Base.connection.execute("insert into personasobservaciones (id, persona_id, user_id, observacion, created_at, updated_at)
                                                values (personasobservaciones_seq.nextval,#{self.persona_id},'10002','RESOLUCION DE ACEPTACION DE RENUNCIA',sysdate,sysdate)");
        end
      end
    elsif @resolucion.resolucionesclase_id.to_s == '10020'
    # 10020 PERDIDA DE VIGENCIA
      ActiveRecord::Base.connection.execute(
        "update subsidios set estado = 'PERDIDA DE VIGENCIA', restringue ='X'
         where  persona_id =  #{self.persona_id}
         and    tipos_subsidio_id in (1,3,6)");
    elsif (@resolucion.resolucionesclase_id.to_s == '10000' or @resolucion.resolucionesclase_id.to_s == '10023' or @resolucion.resolucionesclase_id.to_s == '10024' or @resolucion.resolucionesclase_id.to_s == '10005')
      if self.subsidio_dinero
        if self.subsidio_dinero.to_s != '0'
          existe1 = Subsidio.exists?(['persona_id = ? and tipos_subsidio_id = ?', self.persona_id, 1])
          if existe1
            subsidio = Subsidio.find_by_persona_id_and_tipos_subsidio_id(self.persona_id, 1)
            subsidio.destroy
            subsidio.respaldo(self.user_id)
          end
          ActiveRecord::Base.connection.execute("insert into subsidios (id, persona_id, fecha_asig, valor, tipos_subsidio_id, resolucion, created_at, updated_at, entidad_otorga, restringue)
             values (subsidios_seq.nextval,#{self.persona_id},trunc(sysdate),#{self.subsidio_dinero},1,#{@resolucion.nro_resolucion}, sysdate, sysdate, 5, 'X')");
        end
      end
      if self.subsidio_especie
        if self.subsidio_especie.to_s != '0'
          existe2 = Subsidio.exists?(['persona_id = ? and tipos_subsidio_id = ?', self.persona_id, 6])
          if existe2
            subsidio = Subsidio.find_by_persona_id_and_tipos_subsidio_id(self.persona_id, 6)
            subsidio.destroy
            subsidio.respaldo(self.user_id)
          end
          ActiveRecord::Base.connection.execute("insert into subsidios (id, persona_id, fecha_asig, valor, tipos_subsidio_id, resolucion, created_at, updated_at, entidad_otorga, restringue)
             values (subsidios_seq.nextval,#{self.persona_id}, trunc(sysdate), #{self.subsidio_especie}, 6, #{@resolucion.nro_resolucion}, sysdate, sysdate, 'ISVIMED', 'X')");
        end
      end
      if self.subsidio_mejoras
        if self.subsidio_mejoras.to_s != '0'
          existe3 = Subsidio.exists?(['persona_id = ? and tipos_subsidio_id = ?', self.persona_id, 3])
          if existe3
            subsidio = Subsidio.find_by_persona_id_and_tipos_subsidio_id(self.persona_id, 3)
            subsidio.destroy
            subsidio.respaldo(self.user_id)
          end
          ActiveRecord::Base.connection.execute("insert into subsidios (id, persona_id, fecha_asig, valor, tipos_subsidio_id, resolucion, created_at, updated_at, entidad_otorga, restringue)
             values (subsidios_seq.nextval,#{self.persona_id},trunc(sysdate), #{self.subsidio_mejoras}, 3, #{@resolucion.nro_resolucion}, sysdate, sysdate, 'ISVIMED', 'X')");
        end
      end
      if self.arrendamiento
        if self.arrendamiento.to_s != '0'
          ActiveRecord::Base.connection.execute("insert into subsidios (id, persona_id, fecha_asig, valor, tipos_subsidio_id, resolucion, created_at, updated_at, entidad_otorga, restringue)
             values (subsidios_seq.nextval,#{self.persona_id},trunc(sysdate), #{self.arrendamiento}, 9, #{@resolucion.nro_resolucion}, sysdate, sysdate, 'ISVIMED', 'X')");
        end
      end
    elsif (@resolucion.resolucionesclase_id.to_s == '10008')
    # 10008 Resolucion de Titulacion
      if self.titulacion
        if self.titulacion.to_s != '0'
          existe4 = Subsidio.exists?(['persona_id = ? and tipos_subsidio_id = ?', self.persona_id, 8])
          if existe4
            subsidio = Subsidio.find_by_persona_id_and_tipos_subsidio_id(self.persona_id, 8)
            subsidio.destroy
            subsidio.respaldo(self.user_id)
          end
          ActiveRecord::Base.connection.execute("insert into subsidios (id, persona_id, fecha_asig, valor, tipos_subsidio_id, resolucion, created_at, updated_at, entidad_otorga, restringue)
             values (subsidios_seq.nextval,#{self.persona_id},trunc(sysdate), #{self.titulacion}, 8, #{@resolucion.nro_resolucion}, sysdate, sysdate, 'ISVIMED', 'X')");
        end
      end
    elsif (@resolucion.resolucionesclase_id.to_s == '10007')
    # 10007 Resolucion de Creditos
      if self.credito
        if self.credito.to_s != '0'
          existe1 = Credito.exists?(['persona_id = ? and entidad_id = ?', self.persona_id, 10])
          if existe1
            credito = Credito.find_by_persona_id_and_entidad_id(self.persona_id, 10)
            credito.destroy
            credito.respaldo(self.user_id)
          end
          ActiveRecord::Base.connection.execute(
            "insert into creditos (id, persona_id, fecha_credito, valor, entidad_id, resolucion, created_at, updated_at, restringue)
             values (creditos_seq.nextval,#{self.persona_id},'#{@resolucion.fecha}',#{self.credito},10,'#{@resolucion.nro_resolucion}', sysdate, sysdate, 'X')");
        end
      end
    end
  end

  def persona_autobuscar
    persona.autobuscar if persona
  end

  def persona_autobuscar=(autobuscar)
    self.persona = Persona.find_or_create_by_autobuscar(autobuscar) unless autobuscar.blank?
  end

end

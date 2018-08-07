class Indicador < ActiveRecord::Base
  has_many :indicadoresfichas, :dependent =>:destroy
  has_many :indicadoresactualizaciones
  has_many :indicadoresvariables
  belongs_to :dependencia

  def self.search(search, page)
        paginate :per_page => 10,
                 :page => page,
                 :conditions => ['nombreindicador like ? ', "%#{search}%"],
                 :order => 'consecutivo'
  end

  def self.buscar(proceso,userresponsable_id,nombre,dependenciaid)
      cadena = ""
      if nombre != ""
        s = nombre.upcase
        if cadena != ""
          cadena = cadena + ' and upper(nombreindicador) like '+ "'%%#{replacespace(s.to_s)}%%'"
        else
          cadena = ' upper(nombreindicador) like '+ "'%%#{replacespace(s.to_s)}%%'"
        end
      end
      if userresponsable_id != ""
        if cadena != ""
          cadena = cadena + ' and useranalisis  = ' + userresponsable_id.to_s
        else
          cadena = ' useranalisis  = ' + userresponsable_id.to_s
        end
      end
      if proceso != ""
        if cadena != ""
          cadena = cadena + ' and proceso  = ' + "'#{proceso.to_s}'"
        else
          cadena = ' proceso  = ' + "'#{proceso.to_s}'"
        end
      end
      if dependenciaid != ""
        if cadena != ""
          cadena = cadena + ' and dependencia_id  = ' + dependenciaid.to_s
        else
          cadena = ' dependencia_id  = ' + dependenciaid.to_s
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "nombreindicador")
      else
        find(:all, :conditions => ['created_at = curdate()'], :order => "nombreindicador")
      end
  end

  def after_create
    if self.medicion.to_s == 'MENSUAL'
      i = 1
      while (i <= 12)
          ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                                 values (indicadoresfichas_seq.nextval,#{self.id},'#{i}','2017',sysdate,sysdate)")
          i = i + 1
      end
    elsif self.medicion.to_s == 'ANUAL'
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'12','2017',sysdate,sysdate)")
    elsif self.medicion.to_s == 'SEMESTRAL'
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'6','2017',sysdate,sysdate)")
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'12','2017',sysdate,sysdate)")
    elsif self.medicion.to_s == 'TRIMESTRAL'
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'3','2017',sysdate,sysdate)")
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'6','2017',sysdate,sysdate)")
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'9','2017',sysdate,sysdate)")
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'12','2017',sysdate,sysdate)")
    elsif self.medicion.to_s == 'BIMENSUAL'
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'2','2017',sysdate,sysdate)")
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'4','2017',sysdate,sysdate)")
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'6','2017',sysdate,sysdate)")
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'8','2017',sysdate,sysdate)")      
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'10','2017',sysdate,sysdate)")      
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'12','2017',sysdate,sysdate)")   
    elsif self.medicion.to_s == 'BIANUAL'
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'12','2017',sysdate,sysdate)")
      ActiveRecord::Base.connection.execute("insert into indicadoresfichas (id,indicador_id,mes,anno,created_at,updated_at)
                                             values (indicadoresfichas_seq.nextval,#{self.id},'12','2017',sysdate,sysdate)")
    end
  end

  def ambitoterritorial
    cadena = ""
    if self.terri_comunas_correg.to_s == "SI"
      cadena = cadena + '* Comuna - Corregimiento<br/>'
    end
    if self.terri_barrio.to_s == "SI"
      cadena = cadena + '* Barrios<br/>'
    end
    if self.terri_poligono.to_s == "SI"
      cadena = cadena + '* Polígono de tratamiento<br/>'
    end
    if self.terri_clasificacion.to_s == "SI"
      cadena = cadena + '* Clasificaciones suelo POT<br/>'
    end
    if self.terri_corregimiento.to_s == "SI"
      cadena = cadena + '* Corregimiento<br/>'
    end
    if self.terri_manzana.to_s == "SI"
      cadena = cadena + '* Manzana<br/>'
    end
    if self.terri_municipio.to_s == "SI"
      cadena = cadena + '* Municipio de Medellín<br/>'
    end
    if self.terri_vereda.to_s == "SI"
      cadena = cadena + '* Veredas'
    end
    if self.terri_area_rural.to_s == "SI"
      cadena = cadena + '* Área rural<br/>'
    end
    if self.terri_area_urbana.to_s == "SI"
      cadena = cadena + '* Área urbana<br/>'
    end
    if self.terri_comunas.to_s == "SI"
      cadena = cadena + '* Comunas<br/>'
    end
    if self.terri_intervenciones.to_s == "SI"
      cadena = cadena + '* Intervenciones<br/>'
    end
    if self.terri_medellin_valle.to_s == "SI"
      cadena = cadena + '* Medellín - Valle de Aburrá<br/>'
    end
    if self.terri_zonas.to_s == "SI"
      cadena = cadena + '* Zonas<br/>'
    end
    if self.terri_tratamientos.to_s == "SI"
      cadena = cadena + '* Tratamientos<br/>'
    end
    if self.terri_poligono_inter.to_s == "SI"
      cadena = cadena + '* Polígonos de intervención<br/>'
    end
    return cadena.to_s    
  end

  def ambitopoblacional
    cadena = ""
    if self.pobla_sexo.to_s == "SI"
      cadena = cadena + '* Sexo<br/>'
    end
    if self.pobla_primera_infancia.to_s == "SI"
      cadena = cadena + '* Primera Infancia<br/>'
    end
    if self.pobla_infancia.to_s == "SI"
      cadena = cadena + '* Infancia<br/>'
    end
    if self.pobla_adolescencia.to_s == "SI"
      cadena = cadena + '* Adolescencia<br/>'
    end
    if self.pobla_juventud.to_s == "SI"
      cadena = cadena + '* Juventud<br/>'
    end
    if self.pobla_mayores.to_s == "SI"
      cadena = cadena + '* Personas Mayores<br/>'
    end
    if self.pobla_lgbti.to_s == "SI"
      cadena = cadena + '* Población LGBTI<br/>'
    end
    if self.pobla_indigena.to_s == "SI"
      cadena = cadena + '* Población Indígena'
    end
    if self.pobla_afro.to_s == "SI"
      cadena = cadena + '* Población Afro<br/>'
    end
    if self.pobla_victima.to_s == "SI"
      cadena = cadena + '* Población Víctima<br/>'
    end
    if self.pobla_discapacidad.to_s == "SI"
      cadena = cadena + '* Población con Discapacidad<br/>'
    end
    if self.pobla_habitante.to_s == "SI"
      cadena = cadena + '* Población Habitante de calle<br/>'
    end
    if self.pobla_edad.to_s == "SI"
      cadena = cadena + '* Edad<br/>'
    end
    if self.pobla_desp.to_s == "SI"
      cadena = cadena + '* Población desplazada<br/>'
    end
    if self.pobla_otra.to_s == "SI"
      cadena = cadena + '* Otra población<br/>'
    end
    return cadena.to_s    
  end

  def sectordesc
    cadena = ""    
    if self.sector_desarrollo.to_s == "SI"
      cadena = cadena + '* a. Desarrollo Económico y Finanzas públicas<br/>'
    end
    if self.sector_demografia.to_s == "SI"
      cadena = cadena + '* b. Demografía y Dinámica Poblacionales<br/>'
    end
    if self.sector_medio_amb.to_s == "SI"
      cadena = cadena + '* c. Medio Ambiente<br/>'
    end
    if self.sector_vivienda.to_s == "SI"
      cadena = cadena + '* d. Vivienda<br/>'
    end
    if self.sector_infraestructura.to_s == "SI"
      cadena = cadena + '* e. Infraestructura Urbana no Vial<br/>'
    end
    if self.sector_servicios.to_s == "SI"
      cadena = cadena + '* f. Servicios públicos<br/>'
    end
    if self.sector_transporte.to_s == "SI"
      cadena = cadena + '* g. Transporte e Infraestructura Vial<br/>'
    end
    if self.sector_salud.to_s == "SI"
      cadena = cadena + '* h. Salud<br/>'
    end
    if self.sector_educacion.to_s == "SI"
      cadena = cadena + '* i. Educación<br/>'
    end
    if self.sector_seguridad.to_s == "SI"
      cadena = cadena + '* j. Seguridad<br/>'
    end
    if self.sector_cultura.to_s == "SI"
      cadena = cadena + '* k. Cultura Ciudadana<br/>'
    end    
    return cadena.to_s    
  end

  def estadoact
      if self.activo.to_s == 'SI'
        return "<img src='/images/verde1.png' title='Activo'/><strong> ACTIVO</strong>"
      else
        return "<img src='/images/rojo1.png' title='Inactivo'/><strong> INACTIVO</strong>"
      end
  end

  def estadoactg
      if self.activo.to_s == 'SI'
        return "<img src='/images/verde1.png' title='Activo'/>"
      else
        return "<img src='/images/rojo1.png' title='Inactivo'/>"
      end
  end  

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'background-color:#288AC6; '
    end
  end
  
  def self.replacespace(campo)
     b = campo.sub(" ","%%")
     b = b.sub(" ","%%")
     b = b.sub(" ","%%")
     b = b.sub(" ","%%")
     return b
   end
  
end

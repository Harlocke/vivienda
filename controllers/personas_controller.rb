# encoding: utf-8
class PersonasController < ApplicationController
  before_filter :require_user, :checkaccess
  require 'ruby_plsql'
  layout :determine_layout

  def checkaccess
    if is_permit('personas') == false
      flash[:warning] = "Usted no tiene acceso a este modulo"
      redirect_to menus_path
    elsif is_activo == false
      current_user_session.destroy
      redirect_to new_user_session_url
      return false
    end
  end

  def index
    @personas = Persona.buscar(params[:buscarident], params[:buscarnombre], params[:buscargrupo], params[:page])
    if @personas.count.to_i == 0
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @personas }
      end
    elsif @personas.count == 1
      redirect_to edit_persona_path(:id => @personas, :etapa=>"1")
    else
      #flash[:notice] = "Se encontraron varios resultados"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @personas }
      end
    end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_InformeActividades_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @personasobservaciones = Personasobservacion.search(params[:ubicacion][:usuario],
                                                        params[:ubicacion][:fchinicial],
                                                        params[:ubicacion][:fchfinal])
    respond_to do |format|
       format.xls
    end
  end

  def informepersona
    @persona    = Persona.find(params[:id])
  end

  def visualizar
    @persona    = Persona.find(params[:id])
  end

  def feriavipa
    @persona    = Persona.find(params[:id])
    if @persona.updated_at.strftime("%Y-%m-%d") < '2014-05-19'
      if @persona.habilitado.to_s == "SI"
        if @persona.consecutivo_vipa.to_i == 0
          @persona.consecutivo_vipa = Persona.maximum("consecutivo_vipa").to_i+ 1
          @persona.save
        end
      else
        flash[:notice] = "* Este formulario no puede ser modificado... Ya la información fue consolidada y Respaldada"
        redirect_to :controller=>"personas", :action=>"edit", :id=>params[:id]
      end
    else
      if @persona.consecutivo_vipa.to_i == 0
        @persona.consecutivo_vipa = Persona.maximum("consecutivo_vipa").to_i+ 1
        @persona.save
      end
    end
  end

  def personaslistas
    personaid = params[:id]
    ActiveRecord::Base.connection.execute(
       "insert into personaslistas (id,persona_id,listasverificacion_id,created_at,updated_at,bloqueo)
        select personaslistas_seq.nextval,#{personaid},id,sysdate,sysdate,'NO'
        from   listasverificaciones where id <= 18
        and    id not in (select listasverificacion_id
                          from   personaslistas where persona_id = #{personaid})")
    flash[:notice] = "Lista de chequeo realizada con exito"
    redirect_to edit_persona_path(personaid)
  end
  
  def personaslistascerrar
    personaid = params[:id]
    ActiveRecord::Base.connection.execute("update personaslistas set bloqueo = 'SI' where persona_id = #{personaid}")
    begin
      #@correos = @correos.to_s + Sifi.find(23).valor.to_s
      @correos = "ymejia.mejoramiento@yahoo.com.co, amejia.mejoramiento@yahoo.com.co, gisela.londono@isvimed.gov.co, carlosmejiapineda@hotmail.com"
      @personaslistas = Personaslista.find_all_by_persona_id(personaid)
      @persona = Persona.find(personaid)
      Notifier.deliver_personaslista_message(@correos, @personaslistas,@persona)
      logger.error("SIFI personaslistas - Correo enviado a #{@correos}")
      rescue Exception => exc
         logger.error("SIFI personaslistas - Correo No enviado a #{@correos}")
    end
    flash[:notice] = "Diagnostico cerrado e informacion enviada por correo a #{@correos}"
    redirect_to edit_persona_path(personaid)
  end

  def busqueda
    @personas = Persona.buscar(params[:buscarident], params[:buscarnombre], params[:buscargrupo], params[:page])
    if @personas.count.to_i == 0
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @personas }
      end
    elsif @personas.count == 1
      redirect_to edit_persona_path(:id => @personas, :etapa=>"1")
    else
      #flash[:notice] = "Se encontraron varios resultados"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @personas }
      end
    end
  end

  def buscarferia
    @personas      = Persona.buscarferia(params[:buscarident])
    if @personas.count == 1
      @alert = ""
      @personas.each do |persona|
        if persona.habilitado.to_s == "SI"
          @alert = ""
        else
          if Resolucionespersona.exists?(["persona_id = #{persona.id}"])
            @alert = @alert + "* El Usuario tiene resolución<br/>"
          end
          if Iguanaspersona.exists?(["persona_id = #{persona.id}"])
            @alert = @alert + "* El Usuario esta en proceso de Reasentamiento<br/>"
          end
          if Iguanasrentista.exists?(["persona_id = #{persona.id}"])
            @alert = @alert + "* El Usuario esta en proceso de Reasentamiento como rentista<br/>"
          end
          if Titulacionespersona.exists?(["persona_id = #{persona.id}"])
            @alert = @alert + "* El Usuario esta en proceso de Titulación<br/>"
          end
          if Mejoramiento.exists?(["persona_id = #{persona.id}"])
            @alert = @alert + "* El Usuario esta en proceso de Mejoramiento de Vivienda<br/>"
          end
          if Benevivienda.exists?(["ltrim(rtrim(identificacion)) = '#{persona.identificacion}'"])
            @alert = @alert + "* El Usuario esta registrado como beneficiario de otro grupo familiar<br/>"
          end
          if Viviendaspersona.exists?(["persona_id = #{persona.id}"])
            @alert = @alert + "* El Usuario ya tiene Vivienda Nueva Asignada<br/>"
          end
          if Viviendasusadaspersona.exists?(["persona_id = #{persona.id}"])
            @alert = @alert + "* El Usuario ya tiene Vivienda Usada Asignada<br/>"
          end
          if persona.feriavipa.to_s == "SI" and persona.consecutivo_vipa.to_i > 0
            @alert = @alert + "* El Usuario ya se encuentra inscrito en la Feria VIPA (Nro Formulario: #{is_consecutivocero(persona.consecutivo_vipa) rescue nil} )<br/>"
          end
        end
      end
      if @alert.to_s != ""
        @error = @alert.to_s
      else
        redirect_to edit_persona_path(@personas)
      end
    elsif @personas.count == 0
      redirect_to :controller=>"personas", :action=>"new", :identificacion=>params[:buscarident].to_s, :feriavipa => 'SI'
    end
  rescue
    flash[:notice] = "Debe digitar datos para la consulta"
    redirect_to personas_path
  end


  def listar
      @personas = Persona.find(:all, :conditions => [' identificacion =  ?', "#{params[:search]}"])
      #@personas = Persona.find(:all, :conditions => [' autobuscar LIKE ?', "%#{params[:search]}%"])
  end

  def show
    @persona    = Persona.find(params[:id])
    @moravias    = Moravia.find_by_persona_id(@persona.id)
    @viviendas   = Vivienda.find_by_persona_id(@persona.id)
    @viviendaspersonas = Viviendaspersona.find_by_persona_id(@persona.id)
    @requerimientos   = Requerimiento.find_by_persona_id(@persona.id)
    @subsidios   = Subsidios.find_by_persona_id(@persona.id)
    @creditos   = Creditos.find_by_persona_id(@persona.id)
    @beneviviendas = Benevivienda.find_all_by_persona_id(@persona.id)
    @viviendasrenuncias = Viviendasrenuncias.find_all_by_persona_id(@persona.id)
    @resolucionespersonas = Resolucionespersona.find_by_persona_id(@persona.id)
    @iguanaspersonas = Iguanaspersona.find_by_persona_id(@persona.id)
    @iguanasrentistas = Iguanasrentista.find_by_persona_id(@persona.id)
    @feria2009jefes = Feria2009jefes.find_by_persona_id(@persona.id)
    @feria2010jefes = Feria2010jefes.find_by_persona_id(@persona.id)
    @feria2014imagenes = Feria2010imagenes.find_by_persona_id(@persona.id)
    @feriadocentejefes = Feriadocentejefes.find_by_persona_id(@persona.id)
    @viviendausadaspersonas = Viviendasusadaspersonas.find_by_persona_id(@persona.id)
    @personasobservaciones = Personasobservaciones.find_by_persona_id(@persona.id)
    @antsubsidios   = Antsubsidios.find_by_persona_id(@persona.id)
    @antbeneviviendas = Antbenevivienda.find_all_by_persona_id(@persona.id)
    @antcreditos = Antcredito.find_all_by_persona_id(@persona.id)
    @desplazados = Desplazado.find_all_by_persona_id(@persona.id)
    @personasclasificaciones = Personasclasificacion.find_all_by_persona_id(@persona.id)
    @archivospersonas = Archivospersona.find_all_by_persona_id(@persona.id)
    @obraspublicas = Obraspublica.find_all_by_persona_id(@persona.id)
    @ayudas = Ayuda.find_all_by_persona_id(@persona.id)
    @personastramites = Personastramite.find_all_by_persona_id(@persona.id)
    @titulacionespersonas = Titulacionespersona.find_by_persona_id(@persona.id)
    @personassesiones   = Personassesion.find_all_by_persona_id(@persona.id)
    @procesospersonas   = Procesospersona.find_all_by_persona_id(@persona.id)
    @personasretornos   = Personasretorno.find_all_by_persona_id(@persona.id)
    @personascensos   = Personascenso.find_all_by_persona_id(@persona.id)
    @quejas = Queja.find_all_by_persona_id(@persona.id)
    @cruces = Cruce.find_all_by_persona_id(@persona.id)
    @mejoramientos = Mejoramiento.find_all_by_persona_id(@persona.id)
    @personasbases = Personasbase.find_all_by_persona_id(@persona.id)
    @feria2014jefes = Feria2014jefe.find_by_persona_id(@persona.id)
    @fase2censos = Fase2censo.find_by_persona_id(@persona.id)
    @fase2beneficiarios = Fase2beneficiario.find_by_persona_id(@persona.id)
    #@personasarrendamientos = Personasarrendamiento.find_by_persona_id(@persona.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @persona }
    end
  end

  def new
    #@personas = Persona.all
    @documentos = Documento.all
    @cajas = Caja.all
    @especiales = Especial.all
    @familiares = Familiar.all
    @ocupaciones = Ocupacion.all
    @parentescos = Parentesco.all
    @sisbenes = Sisben.all
    @estados_civiles = EstadosCivil.all
    @persona = Persona.new
    @persona.etapa = '1'
    render :action => "persona_form"
  end

  def new2
    #@personas = Persona.all
    @documentos = Documento.all
    @cajas = Caja.all
    @especiales = Especial.all
    @familiares = Familiar.all
    @ocupaciones = Ocupacion.all
    @parentescos = Parentesco.all
    @sisbenes = Sisben.all
    @estados_civiles = EstadosCivil.all
    @persona = Persona.new
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update personas set etapa = '#{params[:etapa]}' where id = #{params[:id].to_i}")
    end  
    #if permisoferia.to_s == "S"
    #  ActiveRecord::Base.connection.execute("update personas set habilitado_feria = 'RESOLUCION 2010' where id = #{params[:id].to_i}")
    #else
    #  ActiveRecord::Base.connection.execute("update personas set habilitado_feria = null where id = #{params[:id].to_i}")
    #end    
    @persona = Persona.find(params[:id])
    if @persona.etapa.to_s == "1"
      @personasclasificacion = Personasclasificacion.new
    elsif @persona.etapa.to_s == "3"
      @personasobservacion = Personasobservacion.new
    elsif @persona.etapa.to_s == "11"
      @benevivienda = Benevivienda.new
    elsif @persona.etapa.to_s == "12"
      @viviendaspersona = Viviendaspersona.new
      @viviendasusadaspersona = Viviendasusadaspersona.new
    elsif @persona.etapa.to_s == "13"
      @subsidio = Subsidio.new
    elsif @persona.etapa.to_s == "14"
      @credito  = Credito.new
    elsif @persona.etapa.to_s == "15"
      @viviendasrenuncia = Viviendasrenuncia.new
    elsif @persona.etapa.to_s == "25"
      @personastramite = Personastramite.new
    elsif @persona.etapa.to_s == "27"
      @personassesion   = Personassesion.new
    elsif @persona.etapa.to_s == "32"
      @personasretorno   = Personasretorno.new
    elsif @persona.etapa.to_s == "34"
      @personascenso = Personascenso.new
    elsif @persona.etapa.to_s == "37"
      @personaslista = Personaslista.new
    end
    @existeresolucionespersona = @persona.resolucionespersonas.exists?
    @existeiguanaspersona = @persona.iguanaspersonas.exists?
    @existeiguanasrentista = @persona.iguanasrentistas.exists?
    @existeferia2009jefe = @persona.feria2009jefes.exists?
    @existeferia2010jefe = @persona.feria2010jefes.exists?
    @existeferia2014jefe = @persona.feria2014jefes.exists?
    @existeferiadocentejefe = @persona.feriadocentejefes.exists?
    @existedesplazado = @persona.desplazados.exists?
    @existearchivo = @persona.archivospersonas.exists?
    @existeobrapublica = @persona.obraspublicas.exists?
    @existetitulacion = @persona.titulacionespersonas.exists?
    @existearrendamiento = @persona.ayudas.exists?
    @existerecibida = @persona.correspondenciasrecibidas.exists?
    @existeenviada = @persona.correspondenciasenviadas.exists?
    @existeprocesospersona = @persona.procesospersonas.exists?
    @existeretorno = @persona.personasretornos.exists?
    @existequeja = @persona.quejas.exists?
    @existecenso = @persona.personascensos.exists?
    @existecruce = Cruce.exists?(["persona_id = ?", @persona.id])
    @existecruceimagen = Crucesimagen.exists?(["persona_id = ?", @persona.id])
    @existemejoramiento = @persona.mejoramientos.exists?
    @existebase = @persona.personasbases.exists?
    @existefase2censo = @persona.fase2censos.exists?
    @existefase2beneficiario = @persona.fase2beneficiarios.exists?
    #@existearr = @persona.personasarrendamientos.exists?
    respond_to do |format|
      format.html { render :action => "persona_form" }
    end
  end

  def edit2
    @persona = Persona.find(params[:id])
    @documentos      = Documento.all
    @cajas           = Caja.all
    @especiales      = Especial.all
    @familiares      = Familiar.all
    @ocupaciones     = Ocupacion.all
    @parentescos     = Parentesco.all
    @sisbenes        = Sisben.all
    @estados_civiles = EstadosCivil.all
    @benevivienda = Benevivienda.new
    @personasencuesta = Personasencuesta.new
    respond_to do |format|
      format.html { render :action => "edit2" }
    end
  end

  def create
    @persona = Persona.new(params[:persona])
    @persona.identificacion = (params[:persona][:identificacion].to_i).to_s.strip
    @persona.etapa = '1'
##    if permisoferia.to_s == "S"
#      #@persona.feriavipa.to_s == 'SI'
#      @persona.habilitado_feria.to_s == 'SI'
#    end
    @persona.user_id = is_admin
    if params[:persona][:fecha_nacimiento].to_d <= '1970-01-01'.to_d
      fecha = params[:persona][:fecha_nacimiento]
    end
    if @persona.save
      if fecha
        ActiveRecord::Base.connection.execute("update personas set fecha_nacimiento = '#{fecha}' where id = #{@persona.id}")
      end
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_persona_path(@persona)
    else
      @documentos      = Documento.all
      @cajas           = Caja.all
      @especiales      = Especial.all
      @familiares      = Familiar.all
      @ocupaciones     = Ocupacion.all
      @parentescos     = Parentesco.all
      @sisbenes        = Sisben.all
      @estados_civiles = EstadosCivil.all
      flash[:warning] = "Error."
      render :action => "persona_form"
    end
  end

  def create2
    @persona = Persona.new(params[:persona])
    @persona.identificacion = (params[:persona][:identificacion].to_i).to_s.strip
    @persona.user_id = is_admin
    @persona.etapa = '1'
    if params[:persona][:fecha_nacimiento].to_d <= '1970-01-01'.to_d
      fecha = params[:persona][:fecha_nacimiento]
    end
    if @persona.save
      if fecha
        ActiveRecord::Base.connection.execute("update personas set fecha_nacimiento = '#{fecha}' where id = #{@persona.id}")
      end
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit2_persona_path(@persona)
    else
      @documentos      = Documento.all
      @cajas           = Caja.all
      @especiales      = Especial.all
      @familiares      = Familiar.all
      @ocupaciones     = Ocupacion.all
      @parentescos     = Parentesco.all
      @sisbenes        = Sisben.all
      @estados_civiles = EstadosCivil.all
      render :action => "new2"
      #redirect_to new2_personas_path(@persona)
     end
  end

  def newrapidocreate
    if params[:identificacion].to_s != "" and params[:primer_nombre].to_s != "" and params[:primer_apellido].to_s != ""
      if Persona.exists?(["ltrim(rtrim(identificacion)) = '#{params[:identificacion]}'"]) == true
        flash[:notice] = "La identificacion registrada ya esta Creada. Verifique"
        render :action => "newrapido"
      else
        if Benevivienda.exists?(["ltrim(rtrim(identificacion)) = '#{params[:identificacion]}'"]) == true
          flash[:notice] = "Identificacion ya registrada como beneficiarios"
          render :action => "newrapido"
        else
          nom =  ""
          if params[:identificacion].nil? == false
            nom = params[:identificacion].to_s
          end
          if params[:primer_nombre].nil? == false
            nom = nom + ' ' + params[:primer_nombre].to_s
          end
          if self.params[:segundo_nombre].nil? == false
            nom = nom + ' ' + params[:segundo_nombre].to_s
          end
          if params[:primer_apellido].nil? == false
            nom = nom + ' ' + params[:primer_apellido].to_s
          end
          if params[:segundo_apellido].nil? == false
            nom = nom + ' ' + params[:segundo_apellido].to_s
          end
          ActiveRecord::Base.connection.execute(
          "insert into personas (id, documento_id, identificacion, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, autobuscar, user_id, created_at, updated_at)
           values (personas_seq.nextval,#{params[:ubicacion][:documento_id]},'#{params[:identificacion]}','#{params[:primer_nombre]}','#{params[:segundo_nombre]}','#{params[:primer_apellido]}','#{params[:segundo_apellido]}','#{nom}',#{is_admin},sysdate,sysdate)")
          flash[:notice] = "Usuario Creado con Exito."
          id_persona = Persona.find_by_identificacion(params[:identificacion]).id
          ActiveRecord::Base.connection.execute("begin prc_relaciones(#{id_persona}); end;")
        end
      end
    else
      flash[:notice] = "Debe registrar los campos Obligatorios marcados con (*)"
      render :action => "newrapido"
      #redirect_to new2_personas_path(@persona)
    end
  end

  def update
    @persona = Persona.find(params[:id])
    #@persona.user_id = is_admin    
    @persona.user_actualiza = is_admin    
    if params[:persona][:fecha_nacimiento].to_d <= '1970-01-01'.to_d
      fecha = params[:persona][:fecha_nacimiento]
    end
    if permisoferia.to_s == "S"
      params[:persona][:feriavipa].to_s == 'SI'
    end
    if @persona.update_attributes(params[:persona])
      if fecha
        ActiveRecord::Base.connection.execute("update personas set fecha_nacimiento = '#{fecha}' where id = #{@persona.id}")
      end
      flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_persona_path(@persona)
    else

      @documentos      = Documento.all
      @cajas           = Caja.all
      @especiales      = Especial.all
      @familiares      = Familiar.all
      @ocupaciones     = Ocupacion.all
      @parentescos     = Parentesco.all
      @sisbenes        = Sisben.all
      @estados_civiles = EstadosCivil.all  
      render :action => "persona_form"
    end
    #rescue
     # flash[:notice] = "Problemas !!! Contacte al administrador."
      #redirect_to edit_persona_path(@persona)
  end

  def update2
    @persona = Persona.find(params[:id])
    @persona.user_id = is_admin
    if params[:persona][:fecha_nacimiento].to_d <= '1970-01-01'.to_d
      fecha = params[:persona][:fecha_nacimiento]
    end
    if @persona.update_attributes(params[:persona])
      if fecha
        ActiveRecord::Base.connection.execute("update personas set fecha_nacimiento = '#{fecha}' where id = #{@persona.id}")
      end
      flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit2_persona_path(@persona)
    else
      @documentos      = Documento.all
      @cajas           = Caja.all
      @especiales      = Especial.all
      @familiares      = Familiar.all
      @ocupaciones     = Ocupacion.all
      @parentescos     = Parentesco.all
      @sisbenes        = Sisben.all
      @estados_civiles = EstadosCivil.all
      render :action => "edit2"
      #redirect_to edit2_persona_path(@persona)
    end
    rescue
      redirect_to edit2_persona_path(@persona)
  end

  def destroy
    @persona = Persona.find(params[:id])
    @persona.destroy
    respond_to do |format|
      format.html { redirect_to(personas_url) }
      format.xml  { head :ok }
    end
  end

  def unificar2
    if params[:buscarident].to_s != "" and params[:buscarnombre].to_s != ""
      ActiveRecord::Base.connection.execute("begin prc_persona(#{params[:buscarident].to_s},#{params[:buscarnombre].to_s}); end;")
      @objetos = Objeto.find_by_sql(["select * from error"])
    end
  end

  def solicitarcruce
    if params[:clase].to_s == 'CRUCE'
      consecutivo = is_nextcruce
      ActiveRecord::Base.connection.execute("begin prc_solicitudescruces(#{consecutivo},#{is_admin},#{params[:id].to_i},'CRUCE'); end;")
      flash[:notice] = "Cruce solicitado correctamente. Consecutivo #{consecutivo}"
      redirect_to edit_persona_path(params[:id])
    elsif params[:clase].to_s == 'ZR'  
      @persona = Persona.find(params[:id])
      if @persona.matricula_inmobiliaria.to_s != "" and @persona.direccion.to_s != ""
        consecutivo = is_nextcruce
        ActiveRecord::Base.connection.execute("begin prc_solicitudescruces(#{consecutivo},#{is_admin},#{params[:id].to_i},'ZR'); end;")
        flash[:notice] = "ZR solicitado correctamente. Consecutivo #{consecutivo}"
        redirect_to edit_persona_path(params[:id])
      else
        flash[:warning] = "ZR No solicitado, debe tener la direccion y la matricula inmobiliaria para poderlo solicitar. Verifique!!"
        redirect_to edit_persona_path(params[:id])
      end
    elsif params[:clase].to_s == 'ZRI'  
      @inmobiliario = Inmobiliario.find(params[:id])
      if @inmobiliario.matricula_inmobiliaria.to_s != "" and @inmobiliario.direccion.to_s != "" and @inmobiliario.identificacion.to_s != "" and @inmobiliario.nombre.to_s != ""
        consecutivo = is_nextcruce
        ActiveRecord::Base.connection.execute("begin prc_solicitudescruces(#{consecutivo},#{is_admin},#{params[:id].to_i},'ZRI'); end;")
        flash[:notice] = "ZR solicitado correctamente. Consecutivo #{consecutivo}"
        redirect_to edit_inmobiliario_path(params[:id])
      else
        flash[:warning] = "ZR No solicitado, debe tener la direccion, la matricula inmobiliaria y los datos del vendedor para poderlo solicitar. Verifique!!"
        redirect_to edit_inmobiliario_path(params[:id])
      end
    end
  end

  private
  def determine_layout
    if ['new2','create2','show','edit2','update2','informepersona','verinfo','newrapido','newrapidocreate'].include?(action_name)
      "new2"
    elsif ['informepersona'].include?(action_name)
      "tirilla"
    elsif ['visualizar','feriavipa'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

class ArchivosController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  require 'ruby_plsql'
  require 'csv'
  require 'find'

  def uploadfile_hacienda
    rutaupload = Sifi.find(24).valor.to_s
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        nombre2 = File.basename(f).to_s
        namefile = File.basename(f).to_s
        nombre2 = nombre2.gsub(".pdf","")
        nombre2 = nombre2.gsub(".PDF","")
        if Archivospersona.exists?(["persona_id = (select id from personas where identificacion = '#{nombre2.to_s}')"]) == true
          archivo = Archivo.find(:first, :conditions=>["archivosserie_id = 10004 and id in (select archivo_id from archivospersonas where persona_id = (select id from personas where identificacion = '#{nombre2.to_s}'))"])
          if archivo
            archivosimagen = Archivosimagen.new
            archivosimagen.archivo_id  = archivo.id
            archivosimagen.descripcion = namefile.to_s
            archivosimagen.archivo = file
            archivosimagen.archivosdocumento_id = 400
            archivosimagen.save
            archivosimagen.user_id = is_admin
            file.close
            File.delete(path)
          end
        else
          logger.error("Error .." + nombre2.to_s)
        end
          # si la ruta es un directorio -> D
      end
    end
    flash[:notice] = "Archivos cargados y Carpetas Depuradas con Exito...."
    redirect_to archivos_path
  end

  def uploadfile
    rutaupload = Sifi.find(24).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.directory?(f) then "D"
        identificacion = File.basename(f).to_s
        ActiveRecord::Base.connection.execute("insert into error values ('Procesando Archivo : #{identificacion.to_s}')")
        #logger.error("Ingresando a la carpeta - " + identificacion.to_s)
        if Archivospersona.exists?(["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"]) == true
          #logger.error("Identificacion OK")
          @archivospersona = Archivospersona.find(:first, :conditions=>["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"]) rescue nil
          rutanew = rutaupload+identificacion.to_s
          Find.find(rutanew) do |fi|
            type = case
            when File.file?(fi) then "F"
              file   = File.open(fi, 'rb')
              path   = File.join(rutanew, File.basename(fi).to_s)
              nombre2 = File.basename(fi).to_s.upcase
              nombre2 = nombre2.gsub("_001","")
              nombre2 = nombre2.gsub("_002","")
              nombre2 = nombre2.gsub("_003","")
              nombre2 = nombre2.gsub("_004","")
              nombre2 = nombre2.gsub("_005","")
              nombre2 = nombre2.gsub("_006","")
              nombre2 = nombre2.gsub("_007","")
              nombre2 = nombre2.gsub("_008","")
              nombre2 = nombre2.gsub("_009","")
              nombre2 = nombre2.gsub("_010","")
              nombre2 = nombre2.gsub(".pdf","")
              nombre2 = nombre2.gsub(".PDF","")
              nombre2 = nombre2.gsub("  "," ")
              if Archivosseriesdoc.exists?(["archivosserie_id = #{@archivospersona.archivo.archivosserie_id}
                                             and archivosdocumento_id IN (select id from archivosdocumentos where ltrim(rtrim(descripcion)) = upper(ltrim(rtrim('#{nombre2.to_s}'))))"]) == true
                #logger.error("Subserie Existe.. " + nombre2.to_s)
                @archivosseriesdoc = Archivosseriesdoc.find(:first, :conditions=>["archivosserie_id = #{@archivospersona.archivo.archivosserie_id}
                                                             and archivosdocumento_id IN (select id from archivosdocumentos where ltrim(rtrim(descripcion)) = upper(ltrim(rtrim('#{nombre2.to_s}'))))"])
                if @archivosseriesdoc
                  @archivosimagen = Archivosimagen.new
                  @archivosimagen.archivo_id  = @archivospersona.archivo_id
                  @archivosimagen.descripcion = nombre2.to_s
                  @archivosimagen.archivo = file
                  @archivosimagen.archivosdocumento_id = @archivosseriesdoc.archivosdocumento_id
                  @archivosimagen.fecha_doc = Time.now
                  @archivosimagen.save
                  @archivosimagen.user_id = is_admin
                  file.close
                  File.delete(path)
                end
              else
                logger.error("Error .." + identificacion.to_s + " - Subserie NO Existe.. " + nombre2.to_s)
              end
            # si la ruta es un directorio -> D
            end
          end
        else
          logger.error("Identificacion NO EXISTE " + identificacion.to_s)
        end
      end
    end
    flash[:notice] = "Los archivos han sido cargados...."
    ActiveRecord::Base.connection.execute("insert into error values ('Proceso Finalizado Inicia Limpieza')")
    logger.error("+++++++ Proceso Finalizado Inicia Limpieza")
    redirect_to uploadclean_archivos_path
  end

  def uploadclean
    cant = 0
    rutaupload = Sifi.find(24).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      path2 = ""
      type = case
      when File.directory?(f) then "D"
        existe = 'N'
        identificacion = File.basename(f).to_s
        ActiveRecord::Base.connection.execute("insert into error values ('Procesando Archivo : #{identificacion.to_s}')")
        logger.error("Ingresando a la carpeta - " + identificacion.to_s)
        if Archivospersona.exists?(["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"]) == true
          #logger.error("Identificacion OK")
          @archivospersona = Archivospersona.find(:first, :conditions=>["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"]) rescue nil
          rutanew = rutaupload+identificacion.to_s
          Find.find(rutanew) do |fi|
            path2   = File.join(rutaupload, File.basename(fi).to_s)
            type = case
            when File.file?(fi) then "F"
              existe = 'S'
            end
            #logger.error("Existe ... "+existe.to_s)
            #logger.error("Existefi ... "+fi.to_s)
            if File.basename(fi).to_s == "Thumbs.db"
              begin
                borrado = File.delete(fi)
              rescue nil
                File.close
                begin
                  borrado = File.delete(fi)
                rescue
                  logger.error("Borrado NOooo Se recomienda Reiniciar Puerto...")
                end
              end
              logger.error("Borrado Thumbs ... "+borrado.to_s)
              if borrado.to_s == "1"
                cant = cant + 1
              end
            end
          end
        end
      end
      begin
        if existe == 'N' and
          FileUtils.rm_rf(path2)
          ActiveRecord::Base.connection.execute("insert into error values ('Carpeta borrada : #{path2.to_s}')")
        end
      rescue nil
      end
    end
    if cant.to_i > 0
      logger.error("Se detecto Thumbs.. Se inicia nuevamente el proceso....")
      redirect_to uploadclean_archivos_path
    else
      logger.error("NO Se detecto Thumbs...... Fin del Proceso....")
      flash[:notice] = "Archivos cargados y Carpetas Depuradas con Exito...."
      redirect_to archivos_path
    end
  end

  def archivoscarpeta
    #Find.find('c:/tmp/71217690/') do |f|
    Find.find('d:/tmp/71217690/') do |f|
      type = case
      when File.file?(f) then "F"
        file      = File.open(f, 'rb')
        path = File.join(directory, File.basename(f).to_s)
        logger.error("SIFI- path  #{path}")
        #logger.error("SIFI #{File.expand_path(f, "/tmp/archivo")}: #{File.dirname(f).to_s} - Name: #{File.basename(f).to_s}")
        #File.chmod(0777, File.expand_path(f, "/tmp/archivo")) # Full permissions
        #File.delete(File.expand_path(f, "/tmp/archivo"))
#        @mejoramientosimagen = Mejoramientosimagen.new
#        @mejoramientosimagen.mejoramiento_id = 10028
#        @mejoramientosimagen.descripcion = 'bleblebleble'
#        @mejoramientosimagen.cuando = "OTROS"
#        @mejoramientosimagen.mejoramiento = file
#        @mejoramientosimagen.save
        #rename = File.rename(File.dirname(f).to_s+"/".to_s+File.basename(f).to_s, File.dirname(f).to_s+"/ok.".to_s+File.basename(f).to_s)
        logger.error("SIFI #{f}")
        borrado = File.delete(path)
        logger.error("Finalizo . #{borrado rescue nil}")
      # si la ruta es un directorio -> D
      when File.directory?(f) then "D"
      # si no sabemos lo que es -> ?
      else "?"
      end
    end
    redirect_to menus_path
  end

  def csv_import
     @parsed_file=CSV::Reader.parse(params[:dump][:file], ';')
     ActiveRecord::Base.connection.execute("truncate table temporales")
     n=0
     @parsed_file.each  do |row|
       c = Temporal.new
       c.identificacion   = row[0]
       c.save
       n=n+1
     end
     ActiveRecord::Base.connection.execute("begin prc_archivosimport; end;")
      @archivos = Archivo.find(:all, :conditions=>["id in (select distinct archivo_id from temporales)"], :order=> ["archivosserie_id, barrio, to_number(caja), to_number(carpeta) ASC"])
      #ActiveRecord::Base.connection.execute("update temporales set persona_id = (select id from personas where ltrim(rtrim(identificacion)) = ltrim(rtrim(temporales.identificacion)))")
      @temporales = Temporal.all
      flash.now[:notice]="Archivo importado con Exito,  #{n} registros cargados Temporalmente"
  end

  def index
    #@archivos = Archivo.all
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @archivos }
    #end
  end

  def pendientesentrega
    @users = User.find(:all, :conditions=>[" id in (select distinct userprestamo from archivosprestamos where fecha_devolucion is null and trunc(fecha_vence) <= trunc(sysdate))"], :order =>"nombre")
    #@archivosprestamos = Archivosprestamo.find(:all, :conditions =>["fecha_devolucion is null and trunc(fecha_vence) <= trunc(sysdate)"], :order => ["userprestamo, fecha_vence ASC"])
  end

  def pendientesentregauser
    if params[:ubicacion][:user]
      @archivosprestamos = Archivosprestamo.find(:all, :conditions =>["fecha_devolucion is null and trunc(fecha_vence) <= trunc(sysdate) and userprestamo = #{params[:ubicacion][:user]}"], :order => ["userprestamo, fecha_vence ASC"])
      #@archivos = Archivo.find(:all, :conditions =>["id in (select archivo_id from archivosprestamos where fecha_devolucion is null and trunc(fecha_vence) <= trunc(sysdate))"])
      if @archivosprestamos.count == 0
        flash[:notice] = "No hay resultados de la busqueda"
        redirect_to archivos_path
      end
    else
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to archivos_path
    end
  end

  def vigentesentrega
    @archivosprestamos = Archivosprestamo.find(:all, :conditions =>["fecha_devolucion is null and trunc(fecha_vence) > trunc(sysdate)"], :order => ["userprestamo, fecha_vence ASC"])
    #@archivos = Archivo.find(:all, :conditions =>["id in (select archivo_id from archivosprestamos where fecha_devolucion is null and trunc(fecha_vence) <= trunc(sysdate))"])
  end

  def notificapendiente
    @users = User.find(:all, :conditions => ["id in (select distinct userprestamo from archivosprestamos where fecha_devolucion is null and trunc(fecha_vence) <= trunc(sysdate))"])
    @users.each do |user|
      @archivosprestamos = Archivosprestamo.find(:all, :conditions =>["userprestamo = #{user.id} and fecha_devolucion is null and trunc(fecha_vence) <= trunc(sysdate)"])
      Notifier.deliver_archivo_message(user, @archivosprestamos)
    end
  end

  def buscar
    @imprimible = params[:ubicacion][:imprimible]
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end
    @archivos = Archivo.search(params[:identificacion],
                               params[:caja],
                               params[:carpeta],
                               params[:barrio],
                               params[:ubicacion][:archivosserie_id],
                               params[:ubicacion][:usercrea],
                               params[:ubicacion][:creainicial],
                               params[:ubicacion][:creafinal],
                               params[:manzana],
                               params[:lote],
                               params[:identificacionc],
                               params[:convenio],
                               params[:nombrec],
                               params[:resolucion],
                               params[:consecutivo],
                               params[:ubicacion][:imagenes],params[:page],perpage,params[:cobama])
    if @imprimible.to_s == "SI"
      ActiveRecord::Base.connection.execute("delete from temporales where archivo_id is not null")
      @archivos.each do |archivo|
        @temporal = Temporal.new
        @temporal.archivo_id = archivo.id
        @temporal.save
      end
    end
    if @archivos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to archivos_path
    elsif params[:format] != 'xls'
      if @archivos.count == 1
        redirect_to edit_archivo_path(:id=>@archivos, :etapa=>"1")
      else
        respond_to do |format|
           format.html
        end
      end
    elsif params[:format] == 'xls'
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Archivo_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def pazysalvos
    @prestamo = params[:ubicacion][:userprestamo]
    @archivosprestamos = Archivosprestamo.searchpazysalvo(params[:ubicacion][:userprestamo], params[:page])
    respond_to do |format|
      format.html
    end
  end

  def confirmar
    archivospazysalvo = Archivospazysalvo.new
    archivospazysalvo.certificado = 'SI'
    archivospazysalvo.userpazysalvo = params[:userpazysalvo]
    archivospazysalvo.userautoriza = is_admin
    archivospazysalvo.save
    redirect_to archivos_path 
  end

  def prestamos
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end
    @userprestamo = params[:ubicacion][:userprestamo]
    @userregistro = params[:ubicacion][:user_id]
    @archivosprestamos = Archivosprestamo.searchprestamo(
                             @userregistro,
                             @userprestamo,
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal],
                             params[:ubicacion][:devolfchinicial],
                             params[:ubicacion][:devolfchfinal],
                             params[:ubicacion][:userdevol],
                             params[:page],perpage
                             )
    if @archivosprestamos.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to archivos_path
    else
      if params[:format] == 'xls'
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_Prestamos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"
        respond_to do |format|
           format.xls
        end
      else
        respond_to do |format|
          format.html
        end
      end
    end
  end

  def actualizacion
    @archivosactualizaciones = Archivosactualizacion.search(
                             params[:ubicacion][:user_id],
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal]
                             )
    if @archivosactualizaciones.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to archivos_path
    else
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Actualizaciones_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def asignar
    if params[:ubicacion][:userprestamo].to_s != ""
      @temporales = Temporal.find(:all, :conditions=>"persona_id is not null and archivo_id is not null")
      @temporales.each do |temporal|
        archivo = Archivo.find(temporal.archivo_id)
        if archivo.tipo.to_s == "A"
          if Archivosprestamo.exists?(["archivo_id =#{archivo.id} and fecha_devolucion is null"]) == false
            archivosprestamo = Archivosprestamo.new
            archivosprestamo.archivo_id  = archivo.id
            archivosprestamo.fecha_vence = archivosprestamo.calculatiempo
            archivosprestamo.userprestamo = params[:ubicacion][:userprestamo]
            archivosprestamo.userregistro = is_admin
            archivosprestamo.save
          end
        end
      end
    end
  end

#  Asignar hasta el 20160407...
#  def asignar
#    if params[:ubicacion][:userprestamo].to_s != ""
#      @temporales = Temporal.find(:all, :conditions=>"persona_id is not null")
#      @temporales.each do |temporal|
#        archivospersonas = Archivospersona.find_all_by_persona_id(temporal.persona_id)
#        archivospersonas.each do |archivospersona|
#          if archivospersona.archivo.tipo.to_s == "A"
#            if Archivosprestamo.exists?(["archivo_id =#{archivospersona.archivo_id} and fecha_devolucion is null"]) == false
#              archivosprestamo = Archivosprestamo.new
#              archivosprestamo.archivo_id  = archivospersona.archivo_id
#              archivosprestamo.fecha_vence = archivosprestamo.calculatiempo
#              archivosprestamo.userprestamo = params[:ubicacion][:userprestamo]
#              archivosprestamo.userregistro = is_admin
#              archivosprestamo.save
#            end
#          end
#        end
#      end
#    end
#  end

  def new
    @archivo = Archivo.new
    @archivo.unidad_conservacion = 'CARPETA'
    @archivo.soporte = 'PAPEL'
    @archivo.frecuencia_consulta = 'MEDIA'
    @archivo.etapa = '1'
    render :action => "archivo_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update archivos set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end        
    @archivo = Archivo.find(params[:id])
    if @archivo.etapa.to_s == "2"
      @archivosprestamo= Archivosprestamo.new
    elsif @archivo.etapa.to_s == "3"
      @archivosimagen= Archivosimagen.new
    elsif @archivo.etapa.to_s == "4"
      @archivospersona = Archivospersona.new
    elsif @archivo.etapa.to_s == "5"
      @archivosempleado = Archivosempleado.new
    end
    respond_to do |format|
      format.html { render :action => "archivo_form" }
    end
  end

  def create
    @archivo = Archivo.new(params[:archivo])
    @archivo.user_id = is_admin
    @archivo.usercrea = is_admin
    @archivo.etapa = '1'
    if params[:archivo][:fecha_inicial].to_d <= '1970-01-01'.to_d
      fecha = params[:archivo][:fecha_inicial]
    end
    if params[:archivo][:fecha_final].to_d <= '1970-01-01'.to_d
      fecha2 = params[:archivo][:fecha_final]
    end
    if @archivo.save
      if fecha
        ActiveRecord::Base.connection.execute("update archivos set fecha_inicial = '#{fecha}' where id = #{@archivo.id}")
      end
      if fecha2
        ActiveRecord::Base.connection.execute("update archivos set fecha_final = '#{fecha2}' where id = #{@archivo.id}")
      end
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_archivo_path(@archivo)
    else
      render :action => "archivo_form"
    end
  end

  def update
    @archivo = Archivo.find(params[:id])
    @archivo.user_id = is_admin
    if params[:archivo][:fecha_inicial].to_d <= '1970-01-01'.to_d
      fecha = params[:archivo][:fecha_inicial]
    end
    if params[:archivo][:fecha_final].to_d <= '1970-01-01'.to_d
      fecha2 = params[:archivo][:fecha_final]
    end
    if @archivo.update_attributes(params[:archivo])
      @archivo.actualizacion(is_admin)
      if fecha
        ActiveRecord::Base.connection.execute("update archivos set fecha_inicial = '#{fecha}' where id = #{@archivo.id}")
      end
      if fecha2
        ActiveRecord::Base.connection.execute("update archivos set fecha_final = '#{fecha2}' where id = #{@archivo.id}")
      end
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_archivo_path(@archivo)
    else
      render :action => "archivo_form"
    end
    rescue
      flash[:notice] = "Existen inconsistencias. Verifique!!!"
      redirect_to edit_archivo_path(@archivo)
  end
#
#  def destroy
#    @archivo = Archivo.find(params[:id])
#    @archivo.destroy
#    respond_to do |format|
#      format.html {
#        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
#        redirect_to archivos_path
#      }
#      format.xml  { head :ok }
#    end
#  end

  def destroy
    if params[:id2].to_s == '2'
      @archivo = Archivo.find(params[:id])
      ActiveRecord::Base.connection.execute("delete from temporales where archivo_id = #{@archivo.id}")
    else
      @archivo = Archivo.find(params[:id])
      @archivo.destroy
      respond_to do |format|
        format.html {
          flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
          redirect_to archivos_path
        }
        format.xml  { head :ok }
      end
    end
  end

  def show
    persona   = Persona.find(params[:archivo_id])
    @archivos = persona.archivos.all
  end

  def stiker
    #@archivos = Archivo.find(:all, :conditions=>["id in (select distinct archivo_id from archivospersonas where persona_id in (select persona_id from temporales))"])
    @archivos = Archivo.find(:all, :conditions=>["id in (select distinct archivo_id from temporales)"], :order=> ["barrio, to_number(caja), to_number(carpeta) ASC"])
  end

  def rotulo
    @archivos = Archivo.find(:all, :conditions=>["id in (select distinct archivo_id from temporales)"], :order=> ["barrio, to_number(caja), to_number(carpeta) ASC"])
    #@archivos = Archivo.find(:all, :conditions=>["id in (select distinct archivo_id from archivospersonas where persona_id in (select persona_id from temporales))"])
  end

  private
  def determine_layout
    if ['import','csv_import','pendientesentrega','notificapendiente','asignar','stiker','rotulo','vigentesentrega'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
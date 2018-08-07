class TemporalesController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  require 'csv'

  def cargar_subsidios

  end
  
  def cargar_sub
   #En esta ruta esta el manual completo de cargar archivos
    #http://www.ubicuos.com/2009/06/24/subir-videos-con-ruby-on-rails/
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
        # crear el archivo
        File.open(path, "wb") { |f| f.write(archivo.read) }
        @archivoGuardado = true
        @ctl  = Sifi.find(2).valor.to_s+'subtemporales.ctl'
        @log  = Sifi.find(2).valor.to_s+'logsubtemporales.lst'
        @usr  = Sifi.find(1).valor.to_s
        @ruta = Sifi.find(2).valor.to_s+name.to_s
        ActiveRecord::Base.connection.execute("truncate table subtemporales")
        logger.error(" C:\\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\bin\\sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
        system (" C:\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\bin\\sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
        ActiveRecord::Base.connection.execute("
          begin
            for l1 in (select p.id, p.identificacion
                       from   personas p, subtemporales t
                       where  p.identificacion = t.cedula) loop
              update subtemporales set persona_id = l1.id where cedula = l1.identificacion;
              commit;
            end loop;
          end;")
        ActiveRecord::Base.connection.execute("delete from subtemporales where nombres = 'nombres'")
        @subtemporales = Subtemporal.find(:all, :order=> "persona_id")
        flash[:temporal] = 'Archivo Cargado con Exito...'
    else
        flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../temporales/import_sub">Aqui</a> para regresar'
    end
  end

  def cargar2
    #En esta ruta esta el manual completo de cargar archivos
    #http://www.ubicuos.com/2009/06/24/subir-videos-con-ruby-on-rails/
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
        # crear el archivo
        File.open(path, "wb") { |f| f.write(archivo.read) }
        @archivoGuardado = true
        @ctl  = Sifi.find(2).valor.to_s+'temporales.ctl'
        @log  = Sifi.find(2).valor.to_s+'logtemporales.lst'
        @usr  = Sifi.find(1).valor.to_s
        @ruta = Sifi.find(2).valor.to_s+name.to_s
        ActiveRecord::Base.connection.execute("truncate table temporales")
        system (" sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
        ActiveRecord::Base.connection.execute("
          begin
            for l1 in (select p.id, p.identificacion
                       from   personas p, temporales t
                       where  p.identificacion = t.identificacion) loop
              update temporales set persona_id = l1.id where identificacion = l1.identificacion;
              commit;
            end loop;
          end;")
        ActiveRecord::Base.connection.execute("update temporales set resolucion_id = (select id from resoluciones where nro_resolucion = temporales.nro_resolucion and anno = temporales.anno)")
        @temporales = Temporal.find(:all, :order=> "persona_id")
        flash[:temporal] = 'Archivo Cargado con Exito...'
    else
        flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../temporales/import">Aqui</a> para regresar'
    end
#    rescue
#    flash[:temporal] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../temporales/import">Aqui</a> para regresar'
  end

   def cargar
     temporales = Temporal.all
     n=0
     t=0
     temporales.each do |data|
       @resolucion = Resolucion.find(data.resolucion_id)
       if @resolucion.resolucionesclase_id == "10005"
         ActiveRecord::Base.connection.execute("
          insert into resolucionespersonas (id,resolucion_id,persona_id,created_at,user_id)
          values (resolucionespersonas_seq.nextval,#{@resolucion.id},#{data.persona_id},sysdate,#{is_admin})")
          t=t+1
       else
         if Resolucionespersona.exists?(["persona_id = ? and resolucion_id = ?", data.persona_id, data.resolucion_id]) == false
           if Resolucion.exists?(["resolucionesclase_id in (10000,10004,10020,10023,10024) and modalidad != 'ARRENDAMIENTO' and id in (select resolucion_id from resolucionespersonas where persona_id =?)", data.persona_id]) == false
             resolucionespersona = Resolucionespersona.new
             resolucionespersona.persona_id = data.persona_id
             resolucionespersona.resolucion_id = data.resolucion_id
             resolucionespersona.subsidio_especie  = data.subsidio_especie
             resolucionespersona.subsidio_dinero   = data.subsidio_dinero
             resolucionespersona.subsidio_mejoras  = data.subsidio_mejoras
             resolucionespersona.credito  = data.credito
             resolucionespersona.arrendamiento  = data.arrendamiento
             resolucionespersona.user_id = is_admin
             resolucionespersona.save
             t=t+1
           elsif Resolucion.exists?(["resolucionesclase_id in (10000,10004,10020,10023,10024) and modalidad = 'ARRENDAMIENTO'
                                      and id in (select resolucion_id from resolucionespersonas where persona_id =?)", data.persona_id]) == true
             resolucionespersona = Resolucionespersona.new
             resolucionespersona.persona_id = data.persona_id
             resolucionespersona.resolucion_id = data.resolucion_id
             resolucionespersona.subsidio_especie  = data.subsidio_especie
             resolucionespersona.subsidio_dinero   = data.subsidio_dinero
             resolucionespersona.subsidio_mejoras  = data.subsidio_mejoras
             resolucionespersona.credito  = data.credito
             resolucionespersona.arrendamiento  = data.arrendamiento
             resolucionespersona.user_id = is_admin
             resolucionespersona.save
             t=t+1
           elsif permiso("resolucionesespecial","C").to_s == "S"
             resolucionespersona = Resolucionespersona.new
             resolucionespersona.persona_id = data.persona_id
             resolucionespersona.resolucion_id = data.resolucion_id
             resolucionespersona.subsidio_especie  = data.subsidio_especie
             resolucionespersona.subsidio_dinero   = data.subsidio_dinero
             resolucionespersona.subsidio_mejoras  = data.subsidio_mejoras
             resolucionespersona.credito  = data.credito
             resolucionespersona.arrendamiento  = data.arrendamiento
             resolucionespersona.user_id = is_admin
             resolucionespersona.save
             t=t+1
           end
         end
       end
     end
     flash.now[:notice]="Archivo cargado a la base de datos,  #{t} personas vinculadas a la resolucion "
   end

  def index
    @temporales = Temporal.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @temporales }
    end
  end

  def show
    @temporal = Temporal.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @temporal }
    end
  end

  def new
    @temporal = Temporal.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @temporal }
    end
  end

  def edit
    @temporal = Temporal.find(params[:id])
  end

  def create
    @temporal = Temporal.new(params[:temporal])
    respond_to do |format|
      if @temporal.save
        format.html { redirect_to(@temporal, :notice => 'Temporal was successfully created.') }
        format.xml  { render :xml => @temporal, :status => :created, :location => @temporal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @temporal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @temporal = Temporal.find(params[:id])
    respond_to do |format|
      if @temporal.update_attributes(params[:temporal])
        format.html { redirect_to(@temporal, :notice => 'Temporal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @temporal.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @temporal = Temporal.find(params[:id])
    @temporal.destroy
    respond_to do |format|
      format.html { redirect_to(temporales_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['import','csv_import','cargar2','cargar','cargar_sub','import_sub'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

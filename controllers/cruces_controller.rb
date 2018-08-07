class CrucesController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  require 'ruby_plsql'
  
  def cargar2
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
        # crear el archivo
        File.open(path, "wb") { |f| f.write(archivo.read) }
        @archivoGuardado = true
        @ctl  = Sifi.find(2).valor.to_s+'temporalescruces.ctl'
        @log  = Sifi.find(2).valor.to_s+'logtemporalescruces.lst'
        @usr  = Sifi.find(1).valor.to_s
        @ruta = Sifi.find(2).valor.to_s+name.to_s
        ActiveRecord::Base.connection.execute("truncate table temporalescruces")
        system (" sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
        #Procedimiento de Actualizacion
        ActiveRecord::Base.connection.execute("begin prc_validacioncargue; end;")
        @cruces = Cruce.find_by_sql("select identificacion, persona_id, benevivienda_id from temporalescruces")
        flash[:temporal] = 'Archivo Etapa 1 Cargado con Exito...'
    else
        flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../cruces/import">Aqui</a> para regresar'
    end
#    rescue
#    flash[:temporal] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../temporales/import">Aqui</a> para regresar'
  end

  def cargarfinal
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
        # crear el archivo
        File.open(path, "wb") { |f| f.write(archivo.read) }
        @archivoGuardado = true
        @ctl  = Sifi.find(2).valor.to_s+'temporalescrucesdatos.ctl'
        @log  = Sifi.find(2).valor.to_s+'logtemporalescrucesdatos.lst'
        @usr  = Sifi.find(1).valor.to_s
        @ruta = Sifi.find(2).valor.to_s+name.to_s
        ActiveRecord::Base.connection.execute("truncate table temporalescrucesdatos")
        system (" sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
        @cruces = Cruce.find_by_sql("select identificacion from temporalescrucesdatos")
        #@cruces = Cruce.all
        flash[:temporal] = 'Archivo Etapa 2 Cargado con Exito...'
    else
        flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../cruces/import">Aqui</a> para regresar'
    end
#    rescue
#    flash[:temporal] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../temporales/import">Aqui</a> para regresar'
  end

  def consolidar
    last_id = Cruce.maximum('id')
    begin
      @cruce = Cruce.find(last_id)
      conse = @cruce.consecutivo.to_i + 1
    rescue
      conse = 1
    end
    ActiveRecord::Base.connection.execute("begin prc_cruce(#{is_admin},#{conse}); end;")
    flash[:notice] = 'Proceso cargue de cruces finalizado con exito'
    redirect_to import_cruces_path
  end

  def informecruce
    @cruce = Cruce.find(params[:id])
  end

  def index
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update users set etapa = '#{params[:etapa]}' where id = #{is_admin}")
    end 
    @user = User.find(is_admin)
    if @user.etapa.to_s == '1'
      @crucessolicitudes = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, created_at, count(9) cantidad"], :conditions =>"estado is null and clase = 'CRUCE'", :group=>"consecutivo, user_id, created_at", :order=>"consecutivo asc")  
    elsif @user.etapa.to_s == '2'
      @crucessolicitudese = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, user_atencion, updated_at, count(9) cantidad"], :conditions =>"estado = 'EN TRAMITE' and clase = 'CRUCE'", :group=>"consecutivo, user_id, updated_at, user_atencion", :order=>"consecutivo asc")
    elsif @user.etapa.to_s == '3'
      @crucessolicitudest = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, user_atencion, updated_at, count(9) cantidad"], :conditions =>"estado = 'TERMINADO' and clase = 'CRUCE'",:limit=>50, :group=>"consecutivo, user_id, updated_at, user_atencion", :order=>"updated_at desc")
      @crucessolicitudestotal = Crucessolicitud.all(:select => ["distinct consecutivo"], :conditions =>"estado = 'TERMINADO' and trunc(updated_at) = trunc(sysdate) and clase = 'CRUCE'",:group=>"consecutivo")
    elsif @user.etapa.to_s == '4'
      @crucessolicitudes = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, created_at, count(9) cantidad"], :conditions =>"estado is null and clase = 'ZR'", :group=>"consecutivo, user_id, created_at", :order=>"consecutivo asc")  
    elsif @user.etapa.to_s == '5'
      @crucessolicitudese = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, user_atencion, updated_at, count(9) cantidad"], :conditions =>"estado = 'EN TRAMITE' and clase = 'ZR'", :group=>"consecutivo, user_id, updated_at, user_atencion", :order=>"consecutivo asc")
    elsif @user.etapa.to_s == '6'
      @crucessolicitudest = Crucessolicitud.all(:select => ["distinct consecutivo, user_id, user_atencion, updated_at, count(9) cantidad"], :conditions =>"estado = 'TERMINADO' and clase = 'ZR'",:limit=>50, :group=>"consecutivo, user_id, updated_at, user_atencion", :order=>"updated_at desc")
      @crucessolicitudestotal = Crucessolicitud.all(:select => ["distinct consecutivo"], :conditions =>"estado = 'TERMINADO' and trunc(updated_at) = trunc(sysdate) and clase = 'ZR'",:group=>"consecutivo")
    end
  end
  
  def certificacioncruce
    @persona = Persona.find(params[:id])
  end

  def certificacioncrucem
    @personas = Persona.find(:all, :conditions=>["identificacion in ('3553947','43347720','11796705','50939855','70163252','8115540','21431669','70166393','22019521','21811635','43764104',
                                                  '1027951361','39309287','79758130','39410716','1010031213','43257794','43479150','43607576','39312690','43796605',
                                                  '98613876','21778399','18614652','66963224','32254186','22226738','43474589','1128407684','43160429','94525142',
                                                  '43462702','70350253','43445208','44153807','22819024','21691803','43702352','43541202','43050872','43417104',
                                                  '39299960','15535095','21778726','21609646','3575526','3354435','43477269','21997914','15317636','39296644',
                                                  '43382087','43380835','3417594','3493014','71973749','21697791','67015001','3445073','32503923','21420859',
                                                  '43272368','21778753','43640371','43576555','43157605','22104881','43603268','32180501','70303058','21809972',
                                                  '22007741','32475488','70384362','11808374','22234769','21691974','21659500','22032614','43144070','43835182',
                                                  '70830496','21486136','2479167','79805242','21609259','22087757','50984358','43924694','22100908','21475897',
                                                  '3492552','39448874','71624695','15481566','39402888','16343429','70166559','3450891','43381121','43476848','70163268',
                                                  '70166714','22234002','3575650','32485418','70829991','43461366','71001627','3492114','70163433','60290975',
                                                  '43646038','71799640','3647037','6214981','40366113','32195260','8411767','3618641','21911252','78109773','659985')"], :order=>"to_number(identificacion) asc")
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @cruces = persona.cruces.all
  end

  def showa
    persona   = Persona.find(params[:persona_id])
    @cruces = persona.cruces.all
  end

  def mostrar
    @persona = Persona.find(params[:persona_id])
  end

  private
  def determine_layout
    if ['informecruce','certificacioncruce','certificacioncrucem'].include?(action_name)
      "atencion"
    elsif ['mostrar'].include?(action_name)
      "vistacruce"
    else
      "application"
    end
  end
end

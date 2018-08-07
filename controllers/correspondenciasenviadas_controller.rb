class CorrespondenciasenviadasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  require 'csv'
  require 'find'

  def upload
    rutaupload = Sifi.find(22).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        nombre = File.basename(f).to_s
        nombre = nombre.gsub("Comunicacion enviada ","")
        nombre = nombre.gsub("comunicacion enviada ","")
        nombre = nombre.gsub("COMUNICACION ENVIADA ","")
        nombre = nombre.gsub("Guia ","")
        nombre = nombre.gsub("GUIA ","")
        nombre = nombre.gsub("guia ","")
        nombre = nombre.gsub(".pdf","")
        nombre = nombre.gsub(".PDF","")
        nombre = nombre.gsub("(","")
        nombre = nombre.gsub(")","")
        begin
          @correspondenciasenviada = Correspondenciasenviada.find(:first, :conditions=>["nro_radicado = '#{nombre}' and anno = to_char(sysdate,'YYYY')"])
          if @correspondenciasenviada
            @corresenviadasimagen = Corresenviadasimagen.new
            @corresenviadasimagen.correspondenciasenviada_id = @correspondenciasenviada.id
            @corresenviadasimagen.descripcion = "Enviada " + File.basename(f).to_s
            @corresenviadasimagen.enviada = file
            @corresenviadasimagen.save
            file.close
            File.delete(path)
          else
            file.close
            ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
          end
        rescue
          file.close
          ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
        end
      # si la ruta es un directorio -> D
      when File.directory?(f) then "D"
      # si no sabemos lo que es -> ?
      else "?"
      end
    end
    flash[:notice] = "Proceso finalizado"
    @objetos = Objeto.find_by_sql("select * from error")
    #redirect_to correspondenciasenviadas_path
  end

  def uploadguia
    rutaupload = Sifi.find(22).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        nombre = File.basename(f).to_s
        begin
          if nombre == "guia.csv"
            file.each do |line|
              d1,d2 = line.strip.split(";")
              #logger.error("SIFI #{d2}  --- #{d1}")
              @correspondenciasenviada = Correspondenciasenviada.find(:first, :conditions=>["nro_radicado = '#{d2}' and anno = to_char(sysdate,'YYYY')"])
              if @correspondenciasenviada
                @correspondenciasenviada.guiacorreo = d1.to_s
                @correspondenciasenviada.save
                #logger.error("SIFI Actualizado ... #{d2}  --- #{d1}")
              end
            end
          end
        rescue
          ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
        end
        if nombre == "guia.csv"
          file.close
          File.delete(path)
          flash[:notice] = "La informacion de la guias ha sido cargada con exito..."
        else
          flash[:warning] = "El archivo no esta nombrado correctamente.. Recuerde que debe ser 'guia.csv'...."
        end
      # si la ruta es un directorio -> D
      when File.directory?(f) then "D"
      # si no sabemos lo que es -> ?
      else "?"
      end
    end
    #flash[:notice] = "Proceso finalizado"
    @objetos = Objeto.find_by_sql("select * from error")
    #redirect_to correspondenciasenviadas_path
  end


  def csv_import
     @parsed_file=CSV::Reader.parse(params[:dump][:file], ';')
     ActiveRecord::Base.connection.execute("truncate table temporales")
     @ultimoradicado = Correspondenciasenviada.maximum("to_number(nro_radicado)", :conditions =>[" anno = to_char(trunc(sysdate),'yyyy')"])
     @ultimoid       = Correspondenciasenviada.maximum("id", :conditions =>[" nro_radicado = '#{@ultimoradicado}' and anno = to_char(trunc(sysdate),'yyyy')"])
     consecutivoinicia = @ultimoradicado + 1
     n=0
     i = 1
     @parsed_file.each  do |row|
       c = Temporal.new
       #logger.error("Valor #{i} ..." + row[0].to_s)
       c.identificacion   = row[0].to_s
       c.nro_resolucion   = consecutivoinicia
       c.anno = i
       c.save
       n=n+1
       i=i+1
       consecutivoinicia = consecutivoinicia + 1
     end
     ActiveRecord::Base.connection.execute("update temporales set persona_id = (select id from personas where ltrim(rtrim(identificacion)) = ltrim(rtrim(temporales.identificacion)))")
     @temporales = Temporal.find(:all, :order=>"to_number(anno)")
     flash[:notice] = "Archivo importado con Exito, #{n} registros cargados Temporalmente"
  end

  def generarmasivo
    corid = params[:valorid].to_i
    @correspondenciasenviada = Correspondenciasenviada.find(corid)
    @temporales = Temporal.find(:all, :order=>"to_number(anno)")
    @temporales.each do |temporal|
      correspondenciasenviada = Correspondenciasenviada.new
      correspondenciasenviada.nro_radicado = temporal.nro_resolucion
      correspondenciasenviada.fecha_elaboracion =   @correspondenciasenviada.fecha_elaboracion
      correspondenciasenviada.lugar_destino =   @correspondenciasenviada.lugar_destino
      correspondenciasenviada.persona_id =   temporal.persona_id
      correspondenciasenviada.correspondenciasremitente_id =   @correspondenciasenviada.correspondenciasremitente_id
      correspondenciasenviada.asunto =   @correspondenciasenviada.asunto
      correspondenciasenviada.dependencia_id =   @correspondenciasenviada.dependencia_id
      correspondenciasenviada.anexos =   @correspondenciasenviada.anexos
      correspondenciasenviada.devolucion =   @correspondenciasenviada.devolucion
      correspondenciasenviada.reenvio =   @correspondenciasenviada.reenvio
      correspondenciasenviada.guiacorreo =   @correspondenciasenviada.guiacorreo
      correspondenciasenviada.observacion =   @correspondenciasenviada.observacion
      correspondenciasenviada.user_id =   is_admin
      correspondenciasenviada.userdependencia_id =   @correspondenciasenviada.userdependencia_id
      correspondenciasenviada.anno =   @correspondenciasenviada.anno
      correspondenciasenviada.fecha_documento =   @correspondenciasenviada.fecha_documento
      correspondenciasenviada.fecha_entrega =   @correspondenciasenviada.fecha_entrega
      correspondenciasenviada.useract_id =   is_admin
      correspondenciasenviada.userelabora_id =   @correspondenciasenviada.userelabora_id
      correspondenciasenviada.save
    end
    flash[:notice] = "Proceso finalizado con exito."
    redirect_to import_correspondenciasenviadas_path
  end

  def index
    dato1 = params[:ubicacion][:correspondenciasremitente_id].to_s rescue nil
    dato2 = params[:ubicacion][:fchelainicial].to_s rescue nil
    dato3 = params[:ubicacion][:fchelafinal].to_s rescue nil
    dato4 = params[:ubicacion][:dependencia_id].to_s rescue nil
    dato5 = params[:ubicacion][:userfirma].to_s rescue nil
    dato6 = params[:ubicacion][:userelabora].to_s rescue nil
    dato7 = params[:ubicacion][:devolucion].to_s rescue nil
    dato8 = params[:ubicacion][:reenvio].to_s rescue nil
    dato9 = params[:ubicacion][:causal].to_s rescue nil
    pag = params[:page]
    if params[:format] == 'xls'
      pag = 100000
    end
    @correspondenciasenviadas = Correspondenciasenviada.search(params[:nro_radicado],
                                                               params[:identificacion],
                                                               params[:identificacionb],
                                                               dato1,dato2,dato3,dato4,
                                                               params[:asunto],
                                                               params[:observacion],
                                                               params[:empresa],
                                                               params[:empresar],
                                                               dato5,dato6,dato7,dato8,
                                                               params[:anexo],
                                                               dato9, pag)
    logger.error("1Aqui empiezan los datos con.... "+@correspondenciasenviadas.count.to_s)
    if @correspondenciasenviadas.count == 0 and params[:format] != 'xls'
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @correspondenciasenviadas }
      end        
    elsif @correspondenciasenviadas.count == 1 and params[:format] != 'xls'
      redirect_to edit_correspondenciasenviada_path(:id=>@correspondenciasenviadas, :etapa=>"1")
    else
      if params[:format] == 'xls'
        logger.error("Aqui empiezan los datos con.... "+@correspondenciasenviadas.count.to_s)
        @correspondenciasenviadas.each do |a|
          logger.error("datos..."+a.id.to_s+"-------------")
        end
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_Enviada_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"
        respond_to do |format|
           format.xls
        end
      else
        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @correspondenciasenviadas }
        end   
      end
    end
  end

=begin
  def buscar
    @correspondenciasenviadas = Correspondenciasenviada.search(
                             params[:nro_radicado],
                             params[:identificacion],
                             params[:identificacionb],
                             params[:ubicacion][:correspondenciasremitente_id],
                             params[:ubicacion][:fchelainicial],
                             params[:ubicacion][:fchelafinal],
                             params[:ubicacion][:dependencia_id],
                             params[:asunto],
                             params[:observacion],
                             params[:empresa],
                             params[:empresar],
                             params[:ubicacion][:userfirma],
                             params[:ubicacion][:userelabora],
                             params[:ubicacion][:devolucion],
                             params[:ubicacion][:reenvio],
                             params[:anexo],
                             params[:ubicacion][:causal], params[:page])
    if @correspondenciasenviadas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to correspondenciasenviadas_path
    elsif @correspondenciasenviadas.count == 1 and params[:format] != 'xls'
      redirect_to edit_correspondenciasenviada_path(@correspondenciasenviadas)
    else
      if params[:format] == 'xls'
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_Enviada_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
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
=end

  def new
    @correspondenciasenviada = Correspondenciasenviada.new
    @correspondenciasenviada.etapa = '1'
    render :action => "correspondenciasenviada_form"
  end

  def stikerp
    @correspondenciasenviadas = Correspondenciasenviada.find(:all, :conditions=>["to_number(nro_radicado) between #{params[:inicial]} and #{params[:final]} and anno = '#{Time.now.strftime("%Y")}'"], :order=>"to_number(nro_radicado)")
    @cantidad = params[:cantidad]
  end

  def stikerm
    @correspondenciasenviadas = Correspondenciasenviada.find(:all, :conditions=>["to_number(nro_radicado) between #{params[:inicial]} and #{params[:final]} and anno = '#{Time.now.strftime("%Y")}'"], :order=>"to_number(nro_radicado)")
    @cantidad = params[:cantidad]
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update correspondenciasenviadas set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end     
    @correspondenciasenviada = Correspondenciasenviada.find(params[:id])
    if @correspondenciasenviada.etapa.to_s == "2"
      @correspondenciasradicado = Correspondenciasradicado.new
    elsif @correspondenciasenviada.etapa.to_s == "3"
      @corresenviadasimagen = Corresenviadasimagen.new
    end
    respond_to do |format|
      format.html { render :action => "correspondenciasenviada_form" }
    end
  end

  def create
    @correspondenciasenviada = Correspondenciasenviada.new(params[:correspondenciasenviada])
    if @correspondenciasenviada.fecha_elaboracion.strftime("%Y-%m-%d") > Time.now.strftime("%Y-%m-%d")
      flash[:notice] = "ATENCIÓN: La fecha del documento no puede tener fecha superior a "+Time.now.strftime("%Y-%m-%d")
      render :action => "correspondenciasenviada_form"
    else
      @correspondenciasenviada.user_id = is_admin
      @correspondenciasenviada.useract_id = is_admin
      @correspondenciasenviada.anno = Time.now.strftime("%Y")
      @correspondenciasenviada.nro_radicado = is_nextenviada
      @correspondenciasenviada.etapa = '1'
      if @correspondenciasenviada.save
        flash[:notice] = "El registro ha sido registrado con Exito."
        redirect_to edit_correspondenciasenviada_path(@correspondenciasenviada)
      else
        render :action => "correspondenciasenviada_form"
      end
    end
    rescue
      flash[:warning] = "Faltan datos"
      render :action => "correspondenciasenviada_form"
  end

  def update
    @correspondenciasenviada = Correspondenciasenviada.find(params[:id])
    @correspondenciasenviada.useract_id = is_admin
    if params[:correspondenciasenviada][:fecha_elaboracion] > Time.now.strftime("%Y-%m-%d")
      flash[:notice] = "ATENCIÓN: La fecha del documento no puede tener fecha superior a "+Time.now.strftime("%Y-%m-%d")
      render :action => "correspondenciasenviada_form"
    else
      if @correspondenciasenviada.update_attributes(params[:correspondenciasenviada])
        flash[:notice] = "El registro ha sido actualizado con Exito."
        redirect_to edit_correspondenciasenviada_path(@correspondenciasenviada)
      else
        render :action => "correspondenciasenviada_form"
      end
    end
#    rescue
#        flash[:notice] = "Existen inconsistencias. Verifique!!!"
#        redirect_to edit_correspondenciasenviada_path(@correspondenciasenviada)
  end

  def destroy
    @correspondenciasenviada = Correspondenciasenviada.find(params[:id])
    @correspondenciasenviada.destroy
    respond_to do |format|
       format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to correspondenciasenviadas_path
        }
      format.xml  { head :ok }
    end
  end

  def show
    persona   = Persona.find(params[:correspondenciasenviada_id])
    @correspondenciasenviadas = persona.correspondenciasenviadas.all
  end

  private
  def determine_layout
    if ['import','csv_import','cargar2','cargar','stikerinforme','upload'].include?(action_name)
      "atencion"
    elsif['stikerp','stikerm'].include?(action_name)
      "stiker"
    else
      "application"
    end
  end
end
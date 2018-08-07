include ChainSelectsHelper
class MejoramientosController < ApplicationController
  before_filter :require_user
  require 'ruby_plsql'
  layout :determine_layout
  require 'ruby_plsql'
  require 'csv'
  require 'find'
  require 'fileutils'
  require 'tempfile'

  def verificasupsubsidio   
    @mejoramientos = Mejoramiento.find(:all, :conditions=>["convenio_id = 64"])
    #@mejoramientos = Mejoramiento.find(:all, :conditions=>["id in (10937)"])
    @mejoramientos.each do |mejoramiento|
      if mejoramiento.vlrtotaleje.to_f > mejoramiento.valor_resolucion
        if mejoramiento.mejoramientoselementos.exists?(["mejoramientositem_id = 1045"])
          #logger.error("Se paso y tiene concepto..."+mejoramiento.id.to_s)
          @diferencia = mejoramiento.vlrtotaleje.to_f - mejoramiento.valor_resolucion.to_f
          #logger.error("Diferencia..."+@diferencia.to_s)
          @mejoramientoselemento = Mejoramientoselemento.find(:first, :conditions=>["mejoramiento_id = #{mejoramiento.id} and mejoramientositem_id = 1045"])
          @mejorainformeselemento = Mejorainformeselemento.find(:first, :conditions=>["mejoramientosinforme_id in (select id from mejoramientosinformes
                                                                                       where mejoramiento_id = #{mejoramiento.id}) and mejoramientoselemento_id = #{@mejoramientoselemento.id}"])
          @dif1 = @mejorainformeselemento.valor_total.to_f - @diferencia
          #logger.error("Diferencia..."+@diferencia.to_s)
          #logger.error("Valor del item..."+@mejorainformeselemento.valor_total.to_s)
          #logger.error("Valor real del item...."+mejoramiento.id.to_s+" --- Diferencia..."+@dif1.to_s)
          #if @dif1.to_f > 0.0
          ActiveRecord::Base.connection.execute("update mejorainformeselementos set valor_total= #{@dif1.to_f} where id = #{@mejorainformeselemento.id}")
          #end
        else
          logger.error("Se paso y NO tiene concepto..."+mejoramiento.id.to_s)
        end
      end
    end
    redirect_to mejoramientos_path
  end

  def verificarceo
    @rutaupload = "F:\\titulacion\\fase1fotos\\"
    Find.find(@rutaupload) do |f|
        #file   = File.open(f, 'rb')
        path   = File.join(@rutaupload, File.basename(f).to_s)
        ori = File.basename(f).to_s
        formulario = File.basename(f).to_s
        formulario = formulario.gsub("img","")
        formulario = formulario.gsub(".jpg","")
        form1 = ""
        @objetos = Objeto.find_by_sql(["select substr('#{formulario}',1,INSTR('#{formulario}','P', 1, 1)-1) form from dual"])
        @objetos.each do |objeto|
          form1 = objeto.form.to_s
        end
        if form1.to_s != ""
          if Temporal.exists?(["identificacion = '#{form1}'"]) == false
            @serverfoto = "f:\\titulacion\\fase1\\#{form1.to_s}\\#{ori.to_s}"
            begin
              FileUtils.mv(path, @serverfoto, :force => true)
              logger.error("Movida..."+@serverfoto.to_s)
              #File.delete(path)
            rescue
              logger.error("Errro Moviendo..."+@serverfoto.to_s)
            end
          else
            logger.error("Ya Movido.."+ori.to_s)
          end
        end
    end
    flash[:notice] = "Proceso finalizado"
    #@objetos = Objeto.find_by_sql("select * from error")
    redirect_to mejoramientos_path
  end


  def uploadcierre
    rutaupload = Sifi.find(22).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        identificacion = File.basename(f).to_s
        identificacion = identificacion.gsub(".pdf","")
        begin
          @mejoramiento = Mejoramiento.find(:first, :conditions=>["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"])
          if @mejoramiento
            if Mejoramientosimagen.exists?(["mejoramiento_id = #{@mejoramiento.id} and cuando = 'EXPEDIENTE DE CIERRE'"]) == false
              @mejoramientosimagen = Mejoramientosimagen.new
              @mejoramientosimagen.mejoramiento_id = @mejoramiento.id
              @mejoramientosimagen.descripcion = "ARCHIVO EXPEDIENTE DE CIERRE"
              @mejoramientosimagen.cuando = "EXPEDIENTE DE CIERRE"
              @mejoramientosimagen.mejoramiento = file
              @mejoramientosimagen.save
              file.close
              File.delete(path)
            else
              ActiveRecord::Base.connection.execute("insert into error values ('Este archivo ya ha sido cargado... #{File.basename(f).to_s}')")
              file.close
              File.delete(path)
            end
          else
            ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
          end
        rescue
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
    redirect_to mejoramientos_path
  end

  def uploaddiag
    rutaupload = Sifi.find(22).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        identificacion = File.basename(f).to_s
        identificacion = identificacion.gsub(".pdf","")
        begin
          @mejoramiento = Mejoramiento.find(:first, :conditions=>["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"])
          if @mejoramiento
            if Mejoramientosimagen.exists?(["mejoramiento_id = #{@mejoramiento.id} and cuando = 'EXPEDIENTE DE DIAGNOSTICO'"]) == false
              @mejoramientosimagen = Mejoramientosimagen.new
              @mejoramientosimagen.mejoramiento_id = @mejoramiento.id
              @mejoramientosimagen.descripcion = "ARCHIVO EXPEDIENTE DE DIAGNOSTICO"
              @mejoramientosimagen.cuando = "EXPEDIENTE DE DIAGNOSTICO"
              @mejoramientosimagen.mejoramiento = file
              @mejoramientosimagen.save
              file.close
              File.delete(path)
            else
              ActiveRecord::Base.connection.execute("insert into error values ('Este archivo ya ha sido cargado... #{File.basename(f).to_s}')")
              file.close
              File.delete(path)
            end
          else
            ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
          end
        rescue
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
    redirect_to mejoramientos_path
    #redirect_to busqueda_correspondenciasenviadas_path
  end

  def uploadotro
    rutaupload = Sifi.find(22).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        identificacion = File.basename(f).to_s
        identificacion = identificacion.gsub(".pdf","")
        begin
          @mejoramiento = Mejoramiento.find(:first, :conditions=>["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"])
          if @mejoramiento
              @mejoramientosimagen = Mejoramientosimagen.new
              @mejoramientosimagen.mejoramiento_id = @mejoramiento.id
              @mejoramientosimagen.descripcion = "APROBACION DE ACTAS Y POLIZAS"
              @mejoramientosimagen.cuando = "OTROS"
              @mejoramientosimagen.mejoramiento = file
              @mejoramientosimagen.save
              file.close
              File.delete(path)
          else
            ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
          end
        rescue
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
    redirect_to mejoramientos_path
    #redirect_to busqueda_correspondenciasenviadas_path
  end

  def uploadotroinicial
    rutaupload = Sifi.find(22).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        identificacion = File.basename(f).to_s
        identificacion = identificacion.gsub(".pdf","")
        begin
          @mejoramiento = Mejoramiento.find(:first, :conditions=>["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"])
          if @mejoramiento
              @mejoramientosimagen = Mejoramientosimagen.new
              @mejoramientosimagen.mejoramiento_id = @mejoramiento.id
              @mejoramientosimagen.descripcion = "FOTOS INICIALES"
              @mejoramientosimagen.cuando = "OTROS"
              @mejoramientosimagen.mejoramiento = file
              @mejoramientosimagen.save
              file.close
              File.delete(path)
          else
            ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
          end
        rescue
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
    redirect_to mejoramientos_path
    #redirect_to busqueda_correspondenciasenviadas_path
  end

  def uploadotroeje
    rutaupload = Sifi.find(22).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        identificacion = File.basename(f).to_s
        identificacion = identificacion.gsub(".pdf","")
        begin
          @mejoramiento = Mejoramiento.find(:first, :conditions=>["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"])
          if @mejoramiento
              @mejoramientosimagen = Mejoramientosimagen.new
              @mejoramientosimagen.mejoramiento_id = @mejoramiento.id
              @mejoramientosimagen.descripcion = "EJECUCION"
              @mejoramientosimagen.cuando = "OTROS"
              @mejoramientosimagen.mejoramiento = file
              @mejoramientosimagen.save
              file.close
              File.delete(path)
          else
            ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
          end
        rescue
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
    redirect_to mejoramientos_path
    #redirect_to busqueda_correspondenciasenviadas_path
  end

  def uploadotropagare
    rutaupload = Sifi.find(22).valor.to_s
    ActiveRecord::Base.connection.execute("truncate table error")
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        identificacion = File.basename(f).to_s
        identificacion = identificacion.gsub(".pdf","")
        begin
          @mejoramiento = Mejoramiento.find(:first, :conditions=>["persona_id = (select id from personas where identificacion = '#{identificacion.to_s}')"])
          if @mejoramiento
              @mejoramientosimagen = Mejoramientosimagen.new
              @mejoramientosimagen.mejoramiento_id = @mejoramiento.id
              @mejoramientosimagen.descripcion = "PAGARE"
              @mejoramientosimagen.cuando = "OTROS"
              @mejoramientosimagen.mejoramiento = file
              @mejoramientosimagen.save
              file.close
              File.delete(path)
          else
            ActiveRecord::Base.connection.execute("insert into error values ('No se cargo el archivo : #{File.basename(f).to_s}')")
          end
        rescue
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
    redirect_to mejoramientos_path
    #redirect_to busqueda_correspondenciasenviadas_path
  end

  def index
  end

  def show
    persona   = Persona.find(params[:persona_id])
    @mejoramientos = persona.mejoramientos.all
  end

  def new
    @mejoramiento = Mejoramiento.new
    @mejoramientosinterventoria = Mejoramientosinterventoria.new
    @mejoramientoselemento = Mejoramientoselemento.new
    @mejoramientosimagen = Mejoramientosimagen.new
    @mejoramientosconcepto = Mejoramientosconcepto.new
    @mejoramientosnota = Mejoramientosnota.new
    @mejoramientospago = Mejoramientospago.new
    @mejoramientosobra = Mejoramientosobra.new
    @mejoramientoslista = Mejoramientoslista.new
    render :action => "mejoramiento_form"
  end

  def ajuste99
    @mejoramientos = Mejoramiento.search99(params[:id],
                                         params[:conveniosresolucion])
    c = 0
    @mejoramientos.each do |mejoramiento|
      if mejoramiento.pendientecierre.to_i == 1
        c = c + 1
        #logger.error("dato...."+mejoramiento.id.to_s+" ---- "+mejoramiento.persona_id.to_s)
        ActiveRecord::Base.connection.execute("begin prc_ajuste99(#{mejoramiento.persona_id.to_i}); end;")
      end
    end
    flash[:notice] = "Ajuste de 99% realizado, total : " + c.to_s
    redirect_to mejoramientos_path
  end

  def buscar
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end    
    @convenio = params[:ubicacion][:convenio].to_i
    @resol =  params[:ubicacion][:conveniosresolucion].to_i
    @mejoramientos = Mejoramiento.search(params[:ubicacion][:convenio],
                                         params[:ubicacion][:conveniosresolucion],
                                         params[:identificacion],
                                         params[:ubicacion][:user_coordinador],
                                         params[:ubicacion][:user_profesional],
                                         params[:ubicacion][:user_tecnologo],
                                         params[:ubicacion][:user_interventor],
                                         params[:ubicacion][:mejoramientosestado_id],params[:page],perpage)
    if @mejoramientos.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to mejoramientos_path
    elsif @mejoramientos.count == 1 and params[:format] != 'xls'
      redirect_to edit_mejoramiento_path(:id => @mejoramientos, :etapa=>"1")
    else
      if params[:format] == 'xls'
        headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_Mejoramientos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
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

  def cambio
    #logger.error("Resolucion "+ params[:ubicacion1][:conveniosresolucion].to_s)
    if params[:ubicacion][:clase].to_s == "" and params[:ubicacion][:user_ori].to_s == "" and params[:ubicacion][:user_new].to_s == ""
      flash[:warning] = "Debe seleccionar todos los datos del Cambio de Responsable"
      redirect_to mejoramientos_path
    elsif params[:ubicacion][:user_ori].to_s == params[:ubicacion][:user_new].to_s
      flash[:warning] = "Debe seleccionar responsables diferentes"
      redirect_to mejoramientos_path
    else
      if params[:ubicacion][:clase].to_s == "COORDINADOR"
        if Mejoramiento.exists?(["user_coordinador = #{params[:ubicacion][:user_ori].to_i}"])
          if params[:ubicacion1][:convenio].to_i > 0 and params[:ubicacion1][:conveniosresolucion].to_i > 0
            ActiveRecord::Base.connection.execute("update mejoramientos set user_coordinador = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_coordinador = #{params[:ubicacion][:user_ori].to_i}
                                                  and    convenio_id = #{params[:ubicacion1][:convenio].to_i}
                                                  and    resolucion_id = (select resolucion_id from conveniosresoluciones where id = #{params[:ubicacion1][:conveniosresolucion].to_i})")
            ActiveRecord::Base.connection.execute("update conveniosresoluciones set user_coordinador = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_coordinador = #{params[:ubicacion][:user_ori].to_i}
                                                  and    convenio_id = #{params[:ubicacion1][:convenio].to_i}
                                                  and    resolucion_id = (select resolucion_id from conveniosresoluciones where id = #{params[:ubicacion1][:conveniosresolucion].to_i})")
          else
            ActiveRecord::Base.connection.execute("update mejoramientos set user_coordinador = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_coordinador = #{params[:ubicacion][:user_ori].to_i}")
            ActiveRecord::Base.connection.execute("update conveniosresoluciones set user_coordinador = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_coordinador = #{params[:ubicacion][:user_ori].to_i}")
          end
          flash[:notice] = "Se realizaron las actualizaciones de COORDINADOR en los Mejoramientos y en el Convenio"
          redirect_to mejoramientos_path
        else
          flash[:warning] = "El COORDINADOR seleccionado no tiene Mejoramientos asignados"
          redirect_to mejoramientos_path
        end
      elsif params[:ubicacion][:clase].to_s == "PROFESIONAL"
        if Mejoramiento.exists?(["user_profesional = #{params[:ubicacion][:user_ori].to_i}"])
          if params[:ubicacion1][:convenio].to_i > 0 and params[:ubicacion1][:conveniosresolucion].to_i > 0
            ActiveRecord::Base.connection.execute("update mejoramientos set user_profesional = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_profesional = #{params[:ubicacion][:user_ori].to_i}
                                                  and    convenio_id = #{params[:ubicacion1][:convenio].to_i}
                                                  and    resolucion_id = (select resolucion_id from conveniosresoluciones where id = #{params[:ubicacion1][:conveniosresolucion].to_i})")
            ActiveRecord::Base.connection.execute("update conveniosresoluciones set user_profesional = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_profesional = #{params[:ubicacion][:user_ori].to_i}
                                                  and    convenio_id = #{params[:ubicacion1][:convenio].to_i}
                                                  and    resolucion_id = (select resolucion_id from conveniosresoluciones where id = #{params[:ubicacion1][:conveniosresolucion].to_i})")
          else
            ActiveRecord::Base.connection.execute("update mejoramientos set user_profesional = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_profesional = #{params[:ubicacion][:user_ori].to_i}")
            ActiveRecord::Base.connection.execute("update conveniosresoluciones set user_profesional = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_profesional = #{params[:ubicacion][:user_ori].to_i}")
          end
          flash[:notice] = "Se realizaron las actualizaciones de PROFESIONAL en los Mejoramientos y en el Convenio"
          redirect_to mejoramientos_path
        else
          flash[:warning] = "El PROFESIONAL seleccionado no tiene Mejoramientos asignados"
          redirect_to mejoramientos_path
        end
      elsif params[:ubicacion][:clase].to_s == "TECNOLOGO"
        if Mejoramiento.exists?(["user_tecnologo = #{params[:ubicacion][:user_ori].to_i}"])
          if params[:ubicacion1][:convenio].to_i > 0 and params[:ubicacion1][:conveniosresolucion].to_i > 0
            ActiveRecord::Base.connection.execute("update mejoramientos set user_tecnologo = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_tecnologo = #{params[:ubicacion][:user_ori].to_i}
                                                  and    convenio_id = #{params[:ubicacion1][:convenio].to_i}
                                                  and    resolucion_id = (select resolucion_id from conveniosresoluciones where id = #{params[:ubicacion1][:conveniosresolucion].to_i})")
            ActiveRecord::Base.connection.execute("update conveniosresoluciones set user_tecnologo = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_tecnologo = #{params[:ubicacion][:user_ori].to_i}
                                                  and    convenio_id = #{params[:ubicacion1][:convenio].to_i}
                                                  and    resolucion_id = (select resolucion_id from conveniosresoluciones where id = #{params[:ubicacion1][:conveniosresolucion].to_i})")
          else
            ActiveRecord::Base.connection.execute("update mejoramientos set user_tecnologo = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_tecnologo = #{params[:ubicacion][:user_ori].to_i}")
            ActiveRecord::Base.connection.execute("update conveniosresoluciones set user_tecnologo = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_tecnologo = #{params[:ubicacion][:user_ori].to_i}")
          end
          flash[:notice] = "Se realizaron las actualizaciones de TECNOLOGO en los Mejoramientos y en el Convenio"
          redirect_to mejoramientos_path
        else
          flash[:warning] = "El TECNOLOGO seleccionado no tiene Mejoramientos asignados"
          redirect_to mejoramientos_path
        end
      elsif params[:ubicacion][:clase].to_s == "COORDINADOR ISVIMED"
        if Mejoramiento.exists?(["user_interventor = #{params[:ubicacion][:user_ori].to_i}"])
          if params[:ubicacion1][:convenio].to_i > 0 and params[:ubicacion1][:conveniosresolucion].to_i > 0
            ActiveRecord::Base.connection.execute("update mejoramientos set user_interventor = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_interventor = #{params[:ubicacion][:user_ori].to_i}
                                                  and    convenio_id = #{params[:ubicacion1][:convenio].to_i}
                                                  and    resolucion_id = (select resolucion_id from conveniosresoluciones where id = #{params[:ubicacion1][:conveniosresolucion].to_i})")
            ActiveRecord::Base.connection.execute("update conveniosresoluciones set user_interventor = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_interventor = #{params[:ubicacion][:user_ori].to_i}
                                                  and    convenio_id = #{params[:ubicacion1][:convenio].to_i}
                                                  and    resolucion_id = (select resolucion_id from conveniosresoluciones where id = #{params[:ubicacion1][:conveniosresolucion].to_i})")
          else
            ActiveRecord::Base.connection.execute("update mejoramientos set user_interventor = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_interventor = #{params[:ubicacion][:user_ori].to_i}")
            ActiveRecord::Base.connection.execute("update conveniosresoluciones set user_interventor = #{params[:ubicacion][:user_new].to_i}
                                                  where  user_interventor = #{params[:ubicacion][:user_ori].to_i}")
          end
          flash[:notice] = "Se realizaron las actualizaciones de COORDINADOR ISVIMED en los Mejoramientos y en el Convenio"
          redirect_to mejoramientos_path
        else
          flash[:warning] = "El COORDINADOR ISVIMED seleccionado no tiene Mejoramientos asignados"
          redirect_to mejoramientos_path
        end
      end
    end
  end

  def cambioresol
#    logger.error("convenio_ori "+ params[:ubicacion11][:convenio].to_s)
#    logger.error("resol_ori "+ params[:ubicacion11][:conveniosresolucion].to_s)
#    logger.error("convenio_new "+ params[:ubicacion12][:convenio].to_s)
#    logger.error("resol_new "+ params[:ubicacion12][:conveniosresolucion].to_s)
    @convenioori = params[:ubicacion11][:convenio].to_i
    @resolori = Conveniosresolucion.find(params[:ubicacion11][:conveniosresolucion]).resolucion_id rescue nil
    @convenionew  = params[:ubicacion12][:convenio].to_i
    @resolnew = Conveniosresolucion.find(params[:ubicacion12][:conveniosresolucion]).resolucion_id rescue nil
    if @convenioori.to_i > 0 and @resolori.to_i > 0 and @convenionew.to_i > 0 and @resolnew.to_i > 0
      if @resolori.to_i != @resolnew.to_i
        ActiveRecord::Base.connection.execute("begin prc_cambiomejoramiento(#{@convenioori.to_i},#{@resolori.to_i},#{@convenionew.to_i},#{@resolnew.to_i}); end;")
        flash[:notice] = "Cambio realizado"
        redirect_to mejoramientos_path
      else
        flash[:warning] = "Las resoluciones son Iguales. Verifique!!!!"
        redirect_to mejoramientos_path
      end
    end
  end

  def informefinanciero
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Mejorafinanciero_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informemejorafinanciero; end;")
    @objetos = Objeto.find_by_sql(["select distinct porcentaje from mejoramientospagos where porcentaje is not null group by porcentaje order by porcentaje"])
    @mejoramientos = Mejoramiento.find_by_sql("select * from informesmejofinanciero order by convenio_id, resolucion_id")
  end

  def informepersonal
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Mejorapersonal_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informepersonal; end;")
    @mejoramientos = Mejoramiento.find_by_sql("select * from informespersonal order by convenio_id, resolucion_id")
  end

  def informecomuna
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_MejoraComuna_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informecomuna; end;")
    @mejoramientos = Mejoramiento.find_by_sql("select * from informespersonal order by convenio_id, resolucion_id")
  end

  def informeconcepto
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Mejoraconcepto_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informeconcepto; end;")
    @mejoramientos = Mejoramiento.find_by_sql("select * from informesconcepto order by convenio_id, resolucion_id")
  end

  def informeactualizacion
    fch1 = params[:ubicacion][:fchinicial].to_s
    fch2 = params[:ubicacion][:fchfinal].to_s
    usr = params[:ubicacion][:usuario].to_i
    tipo = params[:ubicacion][:tipo].to_s
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Mejoractualizacion_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informemejoraact('#{fch1.to_date}','#{fch2.to_date}',#{usr},'#{tipo}'); end;")
    @mejoramientosactualizaciones = Mejoramientosactualizacion.find_by_sql("select * from informemejoraact")
  end

  def informeoperador
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Mejoraestados_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informemejora; end;")
    @mejoramientos = Mejoramiento.find_by_sql("select * from informesmejoramiento order by convenio_id, resolucion_id")
  end

  def informeseguimiento
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Seguimiento_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    #ActiveRecord::Base.connection.execute("begin prc_informeseguimiento; end;")
    ActiveRecord::Base.connection.execute("begin prc_informesegcatastro; end;")
    @mejoramientos = Mejoramiento.find_by_sql("select * from informeseguimiento")
  end

  def informesactividad
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Actividades_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informeactividades; end;")
    @mejoramientos = Mejoramiento.find_by_sql("select * from informeactividades")
  end

  def ajustedecimal
    @convenioori = params[:ubicacion111][:convenio].to_i
    @resolori = Conveniosresolucion.find(params[:ubicacion111][:conveniosresolucion]).resolucion_id rescue nil
    if @convenioori.to_i > 0 and @resolori.to_i > 0
      ActiveRecord::Base.connection.execute("begin prc_mejoramientoajustes(#{is_admin},#{@resolori.to_i},#{@convenioori.to_i}); end;")
      flash[:notice] = "Ajuste decimales realizado con exito"
      redirect_to mejoramientos_path
    end
  end

  def informetipomejoramiento
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_TipoMejoramiento_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @mejoramientos = Mejoramiento.find_by_sql("select distinct tipomejoramiento, count(9) cant from mejoramientos group by tipomejoramiento")
    @mejoramientosa = Mejoramiento.find_by_sql("select distinct m.tipomejoramiento,c.nro_convenio, c.vigencia,  count(9) cant
                                                from mejoramientos m, convenios c
                                                where m.convenio_id = c.id
                                                group by m.tipomejoramiento,c.nro_convenio, c.vigencia
                                                order by m.tipomejoramiento")
    @mejoramientosb = Mejoramiento.find_by_sql("select distinct m.tipomejoramiento,c.nro_convenio, c.vigencia,e.descripcion, count(9) cant , sum(m.valor_resolucion) total
                                                from mejoramientos m, convenios c, mejoramientosestados e
                                                where m.convenio_id = c.id
                                                and   m.mejoramientosestado_id = e.id
                                                group by m.tipomejoramiento,c.nro_convenio, c.vigencia,e.descripcion
                                                order by m.tipomejoramiento,c.nro_convenio")
  end

  def create
     @mejoramiento = Mejoramiento.new(params[:mejoramiento])
     @mejoramiento.user_id = is_admin
     if @mejoramiento.save
       flash[:notice] = "mejoramiento Creado con Exito."
       redirect_to edit_mejoramiento_path(@mejoramiento)
     else
       @mejoramientosinterventoria = Mejoramientosinterventoria.new
       @mejoramientoselemento = Mejoramientoselemento.new
       @mejoramientosimagen = Mejoramientosimagen.new
       @mejoramientosconcepto = Mejoramientosconcepto.new
       @mejoramientosnota = Mejoramientosnota.new
       @mejoramientospago = Mejoramientospago.new
       @mejoramientosobra = Mejoramientosobra.new
       @mejoramientoslista = Mejoramientoslista.new
       flash[:warning] = "Problemas con la creacion del registro."
       render :action => "mejoramiento_form"
      end
  end

 def informe
   @mejoramiento = Mejoramiento.find(params[:id])
 end

 def informefotografia
   @mejoramiento = Mejoramiento.find(params[:id])
 end

 def edit
  if params[:etapa].to_s != ""
    ActiveRecord::Base.connection.execute("update mejoramientos set etapa = '#{params[:etapa]}' where id = #{params[:id].to_i}")
  end    
  @mejoramiento = Mejoramiento.find(params[:id])
  if @mejoramiento.etapa.to_s == "1"
    @mejoramientosconcepto = Mejoramientosconcepto.new  
  elsif @mejoramiento.etapa.to_s == "2"
    @mejoramientosinterventoria = Mejoramientosinterventoria.new
  elsif @mejoramiento.etapa.to_s == "3"
    @mejoramientoselemento = Mejoramientoselemento.new
  elsif @mejoramiento.etapa.to_s == "4"
    @mejoramientosimagen = Mejoramientosimagen.new
  elsif @mejoramiento.etapa.to_s == "5"
    @mejoramientosnota = Mejoramientosnota.new    
  elsif @mejoramiento.etapa.to_s == "6"
    @mejoramientospago = Mejoramientospago.new
  elsif @mejoramiento.etapa.to_s == "7"
    @mejoramientosobra = Mejoramientosobra.new
  elsif @mejoramiento.etapa.to_s == "8"
    @mejoramientoslista = Mejoramientoslista.new
  end
  respond_to do |format|
   format.html { render :action => "mejoramiento_form" }
  end
 end

 def update
   @mejoramiento = Mejoramiento.find(params[:id])
   params[:mejoramiento][:user_actualiza] = is_admin
   if @mejoramiento.update_attributes(params[:mejoramiento])
     is_trigger_mej(@mejoramiento.id,is_admin,'mejoramiento','A')
     flash[:notice] = "Mejoramiento actualizado correctamente."
     redirect_to edit_mejoramiento_path(@mejoramiento)
   else
     #@mejoramientosinterventoria = Mejoramientosinterventoria.new
     #@mejoramientoselemento = Mejoramientoselemento.new
     #@mejoramientosimagen = Mejoramientosimagen.new
     #@mejoramientosconcepto = Mejoramientosconcepto.new
     #@mejoramientosnota = Mejoramientosnota.new
     #@mejoramientospago = Mejoramientospago.new
     #@mejoramientosobra = Mejoramientosobra.new
     #@mejoramientoslista = Mejoramientoslista.new
     render :action => "mejoramiento_form"
   end
   rescue
     flash[:warning] = "Error general contacte al administador!"
     redirect_to edit_mejoramiento_path(@mejoramiento)
 end

  def cambioestado
    @convenioori = params[:convenio_id].to_i
    @estadonew   = params[:ubicacion][:mejoramientosestadonew].to_i
    @resolori    = params[:resolucion_id].to_i
    @mejorainformeid    = params[:mejorainforme_id].to_i
    if @convenioori.to_i > 0 and @resolori.to_i > 0 and @estadonew.to_i > 0 and @mejorainformeid.to_i > 0
      ActiveRecord::Base.connection.execute("begin prc_mejoramientoscambios(#{is_admin},#{@resolori.to_i},#{@convenioori.to_i},#{@mejorainformeid.to_i},#{@estadonew.to_i}); end;")
      flash[:notice] = "Cambio de estados realizado con exito"
      redirect_to mejoramientos_path
    else
      flash[:warning] = "No hay datos suficientes para la generación del cambio de estado, debe registrar todos los datos. Verifique!!!!"
      redirect_to mejoramientos_path
    end
  end

 def destroy
   @mejoramiento = Mejoramiento.find(params[:id])
   @mejoramiento.destroy
   respond_to do |format|
     format.html { redirect_to mejoramientos_path }
     format.xml  { head :ok }
   end
 end

  private
  def determine_layout
    if ['informe','informefotografia'].include?(action_name)
      "atencion"
    elsif['informetipomejoramiento','informesactividad','informeoperador','informefinanciero','informeactualizacion','informepersonal','informecomuna','informeconcepto','informeseguimiento'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end


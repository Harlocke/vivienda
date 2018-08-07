class SubtemporalesController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  require 'csv'

  def subsidios
    ActiveRecord::Base.connection.execute("begin prc_subsidionacional(#{is_admin}); end;")
    flash[:notice] = 'Proceso finalizado...'
    redirect_to subtemporales_path
  end

  def cargar
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
#        @ctl  = "C:\\RailsApp\\vivienda\\public\\archivos\\subtemporales.ctl"
#        @log  = "C:\\RailsApp\\vivienda\\public\\archivos\\logsubtemporales.lst"
#        @usr  = Sifi.find(1).valor.to_s
#        @ruta = "C:\\RailsApp\\vivienda\\public\\archivos\\"+name.to_s
      ActiveRecord::Base.connection.execute("truncate table subtemporales")
#        logger.error(" C:\\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\bin\\sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
#        system (" C:\\oraclexe\\app\\oracle\\product\\11.2.0\\server\\bin\\sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
      system ("sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
      ActiveRecord::Base.connection.execute("begin prc_validacargue; end;")
      @subtemporales = Subtemporal.find(:all)
      if @subtemporales.count.to_i > 0
        flash[:temporal] = 'Archivo Cargado con Exito...'
      else
        flash[:temporalerror] = 'Error: El archivo no tiene informacion validad, pulse <a href="../subtemporales">Aqui</a> para regresar'
      end
    else
        flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../subtemporales">Aqui</a> para regresar'
    end
  end

  def index

  end

  private
  def determine_layout
    if ['cargar','index'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

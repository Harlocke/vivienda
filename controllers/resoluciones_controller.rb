class ResolucionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  require 'ruby_plsql'
  require 'find'

  def uploadfile
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
        nombre2 = nombre2.gsub(".PDF","")
        d1,d2,d3,d4,d5 = nombre2.strip.split(" ")
        if Resolucion.exists?(["nro_resolucion = '#{d1.to_i}' and anno = '#{d5.to_s}'"]) == true
          resolucion = Resolucion.find(:first, :conditions=>["nro_resolucion = '#{d1.to_i}' and anno = '#{d5.to_s}'"])
          if resolucion
            resolucionesimagen = Resolucionesimagen.new
            resolucionesimagen.resolucion_id  = resolucion.id
            resolucionesimagen.descripcion = namefile.to_s
            resolucionesimagen.resolucion = file
            resolucionesimagen.user_id = is_admin
            resolucionesimagen.save
            file.close
            File.delete(path)
          end
        end
        # si la ruta es un directorio -> D
      end
    end
    flash[:notice] = "Archivos cargados con Exito...."
    redirect_to resoluciones_path
  end

  def index

  end

  def show
    @resolucion = Resolucion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resolucion }
    end
  end

  def new
    @resolucion = Resolucion.new
    @resolucion.etapa = "1"
    if permiso("resolucionesinicial","C").to_s == 'S'
      @resolucion.fecha = Time.now
    end
    render :action => "resolucion_form"
  end

  def buscarbeneficiario
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="Resolucionbenefi_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @resolucionespersonas = Resolucionespersona.find_by_sql("select p.resolucion_id, p.persona_id
                                                             from   resoluciones r, resolucionespersonas p
                                                             where  r.fecha between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}'
                                                             and    r.id = p.resolucion_id")
    respond_to do |format|
       format.xls
    end
  end

  def buscar
    perpage = 0
    if params[:format] == 'xls'
      perpage = 10000
    else
      perpage = 15
    end    
    @resolucion = Resolucion.new
    @resolucion.nro_resolucion = params[:nro_resolucion]
    @resolucion.anno = params[:ubicacion][:anno]
    @resolucion.modalidad = params[:ubicacion][:modalidad]
    @resolucion.resolucionesclase_id = params[:ubicacion][:resolucionesclase_id]
    @resolucion.user_id = params[:ubicacion][:user_id]
    @resoluciones = Resolucion.search(@resolucion,
                                      params[:identificacion],
                                      params[:ubicacion][:fchinicial],
                                      params[:ubicacion][:fchfinal],params[:page],perpage)
    if @resoluciones.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to resoluciones_path
    elsif params[:format] != 'xls'
      if @resoluciones.count == 1
        redirect_to edit_resolucion_path(:id=>@resoluciones, :etapa=>'1')
      else
        respond_to do |format|
           format.html
        end
      end
    elsif params[:format] == 'xls'
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Resoluciones_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Consolidado_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informeresolucion; end;")
    @cresoluciones = Resolucion.find_by_sql("select * from informecresoluciones order by anno desc, descripcion")
    @resoluciones  = Resolucion.find_by_sql("select * from informeresoluciones order by anno desc, descripcion")
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update resoluciones set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    if params[:page].to_s != ""
      ActiveRecord::Base.connection.execute("update resoluciones set pag = '#{params[:page].to_i}' where id = #{params[:id]}")
    else
      ActiveRecord::Base.connection.execute("update resoluciones set pag = '1' where id = #{params[:id]}")      
    end
    @resolucion = Resolucion.find(params[:id])
    if @resolucion.etapa.to_s == "2"
      @resolucionespersona = Resolucionespersona.new
    elsif @resolucion.etapa.to_s == "4"
      @resolucionesimagen = Resolucionesimagen.new
    elsif @resolucion.etapa.to_s == "3"
      @resolucionescontratista = Resolucionescontratista.new
    end
    respond_to do |format|
      format.html { render :action => "resolucion_form" }
    end
  end

  def create
    fecha = Time.now
    anno1 = fecha.strftime("%Y")
    @resolucion = Resolucion.new(params[:resolucion])
    @resolucion.nro_resolucion = is_nextresolucion
    @resolucion.anno = anno1
    @resolucion.user_reg = is_admin
    @resolucion.etapa = '1'
    if permiso("resolucionesinicial","C").to_s == 'S'
      @resolucion.fecha = Time.now
    end
    if @resolucion.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_resolucion_path(@resolucion)
    else
      render :action => "resolucion_form"
    end
  end

  def update
    @resolucion = Resolucion.find(params[:id])
    params[:resolucion][:user_regact] = is_admin
    if @resolucion.update_attributes(params[:resolucion])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_resolucion_path(@resolucion)
    else
      if @resolucion.etapa.to_s == "2"
        @resolucionespersona = Resolucionespersona.new
      elsif @resolucion.etapa.to_s == "4"
        @resolucionesimagen = Resolucionesimagen.new
      elsif @resolucion.etapa.to_s == "3"
        @resolucionescontratista = Resolucionescontratista.new
      end
      render :action => "resolucion_form"
    end
    rescue
      redirect_to edit_resolucion_path(@resolucion)
  end

  def destroy
    @resolucion = Resolucion.find(params[:id])
    @resolucion.destroy
    respond_to do |format|
      format.html { redirect_to(resoluciones_url) }
      format.xml  { head :ok }
    end
  end

  def cargarresol
    rutaupload = Sifi.find(24).valor.to_s
    @anno = params[:ubicacion][:anno].to_s
    if @anno != ""
      Find.find(rutaupload) do |f|
        type = case
        when File.file?(f) then "F"
          file   = File.open(f, 'rb')
          path   = File.join(rutaupload, File.basename(f).to_s)
          nombre2 = File.basename(f).to_s
          namefile = File.basename(f).to_s
          nombre2 = nombre2.gsub(".pdf","")
          nombre2 = nombre2.gsub(".PDF","")
          if Resolucion.exists?(["nro_resolucion = '#{nombre2.to_s}' and anno = '#{@anno}'"]) == true
            resol = Resolucion.find(:first, :conditions=>["nro_resolucion = '#{nombre2.to_s}' and anno = '#{@anno}'"])
            if resol
              resolucionesimagen = Resolucionesimagen.new
              resolucionesimagen.resolucion_id  = resol.id
              resolucionesimagen.descripcion = 'RESOLUCION NRO. ' + nombre2.to_s + ' DEL AÑO ' +  @anno.to_s
              resolucionesimagen.resolucion = file
              resolucionesimagen.user_id = is_admin
              resolucionesimagen.save
              file.close
              File.delete(path)
            end
          else
            logger.error("Error .." + nombre2.to_s)
          end
            # si la ruta es un directorio -> D
        end
      end
    end
    flash[:notice] = "Archivos cargados y Carpetas Depuradas con Exito...."
    redirect_to resoluciones_path
  end

  private
  def determine_layout
    if ['informe'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

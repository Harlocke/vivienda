class SaneamientosController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  require 'ruby_plsql'
  require 'csv'
  require 'find'

  def uploadfile_ficha
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
        nombre2 = nombre2.gsub(".jpg","")
        nombre2 = nombre2.gsub(".JPG","")
        if Saneamiento.exists?(["nro_matricula = '#{nombre2.to_s}'"]) == true
          saneamiento = Saneamiento.find(:first, :conditions=>["nro_matricula = '#{nombre2.to_s}'"])
          if saneamiento
            saneamientosimagen = Saneamientosimagen.new
            saneamientosimagen.saneamiento_id  = saneamiento.id
            saneamientosimagen.descripcion = 'FICHA PREDIAL'
            saneamientosimagen.saneamiento = file
            saneamientosimagen.save
            saneamientosimagen.user_id = is_admin
            file.close
            File.delete(path)
          end
        else
          logger.error("Error .." + nombre2.to_s)
        end
          # si la ruta es un directorio -> D
      end
    end
    flash[:notice] = "Archivos cargados...."
    redirect_to saneamientos_path
  end

  def uploadfile_vur
    rutaupload = Sifi.find(24).valor.to_s
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        nombre2 = File.basename(f).to_s
        namefile = File.basename(f).to_s
        nombre2 = nombre2.gsub(".docx","")
        nombre2 = nombre2.gsub(".DOCX","")
        if Saneamiento.exists?(["nro_matricula = '#{nombre2.to_s}'"]) == true
          saneamiento = Saneamiento.find(:first, :conditions=>["nro_matricula = '#{nombre2.to_s}'"])
          if saneamiento
            saneamientosimagen = Saneamientosimagen.new
            saneamientosimagen.saneamiento_id  = saneamiento.id
            saneamientosimagen.descripcion = 'CERTIFICADO DE LA VUR'
            saneamientosimagen.saneamiento = file
            saneamientosimagen.save
            saneamientosimagen.user_id = is_admin
            file.close
            File.delete(path)
          end
        else
          logger.error("Error .." + nombre2.to_s)
        end
          # si la ruta es un directorio -> D
      end
    end
    flash[:notice] = "Archivos cargados...."
    redirect_to saneamientos_path
  end

  def index

  end

  def buscar
    @saneamiento  = Saneamiento.new
    @saneamiento.nro_matricula =  params[:nro_matricula]
    @saneamiento.comuna_id = params[:ubicacion][:comuna_id]
    @saneamiento.identificacion =  params[:identificacion]
    @saneamiento.cbml =  params[:cobama]
    @saneamiento.encargo_tramite = params[:ubicacion][:encargo_tramite]
    @saneamientos = Saneamiento.search(@saneamiento)
    if @saneamientos.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to saneamientos_path
    elsif params[:format] != 'xls'
      if @saneamientos.count == 1
        redirect_to edit_saneamiento_path(@saneamientos)
      else
        respond_to do |format|
          format.html
        end
      end
    else
      @formato = params[:format].to_s
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_Saneamientos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
    end
  end

  def informeconsolidado
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_InveConsolidado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @saneamientos = Saneamiento.find_by_sql(["select encargo_tramite, count(9) cant from saneamientos group by encargo_tramite"])
  end

  def informeconsolidado2
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_InveConsolidado2_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @saneamientos = Saneamiento.find_by_sql(["select comuna_id,encargo_tramite, count(9) cant from saneamientos group by comuna_id, encargo_tramite order by comuna_id, encargo_tramite "])
  end

  def informedetallado
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="SIFI_InveDetallado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @saneamientos = Saneamiento.find(:all, :order=>"id asc")
  end

  def listar
      @saneamientos = Saneamiento.find(:all, :conditions => [' identificacion = ?', "#{params[:search]}"])
      #@saneamientos = Saneamiento.find(:all, :conditions => [' autobuscar LIKE ?', "%#{params[:search]}%"])
  end

  def new
    @saneamiento = Saneamiento.new
    @saneamientosimagen = Saneamientosimagen.new
    @saneamientosnota = Saneamientosnota.new
    render :action => "saneamiento_form"
  end

  def edit
    @saneamiento = Saneamiento.find(params[:id])
    @saneamientosimagen = Saneamientosimagen.new
    @saneamientosnota = Saneamientosnota.new
    if @saneamiento.correspondenciasenviada_id
      @correspondenciasenviada = Correspondenciasenviada.find(@saneamiento.correspondenciasenviada_id)
    end
    if @saneamiento.correspondenciasrecibida_id
      @correspondenciasrecibida = Correspondenciasrecibida.find(@saneamiento.correspondenciasrecibida_id)
    end
    respond_to do |format|
      format.html { render :action => "saneamiento_form" }
    end
  end

  def create
    @saneamiento = Saneamiento.new(params[:saneamiento])
    if @saneamiento.radicado_s.to_s != "" and @saneamiento.fecha_s.to_s != ""
      if Correspondenciasenviada.exists?(["nro_radicado = '#{@saneamiento.radicado_s}' and to_char(created_at,'dd-mm-YYYY') = '#{@saneamiento.fecha_s.to_date.strftime("%d-%m-%Y")}'"]) == true
        @saneamiento.correspondenciasenviada_id = Correspondenciasenviada.find(:first, :conditions=>["nro_radicado = '#{@saneamiento.radicado_s}' and to_char(created_at,'dd-mm-YYYY') = '#{@saneamiento.fecha_s.to_date.strftime("%d-%m-%Y")}'"]).id
      end
    end
    if @saneamiento.radicado_e.to_s != "" and @saneamiento.fecha_e.to_s != ""
      if Correspondenciasrecibida.exists?(["nro_radicado = '#{@saneamiento.radicado_e}' and to_char(created_at,'dd-mm-YYYY') = '#{@saneamiento.fecha_e.to_date.strftime("%d-%m-%Y")}'"]) == true
        @saneamiento.correspondenciasrecibida_id = Correspondenciasrecibida.find(:first, :conditions=>["nro_radicado = '#{@saneamiento.radicado_e}' and to_char(created_at,'dd-mm-YYYY') = '#{@saneamiento.fecha_e.to_date.strftime("%d-%m-%Y")}'"]).id
      end
    end
    @saneamiento.user_id = is_admin
    if @saneamiento.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_saneamiento_path(@saneamiento)
    else
      @saneamientosimagen = Saneamientosimagen.new
      @saneamientosnota = Saneamientosnota.new
      render :action => "saneamiento_form"
     end
  end

  def update
    @saneamiento = Saneamiento.find(params[:id])
    if params[:saneamiento][:radicado_s].to_s != "" and params[:saneamiento][:fecha_s].to_s != ""
      if Correspondenciasenviada.exists?(["nro_radicado = '#{params[:saneamiento][:radicado_s].to_s}' and to_char(created_at,'dd-mm-YYYY') = '#{params[:saneamiento][:fecha_s].to_date.strftime("%d-%m-%Y")}'"]) == true
        params[:saneamiento][:correspondenciasenviada_id] = Correspondenciasenviada.find(:first, :conditions=>["nro_radicado = '#{params[:saneamiento][:radicado_s]}' and to_char(created_at,'dd-mm-YYYY') = '#{params[:saneamiento][:fecha_s].to_date.strftime("%d-%m-%Y")}'"]).id
      else
        params[:saneamiento][:correspondenciasenviada_id] = nil
      end
    end
    if params[:saneamiento][:radicado_e].to_s != "" and params[:saneamiento][:fecha_e].to_s != ""
      if Correspondenciasrecibida.exists?(["nro_radicado = '#{params[:saneamiento][:radicado_e].to_s}' and to_char(created_at,'dd-mm-YYYY') = '#{params[:saneamiento][:fecha_e].to_date.strftime("%d-%m-%Y")}'"])
        params[:saneamiento][:correspondenciasrecibida_id] = Correspondenciasrecibida.find(:first, :conditions=>["nro_radicado = '#{params[:saneamiento][:radicado_e].to_s}' and to_char(created_at,'dd-mm-YYYY') = '#{params[:saneamiento][:fecha_e].to_date.strftime("%d-%m-%Y")}'"]).id
      else
        params[:saneamiento][:correspondenciasrecibida_id] = nil
      end
    end
    params[:saneamiento][:user_actualiza] = is_admin
    if @saneamiento.update_attributes(params[:saneamiento])
     flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_saneamiento_path(@saneamiento)
    else
      @saneamientosimagen = Saneamientosimagen.new
      @saneamientosnota = Saneamientosnota.new
      render :action => "saneamiento_form"
    end
  end

  def destroy
    @saneamiento = Saneamiento.find(params[:id])
    @saneamiento.destroy
    respond_to do |format|
      format.html { redirect_to(saneamientos_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['visualizar'].include?(action_name)
      "atencion"
    elsif['informeconsolidado','informedetallado','informeconsolidado2'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

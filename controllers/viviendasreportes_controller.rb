class ViviendasreportesController < ApplicationController

  layout :determine_layout
  before_filter :require_user
  require 'csv'

  def informesifi
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Cruce_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendasreportes = Viviendasreporte.find(:all, :conditions =>['user_id is null'], :order=>"persona_id asc")
  end

  def informesifiresoluciones
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Resoluciones'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendasreportes = Viviendasreporte.find(:all, :conditions =>['user_id is null'], :order=>"persona_id asc")
  end

  def informesifigrupo
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Crucegrupo_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendasreportes = Viviendasreporte.find(:all, :conditions =>['user_id is null'], :order=>"persona_id asc")
  end

  def informesdatos
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_informesdatos_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendasreportes = Viviendasreporte.find(:all, :conditions =>['user_id is null'], :order=>"persona_id asc")
  end

  def csv_importnew
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/temporal/"
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
        f = File.open(path, "wb")
        f.write(archivo.read)
        f.close
        @archivoGuardado = true
        @ruta = Parametro.find(4).valor.to_s+name.to_s
        ActiveRecord::Base.connection.execute("truncate table viviendasreportestmp")
        ActiveRecord::Base.connection.execute("delete from viviendasreportes where user_id is null")
        ActiveRecord::Base.connection.execute(
        "LOAD DATA LOCAL INFILE '#{@ruta}'
        INTO TABLE viviendasreportestmp
        FIELDS TERMINATED BY ';'
        LINES TERMINATED BY '#{'\n'}'
        (identificacion);")
        ActiveRecord::Base.connection.execute("insert into viviendasreportes (id, identificacion)
                                               select viviendasreportes_seq.nextval, identificacion
                                               from   viviendasreportestmp;")
        ActiveRecord::Base.connection.execute("update viviendasreportes set persona_id = (select id from personas
                                               where identificacion = viviendasreportes.identificacion);")
        ActiveRecord::Base.connection.execute("update viviendasreportes set vivienda_id = (select vivienda_id from viviendaspersonas
                                               where persona_id = viviendasreportes.persona_id)
                                               where persona_id is not null;")
    end
    @viviendasreportes = Viviendasreporte.find(:all, :conditions =>['user_id is null'])
    flash.now[:notice]="Archivo importado con Exito,  #{n} registros cargados"
  end

  def csv_import
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
      # crear el archivo
      File.open(path, "wb") { |f| f.write(archivo.read) }
      @archivoGuardado = true
      @ctl  = Sifi.find(2).valor.to_s+'viviendasreportes.ctl'
      @log  = Sifi.find(2).valor.to_s+'logviviendasreportes.lst'
      @usr  = Sifi.find(1).valor.to_s
      @ruta = Sifi.find(2).valor.to_s+name.to_s
      ActiveRecord::Base.connection.execute("delete from viviendasreportes where user_id is null")
      system (" sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
      ActiveRecord::Base.connection.execute("begin prc_informesifi; end;")
      @viviendasreportes = Viviendasreporte.find(:all, :conditions =>['user_id is null'])
      flash.now[:notice]="Archivo importado con Exito, #{@viviendasreportes.count} registros cargados"
    else
      flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../cruces/import">Aqui</a> para regresar'
    end
  end

  def sinetapa
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_SinEtapa_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    ActiveRecord::Base.connection.execute("begin prc_informesinetapa; end;")
    @viviendastramites = Viviendastramite.find_by_sql(["select * from informesinetapa order by proyecto,bloque,apto"])
  end

  def cargar
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_Cargar_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendasreportes = Viviendasreporte.find(:all, :conditions =>['user_id is null'])
    respond_to do |format|
       format.xls
    end
  end

  def cargarviv
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_cargarviv_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendasreportes = Viviendasreporte.find(:all, :conditions =>['user_id is null'])
    respond_to do |format|
       format.xls
    end
  end

  def entregaescritura
    if is_admin == 10002
      @viviendasreportes = Viviendasreporte.find(:all, :conditions=>["user_id = #{is_admin}"], :order=>"id asc")
    else
      @viviendaspersona = Viviendaspersona.find(params[:id])
    end    
  end

  def entregacertificado
    @viviendaspersona = Viviendaspersona.find(params[:id])
  end

  def entregacertificado_masivo
  end

  def infocompleta
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_infocompleta_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @viviendasreportes = Viviendasreporte.find(:all, :conditions =>['user_id is null'])
    respond_to do |format|
       format.xls
    end
  end

  def entregasmasivo
    @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
  end

  def actasmasivas
    @viviendasreportes = Viviendasreporte.find(:all, :conditions=>["user_id = #{is_admin} and persona_id is not null"])
  end

  def actasmasivas_subsidios
    @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
  end

  def actasvg
    @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
  end


  def actasvg_mia
    @viviendasreportes = Viviendasreporte.find_by_sql("select * from tmp_per where ESCRITURA is not null")
  end

  def enviosmasivo
    @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
    @cantidad = @viviendasreportes.count
  end

  def cartasmasivo
    @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
    @viviendascarta = Viviendascarta.find(params[:ubicacion][:viviendascarta_id])
    @observaciones = params[:ubicacion][:observacion]
    @cantidad = @viviendasreportes.count
  end

  def add_viviendasreporte
    @viviendasreporte = Viviendasreporte.new(params[:viviendasreporte])
    @viviendasreporte.user_id = is_admin
    #@viviendasreporte.save
    if Viviendasreporte.exists?(["persona_id = ? and user_id = ?", @viviendasreporte.persona_id, is_admin]) == false
      if Viviendaspersona.exists?(["persona_id = ?", @viviendasreporte.persona_id]) == true
        valorsaldocierre = ""
        viviendaid = 0
        proyectoid = 0
        @viviendaspersonas = Viviendaspersona.find_all_by_persona_id(@viviendasreporte.persona_id)
        @viviendaspersonas.each do |viviendaspersona|
          @vivienda = Vivienda.find(viviendaspersona.vivienda_id)
          valorsaldocierre = @vivienda.saldocierrevivienda
          viviendaid = viviendaspersona.vivienda_id
          proyectoid = viviendaspersona.vivienda.proyecto_id
        end
        if Credito.exists?(["persona_id = ?", @viviendasreporte.persona_id]) == false
#          No tiene credito
#          Cierre financiero y la siguientes etapas activas o inactiva
#          RECEPCION ESCRITURA Y FACTURA NOTARIA ó en PROTOCOLIZACION DE LA ESCRITURA EN NOTARIA
           errorsaldo = "N"
           if valorsaldocierre.to_i == 0
             if Viviendastramite.exists?(["vivienda_id = ? and viviendastipostramite_id in (10103,10067)", viviendaid])
               respond_to do |format|
                  if @viviendasreporte.save
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  else
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  end
               end
             elsif Iguanaspersona.exists?(["persona_id = ?", @viviendasreporte.persona_id])
              #Verifica si esta en proyecto especial (IGUANA-MORAVIA)
              respond_to do |format|
                  if @viviendasreporte.save
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  else
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  end
               end
             elsif proyectoid.to_s == '29' or proyectoid.to_s == '19' or proyectoid.to_s == '36'
              #Verifica si esta en proyecto especial (Juan Bobo y la Herrera)
              respond_to do |format|
                  if @viviendasreporte.save
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  else
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  end
               end
             elsif Resolucionespersona.exists?(["persona_id = ? and resolucion_id in (select id from resoluciones where resolucionesclase_id = 10040)", @viviendasreporte.persona_id])
              #Verifica si la persona tiene resolucion de transferencia de inmueble
              respond_to do |format|
                  if @viviendasreporte.save
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  else
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  end
               end
             else
               errortramite = 'S'
             end
           else
             errorsaldo = 'S'
           end
           if errortramite == 'S'
             render :update do |page|
                page.alert "La identificación no tiene el tramite RECEPCION ESCRITURA Y FACTURA NOTARIA Registrado. Verifique!!"
             end
           end
           if errorsaldo == 'S'
             render :update do |page|
                page.alert "La identificación no tiene Cierre Financiero. Verifique!!"
             end
           end
        else
#         Cuando tiene credito..
#         PERSONAS CON CREDITO: Cierre financiero completo y etapa activa las siguientes.
#         - RECLAMAR ESCRITURAS Y ELABORAR OFICIO REMISORIO AL CONSTRUCTOR PARA LA DEVOLUCIÓN DEL IVA
#         - ENVIAR ESCRITURA  A LA FINANCIERA
#         - ENVIAR ESCRITURA PARA COBRO A LA FINANCIERA
           errorsaldo = "N"
           if valorsaldocierre.to_i == 0
             if Viviendastramite.exists?(["vivienda_id = ? and viviendastipostramite_id in (10075,10076,10106)", viviendaid])
               respond_to do |format|
                  if @viviendasreporte.save
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  else
                     @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
                     format.html { redirect_to viviendasreportes_path }
                     format.js
                  end
               end
             else
               errortramite = 'S'
             end
           else
             errorsaldo = 'S'
           end
           if errortramite == 'S'
             render :update do |page|
                page.alert "La identificación no tiene el tramite requerido para permitir la Asociación. Verifique!!"
             end
           end
           if errorsaldo == 'S'
             render :update do |page|
                page.alert "La identificación no tiene Cierre Financiero. Verifique!!"
             end
           end
        end
      else
        @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
        render :update do |page|
           page.alert "La identificación registrada no posee vivienda Asignada. Verifique!!"
        end
      end
    else
      @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
      render :update do |page|
         page.alert "La identificacion ya se encuentra registrada. Verifique!!"
      end
    end
  end

  def index
    #@viviendasreportes = Viviendasreporte.all
    @viviendasreportes = Viviendasreporte.find_all_by_user_id(is_admin)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @viviendasreportes }
    end
  end

  def show
    @viviendasreporte = Viviendasreporte.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @viviendasreporte }
    end
  end

  def new
    @viviendasreporte = Viviendasreporte.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viviendasreporte }
    end
  end

  def edit
    @viviendasreporte = Viviendasreporte.find(params[:id])
  end

  def create
    @viviendasreporte = Viviendasreporte.new(params[:viviendasreporte])
    respond_to do |format|
      if @viviendasreporte.save
        flash[:notice] = 'Viviendasreporte was successfully created.'
        format.html { redirect_to(@viviendasreporte) }
        format.xml  { render :xml => @viviendasreporte, :status => :created, :location => @viviendasreporte }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viviendasreporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @viviendasreporte = Viviendasreporte.find(params[:id])
    respond_to do |format|
      if @viviendasreporte.update_attributes(params[:viviendasreporte])
        flash[:notice] = 'Viviendasreporte was successfully updated.'
        format.html { redirect_to(@viviendasreporte) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @viviendasreporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @viviendasreporte = Viviendasreporte.find(params[:id])
    @viviendasreporte.destroy
    respond_to do |format|
      format.html { redirect_to(viviendasreportes_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['actasvg_mia','actasvg','entregasmasivo','actasmasivas','actasmasivas_subsidios','enviosmasivo','entregaescritura','entregacertificado','entregacertificado_masivo'].include?(action_name)
      "atencion"
    elsif ['cartasmasivo'].include?(action_name)
      "atencioncartas"
    elsif ['index','import','csv_import'].include?(action_name)
      "new2"
    elsif ['informesdatos','informesifi','informesifigrupo','informesifiresoluciones','infodatos'].include?(action_name)
      "excel"
    else
      "application"
    end
  end

end

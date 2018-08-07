class ElementosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    #@elementos = Elemento.find(:all)
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @elementos }
    #end
  end

  def show
    @elemento = Elemento.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @elemento }
    end
  end

  def inventario
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI_inventario_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @elementos = Elemento.all(:include => :tiposelemento, :order=>"tiposelementos.descripcion")
    #@elementos = Elemento.find(:all, :order=>"tiposelemento_id")
  end

  def intercambiointerventor
    if params[:ubicacion][:useractual_id].to_s != "" and params[:ubicacion][:usernuevo_id].to_s != ""
      if params[:ubicacion][:useractual_id].to_s != params[:ubicacion][:usernuevo_id].to_s
        cant = Elemento.count(:conditions => [" user_id = #{params[:ubicacion][:useractual_id]} "])
#        2013-01-30 Fabian.. este es el ideal pero se rompe por los validate_present
#        @elementos = Elemento.find_all_by_user_id(params[:ubicacion][:useractual_id])
#        @elementos.each do |ele|
#          elemento = Elemento.find(ele.id)
#          elemento.user_id = params[:ubicacion][:usernuevo_id]
#          elemento.save
#          cant = cant + 1
#        end
        ActiveRecord::Base.connection.execute("update elementos set user_id = #{params[:ubicacion][:usernuevo_id].to_i}
                                               where user_id = #{params[:ubicacion][:useractual_id]}")
        flash[:notice] = "Cambio de interventor realizado con exito. ("+cant.to_s+")"
        redirect_to elementos_path
      else
        flash[:notice] = "El interventor nuevo debe ser diferente al Actual. Verifique!!"
        redirect_to elementos_path
      end
    else
      flash[:notice] = "Debe indicar el interventor actual y el nuevo. Verifique!!"
      redirect_to elementos_path
    end
  end

  def intercambiousuario
    if params[:ubicacion][:useractual_id].to_s != "" and params[:ubicacion][:usernuevo_id].to_s != ""
      if params[:ubicacion][:useractual_id].to_s != params[:ubicacion][:usernuevo_id].to_s
        cant = 0
        @elementosusers = Elementosuser.find(:all, :conditions=>["user_id = #{params[:ubicacion][:useractual_id]} and fecha_fin is null"])
        @elementosusers.each do |elementosuser|
          @elementosuser = Elementosuser.new
          @elementosuser.elemento_id = elementosuser.elemento_id
          @elementosuser.user_id = params[:ubicacion][:usernuevo_id].to_i
          @elementosuser.fecha_inicio = Time.now
          @elementosuser.save
          cant = cant + 1
        end
        flash[:notice] = "Cambio de usuario realizado con exito. ("+cant.to_s+")"
        redirect_to elementos_path
      else
        flash[:notice] = "El usuario nuevo debe ser diferente al Actual. Verifique!!"
        redirect_to elementos_path
      end
    else
      flash[:notice] = "Debe indicar el usuario actual y el nuevo. Verifique!!"
      redirect_to elementos_path
    end
  end

  def intercambiouserinter
    if params[:ubicacion][:useractual_id].to_s != "" and params[:ubicacion][:userinterve_id].to_s != ""
      if params[:ubicacion][:useractual_id].to_s != params[:ubicacion][:userinterve_id].to_s
        ActiveRecord::Base.connection.execute("update elementos set user_id = #{params[:ubicacion][:userinterve_id].to_i}
                                               where  id in (select elemento_id
                                                             from   elementosusers
                                                             where  user_id = #{params[:ubicacion][:useractual_id]}
                                                             and    fecha_fin is null")
        flash[:notice] = "Cambio de interventor realizado con exito."
        redirect_to elementos_path
      else
        flash[:notice] = "El interventor no puede ser el mismo usuario o si???. Verifique!!"
        redirect_to elementos_path
      end
    else
      flash[:notice] = "Debe indicar el usuario actual y el interventor nuevo. Verifique!!"
      redirect_to elementos_path
    end
  end

  def buscar
    @elementos = Elemento.search(params[:ubicacion][:tiposelemento_id],
                                 params[:marca],
                                 params[:referencia],
                                 params[:placa],
                                 params[:serial],
                                 params[:ubicacion][:user_id],
                                 params[:ubicacion][:userfuncionario_id],
                                 params[:ubicacionele],
                                 params[:observacion])
    @iduser = params[:ubicacion][:user_id]
    @idfunuser = params[:ubicacion][:userfuncionario_id]
#    if @elementos.count == 0 and params[:format] != 'xls'
#      flash[:notice] = "No hay resultados de la busqueda"
#      redirect_to elementos_path
#    #elsif @elementos.count == 1 and params[:format] != 'xls'
#    #  redirect_to edit_elemento_path(@elementos)
#    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
#    end
  end

  def buscarsistemas
    @elementos = Elemento.searchsistemas(params[:id])
    @iduser = params[:id]
    @calidadversion = Calidadversion.find(2)
    respond_to do |format|
       format.html
    end
  end

  def descargue
    @elementos = Elemento.searchsistemas(params[:id])
    @iduser = params[:id]
    @calidadversion = Calidadversion.find(3)
    respond_to do |format|
       format.html
    end
  end

  def descarguefun
    @elementos = Elemento.find(:all, :conditions=>["user_id = #{params[:id]}"], :order=>"user_id")
    @idfunuser = params[:id]
    respond_to do |format|
       format.html
    end
  end

  def new
    @elemento = Elemento.new
    @elemento.etapa = '1'
    @tiposelementos = Tiposelemento.all
    render :action => "elemento_form"
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update elementos set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    @elemento = Elemento.find(params[:id])
    if @elemento.etapa.to_s == "2"
      @elementoscaracteristica = Elementoscaracteristica.new
    elsif @elemento.etapa.to_s == "3"
      @elementosmantenimiento = Elementosmantenimiento.new
    elsif @elemento.etapa.to_s == "4"
      @elementosuser = Elementosuser.new
    elsif @elemento.etapa.to_s == "5"
      @elementosotro = Elementosotro.new
    elsif @elemento.etapa.to_s == "6"
      @elementossoporte = Elementossoporte.new
    end
    #@tiposelementos = Tiposelemento.all
    respond_to do |format|
      format.html { render :action => "elemento_form" }
    end
  end

  def create
    @elemento = Elemento.new(params[:elemento])
    @elemento.placa = is_nextplaca
    if @elemento.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_elemento_path(@elemento)
    else
      #@tiposelementos = Tiposelemento.all
      render :action => "elemento_form"
    end
  end

  def update
    @elemento = Elemento.find(params[:id])
    @elemento.user_actualiza = is_admin
    if @elemento.update_attributes(params[:elemento])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_elemento_path(@elemento)
    else
      #@tiposelementos = Tiposelemento.all
      #@elementoscaracteristica = Elementoscaracteristica.new
      #@elementosmantenimiento = Elementosmantenimiento.new
      #@elementosuser = Elementosuser.new
      #@elementosotro = Elementosotro.new
      #@elementossoporte = Elementossoporte.new
      render :action => "elemento_form"
    end
    rescue
      redirect_to edit_elemento_path(@elemento)
  end

  def destroy
    @elemento = Elemento.find(params[:id])
    @elemento.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to elementos_path
        }
      format.xml  { head :ok }
    end
  end

  def debaja
    @elemento = Elemento.find(params[:id])
    @calidadversion = Calidadversion.find(4)
  end

  def debajamas
    @calidadversion = Calidadversion.find(4)
    @elementos = Elemento.find(:all, :conditions=>["placa in ('62','107','220','305','306','308','317','320','323','667','676','679','701','703','707','732','737','738','982','991','1006','1007','1008','1011','1013','1015','1018','1035','1044','1047','1048','1050','1051','1052','1077','1083','1154','1167','1178','1186','1192','1200','1205','1212','1214','1292','1316','1326','1413','1420','1428','1442','1450','1452','1460','1461','1466','1468','1475','1487','1492','1568','1589','1748','1875','1876','1877','1878','1879','1880','1881','1883','1884','1885','1886','1887','1888','1890','1891','1892','1893','2129','2130','2156','2157','2158','2163','2164','2177','2188','2189','2190','2477','2478','2479','2480','2689')"])
  end

  def uploadfile
    rutaupload = Sifi.find(24).valor.to_s
    Find.find(rutaupload) do |f|
      type = case
      when File.file?(f) then "F"
        file   = File.open(f, 'rb')
        path   = File.join(rutaupload, File.basename(f).to_s)
        nombre2 = File.basename(f).to_s
        nombre2 = nombre2.gsub(".JPG","")
        nombre2 = nombre2.gsub(".jpg","")
        if Elemento.exists?(["placa = '#{nombre2.to_s}'"]) == true
          elemento = Elemento.find(:first, :conditions=>["placa = '#{nombre2.to_s}'"])
          if elemento
            elementossoporte = Elementossoporte.new
            elementossoporte.elemento_id  = elemento.id
            elementossoporte.descripcion = 'CARGUE SOPORTE DIGITAL'
            elementossoporte.elesoporte = file
            elementossoporte.user_id = 10002
            elementossoporte.save
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
    redirect_to elementos_path
  end

  def camara
    
  end

  private
  def determine_layout
    if ['debajamas','debaja','buscarsistemas','descargue','descarguefun'].include?(action_name)
      "atencion"
    elsif['inventario'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

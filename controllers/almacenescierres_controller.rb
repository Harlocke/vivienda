class AlmacenescierresController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  require 'ruby_plsql'
  
  def index
    #@almacenescierres = Almacenescierre.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @almacenescierres }
    end
  end

#  def informe
#    if params[:ubicacion][:mes].to_s == "" or params[:ubicacion][:anno].to_s == ""
#      flash[:notice] = "No hay informacion para generar el proceso. Verifique!!!"
#      redirect_to reporte_almacenes_path
#    else
#      existeconsolidado = Almacenescierre.exists?(['anno = ? and mes = ? and estado = ?',  params[:ubicacion][:anno], params[:ubicacion][:mes], "C"])
#      if !existeconsolidado
#        @almacenescierres = Almacenescierre.informe(params[:ubicacion][:mes],params[:ubicacion][:anno])
#        @estado = "P"
#      else
#        @almacenescierres = Almacenescierre.find(:all, :conditions => ['anno = ? and mes = ? and estado = ?', params[:ubicacion][:anno], params[:ubicacion][:mes], "C"])
#        @estado = "C"
#      end
#      @mes  = params[:ubicacion][:mes]
#      @anno = params[:ubicacion][:anno]
#      @descmes = descmes(params[:ubicacion][:mes])
#      respond_to do |format|
#         format.html
#         format.xls if params[:format] == 'xls'
#      end
#    end
#  end

  def informe
    @error = ""
    if params[:ubicacion][:mes].to_s == "" or params[:ubicacion][:anno].to_s == ""  or params[:ubicacion][:tipo].to_s == ""
      flash[:notice] = "No hay informacion para generar el proceso. Verifique!!!"
      redirect_to reporte_almacenes_path
    else
      if params[:ubicacion][:tipo].to_s == "CONSOLIDADO"
        if Almacenescierre.exists?(["anno = #{params[:ubicacion][:anno]} and mes = #{params[:ubicacion][:mes]} and tipo = 'CONSOLIDADO'"]) == false
          ActiveRecord::Base.connection.execute("begin prc_almacencierre('#{params[:ubicacion][:mes]}','#{params[:ubicacion][:anno]}','#{params[:ubicacion][:tipo]}'); end;")
        end
      elsif params[:ubicacion][:tipo].to_s == "PRUEBA"
        if Almacenescierre.exists?(["anno = #{params[:ubicacion][:anno]} and mes = #{params[:ubicacion][:mes]} and tipo = 'CONSOLIDADO'"]) == true
          @error = "Ya se encuentra generado en consolidado"
        else
          ActiveRecord::Base.connection.execute("begin prc_almacencierre('#{params[:ubicacion][:mes]}','#{params[:ubicacion][:anno]}','#{params[:ubicacion][:tipo]}'); end;")
        end
      end
      if @error.to_s == ""
        #@usersmodulos = Usersmodulo.all(:include => :modulo, :conditions => { :modulos => { :tipo => nil }, :usersmodulos => {:user_id => is_admin}}, :order=>"modulos.mensaje")
        @objs = Objeto.find_by_sql(["select distinct tipo, decode(tipo,'2','ASEO','1','PAPELERIA','3','FERRETERIA') nombre from productos where tipo is not null order by tipo"])
        #@almacenes1cierres = Almacenescierre.all(:include => :producto, :conditions => { :productos => { :tipo => '1' }, :almacenescierres => {:anno => params[:ubicacion][:anno], :mes => params[:ubicacion][:mes], :tipo => params[:ubicacion][:tipo]}}, :order=>"productos.descripcion")
        #@almacenes2cierres = Almacenescierre.all(:include => :producto, :conditions => { :productos => { :tipo => '2' }, :almacenescierres => {:anno => params[:ubicacion][:anno], :mes => params[:ubicacion][:mes], :tipo => params[:ubicacion][:tipo]}}, :order=>"productos.descripcion")
        #@almacenes3cierres = Almacenescierre.all(:include => :producto, :conditions => { :productos => { :tipo => '3' }, :almacenescierres => {:anno => params[:ubicacion][:anno], :mes => params[:ubicacion][:mes], :tipo => params[:ubicacion][:tipo]}}, :order=>"productos.descripcion")
        @mes  = params[:ubicacion][:mes]
        @anno = params[:ubicacion][:anno]
        @tipo = params[:ubicacion][:tipo]
        @descmes = descmes(params[:ubicacion][:mes])
        if params[:ubicacion][:tipoinforme].to_s == "EXCEL"
          headers['Content-Type'] = "application/vnd.ms-excel"
          headers['Content-Disposition'] = 'attachment; filename="SIFI_info_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
          headers['Cache-Control'] = 'max-age=0'
          headers['pragma']="public"
          respond_to do |format|
            format.xls
          end            
        end
#        respond_to do |format|
#           format.html
#           format.xls if params[:format] == 'xls'
#       end
      else
        flash[:notice] = "El Mes solicitado ya se encuentra en consolidado. Verifique!!!"
        redirect_to reporte_almacenes_path
      end
    end
  end

  def informefecha
    if params[:ubicacion][:fecha].to_s == ""
      flash[:notice] = "No hay informacion para generar el proceso. Verifique!!!"
      redirect_to reporte_almacenes_path
    else
      ActiveRecord::Base.connection.execute("begin prc_almacencierrefecha('#{params[:ubicacion][:fecha]}'); end;")
      @fecha  = params[:ubicacion][:fecha]
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def informe2
    if params[:ubicacion][:usuario].to_s == ""
      flash[:notice] = "No hay informacion para generar el proceso. Verifique!!!"
      redirect_to reporte_almacenes_path
    else
      @almacenessalidas = Almacenessalida.find(:all, :conditions=>['user_id = ?', params[:ubicacion][:usuario]], :order =>['created_at desc'])
      @usuario = User.find(params[:ubicacion][:usuario]).nombre
    end
  end

  def informe3
    if params[:ubicacion][:dependencia].to_s == "" or params[:ubicacion][:mes].to_s == "" or params[:ubicacion][:anno].to_s == ""
      flash[:notice] = "No hay informacion para generar el proceso. Verifique!!!"
      redirect_to reporte_almacenes_path
    else
      valor = "'"
      @almacenessalidas = Almacenessalida.find(:all, :conditions=>['user_id in (select id from users where dependencia_id =? ) and  to_number(to_char(created_at,'+"#{valor}"+'yyyy'+"#{valor}"+')) = ? and  to_number(to_char(created_at,'+"#{valor}"+'mm'+"#{valor}"+')) = ?', params[:ubicacion][:dependencia],params[:ubicacion][:anno], params[:ubicacion][:mes]], :order =>['created_at desc'])
      @anno = params[:ubicacion][:anno]
      @mes = descmes(params[:ubicacion][:mes])
      @dependencia = Dependencia.find(params[:ubicacion][:dependencia]).descripcion
      @var1 = params[:ubicacion][:anno]
      @var2 = params[:ubicacion][:mes]
      @var3 = params[:ubicacion][:dependencia]
    end
  end

  def informe3imp
      valor = "'"
      @almacenessalidas = Almacenessalida.find(:all, :conditions=>['user_id in (select id from users where dependencia_id =? ) and  to_number(to_char(created_at,'+"#{valor}"+'yyyy'+"#{valor}"+')) = ? and  to_number(to_char(created_at,'+"#{valor}"+'mm'+"#{valor}"+')) = ?', params[:var3],params[:var1], params[:var2]], :order =>['created_at desc'])
      @anno = params[:var1]
      @mes = descmes(params[:var2])
      @dependencia = Dependencia.find(params[:var3]).descripcion
  end

  def consolida
    almacenescierres = Almacenescierre.find(:all, :conditions =>['anno = ? and mes = ?', params[:anno], params[:mes]])
    almacenescierres.each do |x|
      x.estado = 'C'
      x.save
    end
    flash[:notice] = 'Inventario Consolidado con Exito!.'
    redirect_to reporte_almacenes_path
  end

  def consultaimp
    @almacenescierres = Almacenescierre.find(:all, :conditions =>['anno = ? and mes = ?', params[:anno], params[:mes]])
    @estado  = params[:estado]
    @anno    = params[:anno]
    @descmes = descmes(params[:mes])
    respond_to do |format|
       format.html
    end
  end

  def informesalidas
    if params[:ubicacion][:usuario].to_s == "" or params[:ubicacion][:fchinicial].to_s == "" or params[:ubicacion][:fchfinal].to_s == ""
      flash[:notice] = "No hay informacion para generar el proceso. Verifique!!!"
      redirect_to reporte_almacenes_path
    else
      if  params[:ubicacion][:producto].to_s == ""
        @almacenessalidas = Almacenessalida.find(:all, :conditions=>["user_id = #{params[:ubicacion][:usuario].to_i} and trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}'"], :order =>['created_at desc'])
      else
        @almacenessalidas = Almacenessalida.find(:all, :conditions=>["user_id = #{params[:ubicacion][:usuario].to_i} and trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}' and producto_id = #{params[:ubicacion][:producto]}"], :order =>['created_at desc'])
      end
      @usuario = User.find(params[:ubicacion][:usuario]).nombre

      if params[:ubicacion][:tipoinforme].to_s == "EXCEL"
        headers['Content-Type'] = "application/vnd.ms-excel"
        headers['Content-Disposition'] = 'attachment; filename="SIFI_info_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"
        respond_to do |format|
          format.xls
        end            
      end

    end
  end

  # GET /almacenescierres/1
  # GET /almacenescierres/1.xml
  def show
    @almacenescierre = Almacenescierre.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @almacenescierre }
    end
  end

  # GET /almacenescierres/new
  # GET /almacenescierres/new.xml
  def new
    @almacenescierre = Almacenescierre.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @almacenescierre }
    end
  end

  # GET /almacenescierres/1/edit
  def edit
    @almacenescierre = Almacenescierre.find(params[:id])
  end

  # POST /almacenescierres
  # POST /almacenescierres.xml
  def create
    @almacenescierre = Almacenescierre.new(params[:almacenescierre])

    respond_to do |format|
      if @almacenescierre.save
        flash[:notice] = 'Almacenescierre was successfully created.'
        format.html { redirect_to(@almacenescierre) }
        format.xml  { render :xml => @almacenescierre, :status => :created, :location => @almacenescierre }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @almacenescierre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /almacenescierres/1
  # PUT /almacenescierres/1.xml
  def update
    @almacenescierre = Almacenescierre.find(params[:id])

    respond_to do |format|
      if @almacenescierre.update_attributes(params[:almacenescierre])
        flash[:notice] = 'Almacenescierre was successfully updated.'
        format.html { redirect_to(@almacenescierre) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @almacenescierre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /almacenescierres/1
  # DELETE /almacenescierres/1.xml
  def destroy
    @almacenescierre = Almacenescierre.find(params[:id])
    @almacenescierre.destroy

    respond_to do |format|
      format.html { redirect_to(almacenescierres_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['consultaimp','informe3imp','informe'].include?(action_name)
      "tirilla"
    else
      "application"
    end
  end
end

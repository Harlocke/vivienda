class EmpleadosController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  
  def index
    @empleados = Empleado.searchv(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @empleados }
    end
  end

  def show
    @empleado = Empleado.find(params[:id])
    @archivosempleados = Archivosempleado.find_all_by_empleado_id(@empleado.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @empleado }
    end
  end

  def certificado
    @empleado = Empleado.find(params[:id])
  end

  def certificadooblig
    @empleado = Empleado.find(params[:id])
  end

  def certificadomasivo
    @empleados = Empleado.find(:all, :conditions=>[" identificacion in (select identificacion from tmpc)"], :order=>"primer_nombre")
  end

  def interventoria
    @empleado = Empleado.find(params[:id])
  end

  def buscar
    @empleado  = Empleado.new
    @empleado.identificacion =  params[:identificacion]
    @empleado.nombre =  params[:nombre]
    @empleados = Empleado.search(@empleado,'C',params[:nro_contrato])
    if @empleados.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda " +@empleados.count.to_s
      redirect_to busqueda_empleados_path
    elsif @empleados.count == 1 and params[:format] != 'xls'
      redirect_to edit_empleado_path(:id => @empleados, :etapa=>"1")
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def reporteconsol
    @empleados = Empleado.find_all_by_tipo('C')
    respond_to do |format|
       format.xls
    end
  end

  def listar
      @empleados = Empleado.find(:all, :conditions => [' identificacion =  ?', "#{params[:search]}"])
      #@personas = Persona.find(:all, :conditions => [' autobuscar LIKE ?', "%#{params[:search]}%"])
  end

  def rango
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="Contratos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @empleados = Empleado.searchcontratos(params[:ubicacion][:fchinicial], params[:ubicacion][:fchfinal])
    @fchinicial = params[:ubicacion][:fchinicial]
    @fchfinal   = params[:ubicacion][:fchfinal]
    respond_to do |format|
       format.xls
    end
  end

  def informeinterventor
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="Contratosinterventor_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = ''
    @user = User.find(is_admin)
    if @user.directivo.to_s == 'S'
      @contratos = Contrato.find(:all, :conditions=>["interventorempleado_id in (select id 
          from empleados where user_id in (select id from users where dependencia_id = #{@user.dependencia_id}))"], :order=> "empleado_id")
    else
      @contratos = Contrato.find(:all, :conditions=>["interventorempleado_id in (select id from empleados where user_id = #{is_admin})"], :order=> "empleado_id")
    end
    respond_to do |format|
       format.xls
    end
  end

  def new
    tipoempleado = params[:tipo]
    @empleado = Empleado.new
    @empleado.tipo = tipoempleado
    @documentos = Documento.all
    @empleado.etapa = '1'
    render :action => "empleado_form"
  end

  def new2
    @empleado = Empleado.new
    @empleado.etapa = '1'
    @documentos = Documento.all
  end

  def edit
    if params[:etapa].to_s != ""
      ActiveRecord::Base.connection.execute("update empleados set etapa = '#{params[:etapa]}' where id = #{params[:id]}")
    end    
    @empleado = Empleado.find(params[:id])
    if @empleado.etapa.to_s == "1"
      @documentos = Documento.all
    elsif @empleado.etapa.to_s == "2"
      @contrato = Contrato.new
    elsif @empleado.etapa.to_s == "3"
      @contratosvinculado = Contratosvinculado.new
    elsif @empleado.etapa.to_s == "4"
      @contratosretefuente  = Contratosretefuente.new
    elsif @empleado.etapa.to_s == "5"
      @nominasnovedad = Nominasnovedad.new
    elsif @empleado.etapa.to_s == "6"
      @periodosliquidaciones = Periodosliquidacion.find(:all, :conditions=>['id in (select distinct periodosliquidacion_id from nominas where empleado_id = ?)',params[:id]],:order=>"fecha_final desc")
    elsif @empleado.etapa.to_s == "7"
      @empleadoscapacitacion = Empleadoscapacitacion.new
    elsif @empleado.etapa.to_s == "8"
      @empleadosactividad = Empleadosactividad.new
    end
    @existearchivo = Archivosempleado.exists?(["empleado_id = ?", @empleado.id])
    @existecontratos = Contrato.exists?(["empleado_id = ?", @empleado.id])
    @archivosempleado = Archivosempleado.new
    @empleadosimagen = Empleadosimagen.new
    respond_to do |format|
      format.html { render :action => "empleado_form" }
    end
  end

  def create
    @empleado = Empleado.new(params[:empleado])
    @empleado.identificacion = (params[:empleado][:identificacion].to_i).to_s.strip
    @empleado.user_id = is_admin
    @empleado.etapa = '1'
    if params[:empleado][:fecha_nacimiento].to_d <= '1970-01-01'.to_d
      fecha = params[:empleado][:fecha_nacimiento]
    end
    if @empleado.save
      if fecha
        ActiveRecord::Base.connection.execute("update empleados set fecha_nacimiento = '#{fecha}' where id = #{@empleado.id}")
      end
      Empleadobitacora.create(:user_id=>is_admin,:empleado_id=>@empleado.id, 
                              :dependencia_id => @empleado.dependencia_id, 
                              :tipo => "#{@empleado.tipo}", :eps => "#{@empleado.eps}", 
                              :pension=> "#{@empleado.pension}", :arl=> "#{@empleado.nivel_riesgo}",
                              :caja_compensacion=> "#{@empleado.caja_compensacion}", :cargo=>"#{@empleado.cargo}", 
                              :nro_cuenta=>"#{@empleado.nro_cuenta}", :userinterventor_id => @empleado.userinterventor_id,
                              :profesion => "#{@empleado.profesion}", :entidad=>"#{@empleado.entidad}",
                              :tipo_cuenta=>"#{@empleado.tipo_cuenta}", :nivel_educativo=>"#{@empleado.nivel_educativo}",
                              :observacion=>"USUARIO CREADO COMO #{@empleado.tipo}")
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_empleado_path(@empleado)
    else
      @documentos      = Documento.all
      render :action => "empleado_form"
    end
  end

  def create2
    @empleado = Empleado.new(params[:empleado])
    if params[:empleado][:identificacion].to_i > 0
      @empleado.identificacion = (params[:empleado][:identificacion].to_i).to_s.strip
    end
    @empleado.user_id = is_admin
    @empleado.tipo = 'C'
    if @empleado.save
      flash[:notice] = "El contratista ha sido registrado con Exito."
      #redirect_to edit_empleado_path(@empleado)
    else
      @documentos      = Documento.all
      render :action => "new2"
    end
  end

  def update
    @empleado = Empleado.find(params[:id])
    if params[:empleado][:fecha_nacimiento].to_d <= '1970-01-01'.to_d
      fecha = params[:empleado][:fecha_nacimiento]
    end
    if @empleado.update_attributes(params[:empleado])
      if fecha
        ActiveRecord::Base.connection.execute("update empleados set fecha_nacimiento = '#{fecha}' where id = #{@empleado.id}")
      end
      Empleadobitacora.create(:user_id=>is_admin,:empleado_id=>@empleado.id, 
                              :dependencia_id => @empleado.dependencia_id, 
                              :tipo => "#{@empleado.tipo}", :eps => "#{@empleado.eps}", 
                              :pension=> "#{@empleado.pension}", :arl=> "#{@empleado.nivel_riesgo}",
                              :caja_compensacion=> "#{@empleado.caja_compensacion}", :cargo=>"#{@empleado.cargo}", 
                              :nro_cuenta=>"#{@empleado.nro_cuenta}", :userinterventor_id => @empleado.userinterventor_id,
                              :profesion => "#{@empleado.profesion}", :entidad=>"#{@empleado.entidad}",
                              :tipo_cuenta=>"#{@empleado.tipo_cuenta}", :nivel_educativo=>"#{@empleado.nivel_educativo}",
                              :observacion=>"USUARIO ACTUALIZADO")
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_empleado_path(@empleado)
    else
      @documentos      = Documento.all
      @contrato = Contrato.new
      render :action => "empleado_form"
    end
    #rescue
     # redirect_to edit_empleado_path(@empleado)
  end

#userinterventor_id:integer tipo:string    entidad:string tipo_cuenta:string nivel_educativo:string profesion:string 


  def destroy
    @empleado = Empleado.find(params[:id])
    @empleado.destroy
    respond_to do |format|
      format.html { redirect_to(empleados_url) }
      format.xml  { head :ok }
    end
  end

  def informecompleto
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="SIFI-GestionHumana_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = ''
    #@empleados = Empleado.find(:all, :conditions=>["id in (select distinct empleado_id from contratos where to_char(fecha_inicio,'YYYY') = to_char(trunc(sysdate),'YYYY')) "])
    @empleados = Empleado.find(:all, :conditions=>["id in (select distinct empleado_id
                                                            from   contratos
                                                            where  to_char(fecha_inicio,'YYYY') = to_char(trunc(sysdate),'YYYY')
                                                            union
                                                            select distinct empleado_id
                                                            from   contratosvinculados
                                                            where  fecha_final is null
                                                            union
                                                            select distinct empleado_id
                                                            from   contratos
                                                            where  fecha_masmodi is not null 
                                                            and to_char(fecha_masmodi,'YYYY') = to_char(trunc(sysdate),'YYYY'))"])
  end

  private
  def determine_layout
    if ['certificadooblig','certificadomasivo','new2','create2','show','edit2','update2','informepersona','verinfo','newrapido','newrapidocreate','certificado'].include?(action_name)
      "new2"
    elsif ['informecompleto'].include?(action_name)
      "excel"
    else
      "application"
    end
  end

end

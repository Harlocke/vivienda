class AsigtemporalesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def add_asigtemporal
    @asigtemporal = Asigtemporal.new(params[:asigtemporal])
    if params[:asigtemporal][:cobama].to_s == "" or params[:asigtemporal][:tipo].to_s == ""
      render :update do |page|
         page.alert "ATENCIÓN: Debe ingresar el cobama y la fase. Verifique!!!!"
      end
    else
      if Titulacion.exists?(["cobama = '#{@asigtemporal.cobama}'"])
        idtitulacion = Titulacion.find(:first,:conditions=>["cobama = '#{@asigtemporal.cobama}'"]).id
        #logger.error("idtitulacion..."+idtitulacion.to_s)
        @asigtemporal.userprog_id = is_admin
        @asigtemporal.titulacion_id = idtitulacion
        if Asigtemporal.exists?(["titulacion_id = #{idtitulacion}"])
          render :update do |page|
             page.alert "ATENCIÓN: Este cobama ya se encuentra en lista de Asignación. Verifique!!!!"
          end
        else
          respond_to do |format|
            if @asigtemporal.save
               @asigtemporales = Asigtemporal.find(:all,:conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
               format.html { redirect_to asigtemporales_path }
               format.js
            else
               @asigtemporales = Asigtemporal.find(:all,:conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
               format.html { redirect_to asigtemporales_path }
               format.js
            end
          end
        end
      else
        render :update do |page|
           page.alert "ATENCIÓN: El cobama no Existe. Verifique!!!!"
        end
      end
    end
  end


  def asignar
    if params[:ubicacion][:user_id].to_s != ""
      @userid = params[:ubicacion][:user_id]
      @user = User.find(@userid)
      @asigtemporales = Asigtemporal.find(:all, :conditions=>["userprog_id = #{is_admin}"])
      @asigtemporales.each do |asigtemporal|
        titulacionesasignacion = Titulacionesasignacion.new
        titulacionesasignacion.titulacion_id = asigtemporal.titulacion_id
        titulacionesasignacion.user_id = @userid
        titulacionesasignacion.tipo = asigtemporal.tipo
        titulacionesasignacion.fecha_asignacion = asigtemporal.created_at
        titulacionesasignacion.userprog_id = is_admin
        ActiveRecord::Base.connection.execute("update titulacionesasignaciones set fecha_fin = sysdate
                                               where  titulacion_id = #{asigtemporal.titulacion_id}
                                               and    fecha_fin is null
                                               and    tipo = '#{asigtemporal.tipo.to_s}'")
        titulacionesasignacion.save
      end
      begin
        Notifier.deliver_titulacionesasignacion_message(@user,@asigtemporales)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{@user.email rescue nil}")
      end
      ActiveRecord::Base.connection.execute("delete from asigtemporales where userprog_id = #{is_admin}")
      flash[:notice] = 'Atención: Proceso Asignado y enviada la solicitud'
      redirect_to :controller=>"titulaciones", :action=>"seguimientorecomasivo", :user_id =>@user.id
      #redirect_to titulaciones_path
    else
      flash[:warning] = 'Atención: Debe seleccionar un usuario valido'
      redirect_to asigtemporales_path
    end
  end

  def index
    #@asigtemporales = Asigtemporal.all
    @asigtemporales = Asigtemporal.find(:all, :conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asigtemporales }
    end
  end

  def add_asigtemporal2
    @asigtemporal = Asigtemporal.new(params[:asigtemporal])
    if params[:asigtemporal][:cobama].to_s == ""
      render :update do |page|
         page.alert "ATENCIÓN: Debe ingresar el cobama. Verifique!!!!"
      end
    else
      if Titulacion.exists?(["cobama = '#{@asigtemporal.cobama}'"])
        idtitulacion = Titulacion.find(:first,:conditions=>["cobama = '#{@asigtemporal.cobama}'"]).id
        #logger.error("idtitulacion..."+idtitulacion.to_s)
        @asigtemporal.userprog_id = is_admin
        @asigtemporal.titulacion_id = idtitulacion
        if Asigtemporal.exists?(["titulacion_id = #{idtitulacion}"])
          render :update do |page|
             page.alert "ATENCIÓN: Este cobama ya se encuentra en lista de Asignación. Verifique!!!!"
          end
        else
          respond_to do |format|
            if @asigtemporal.save
               @asigtemporales = Asigtemporal.find(:all,:conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
               format.html { redirect_to index2_asigtemporales_path }
               format.js
            else
               @asigtemporales = Asigtemporal.find(:all,:conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
               format.html { redirect_to index2_asigtemporales_path }
               format.js
            end
          end
        end
      else
        render :update do |page|
           page.alert "ATENCIÓN: El cobama no Existe. Verifique!!!!"
        end
      end
    end
  end

  def asignar2
    if params[:ubicacion][:user_id].to_s != "" and  params[:ubicacion][:tipo].to_s != ""
      @userid = params[:ubicacion][:user_id]
      @user = User.find(@userid)
      @asigtemporales = Asigtemporal.find(:all, :conditions=>["userprog_id = #{is_admin}"])
      @asigtemporales.each do |asigtemporal|
        titulacionesasignacion = Titulacionesasignacion.new
        titulacionesasignacion.titulacion_id = asigtemporal.titulacion_id
        titulacionesasignacion.user_id = @userid
        titulacionesasignacion.tipo = params[:ubicacion][:tipo].to_s
        titulacionesasignacion.fecha_asignacion = asigtemporal.created_at
        titulacionesasignacion.userprog_id = is_admin
        ActiveRecord::Base.connection.execute("update titulacionesasignaciones set fecha_fin = sysdate
                                               where  titulacion_id = #{asigtemporal.titulacion_id}
                                               and    fecha_fin is null
                                               and    tipo = '#{params[:ubicacion][:tipo].to_s}'")
        titulacionesasignacion.save
      end
      begin
        Notifier.deliver_titulacionesasignacion_message(@user,@asigtemporales)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{@user.email rescue nil}")
      end
      #ActiveRecord::Base.connection.execute("delete from asigtemporales where userprog_id = #{is_admin}")
      flash[:notice] = 'Atención: Proceso Asignado y enviada la solicitud'
      redirect_to :controller=>"asigtemporales", :action=>"index2"
      #redirect_to titulaciones_path
    else
      flash[:warning] = 'Atención: Debe seleccionar un usuario valido'
      redirect_to index2_asigtemporales_path
    end
  end

  def index2
    #@asigtemporales = Asigtemporal.all
    @asigtemporales = Asigtemporal.find(:all, :conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asigtemporales }
    end
  end

  def show
    @asigtemporal = Asigtemporal.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asigtemporal }
    end
  end

  def new
    @asigtemporal = Asigtemporal.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asigtemporal }
    end
  end

  def edit
    @asigtemporal = Asigtemporal.find(params[:id])
  end

  def create
    @asigtemporal = Asigtemporal.new(params[:asigtemporal])
    @asigtemporal.user_id = is_admin
    respond_to do |format|
      if @asigtemporal.save
        flash[:notice] = 'Asigtemporal was successfully created.'
        format.html { redirect_to(@asigtemporal) }
        format.xml  { render :xml => @asigtemporal, :status => :created, :location => @asigtemporal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asigtemporal.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @asigtemporal = Asigtemporal.find(params[:id])
    @asigtemporal.destroy
    flash[:notice] = 'Registro eliminado con Exito'
    respond_to do |format|
      format.js
    end
  end

  def borrar
    ActiveRecord::Base.connection.execute("delete from asigtemporales where id = #{params[:consecutivo]}")
    flash[:notice] = 'Solicitud Eliminada con exito'
    redirect_to(:controller => 'asigtemporales', :action => 'solicitud')
  end

  def borrartodos
    ActiveRecord::Base.connection.execute("delete from asigtemporales where userprog_id = #{is_admin}")
    flash[:notice] = 'Registros depurados con exito'
    redirect_to(:controller => 'asigtemporales', :action => 'index2')
  end

  private
  def determine_layout
    if ['versolicitudimp','informe3imp','informe'].include?(action_name)
      "tirilla"
    else
      "application"
    end
  end
end

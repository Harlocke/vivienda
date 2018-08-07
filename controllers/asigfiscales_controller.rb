class AsigfiscalesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def add_asigfiscal
    @asigfiscal = Asigfiscal.new(params[:asigfiscal])
    if params[:asigfiscal][:cobama].to_s == "" or params[:asigfiscal][:clase].to_s == ""
      render :update do |page|
         page.alert "ATENCIÓN: Debe ingresar el coba y la fase. Verifique!!!!"
      end
    else
      if Titulacion.exists?(["cobama like '#{params[:asigfiscal][:cobama].to_s}%%'"])
#        idtitulacion = Titulacion.find(:first,:conditions=>["cobama = '#{@asigfiscal.cobama}'"]).id
        #logger.error("idtitulacion..."+idtitulacion.to_s)
#        @asigfiscal.titulacion_id = idtitulacion
        if Asigfiscal.exists?(["coba = '#{params[:asigfiscal][:cobama].to_s}'"])
          render :update do |page|
             page.alert "ATENCIÓN: Este coba ya se encuentra en lista de Asignación. Verifique!!!!"
          end
        else
          respond_to do |format|
            @titulaciones = Titulacion.find(:all, :conditions=>["cobama like '#{params[:asigfiscal][:cobama].to_s}%%'"])
            @titulaciones.each do |titulacion|
              asigfiscal = Asigfiscal.new
              asigfiscal.cobama = titulacion.cobama
              asigfiscal.titulacion_id = titulacion.id
              asigfiscal.userprog_id = is_admin
              asigfiscal.coba = params[:asigfiscal][:cobama].to_s
              asigfiscal.clase = params[:asigfiscal][:clase].to_s
              asigfiscal.save
            end
            @asigfiscales = Asigfiscal.find(:all, :conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
            format.html { redirect_to asigtemporales_path }
            format.js
          end
        end
      else
        render :update do |page|
           page.alert "ATENCIÓN: El coba no Existe. Verifique!!!!"+params[:asigfiscal][:cobama].to_s
        end
      end
    end
  end

  def asignar
    if params[:ubicacion][:user_id].to_s != ""
      @userid = params[:ubicacion][:user_id]
      @user = User.find(@userid)
      @asigfiscales = Asigfiscal.find(:all, :conditions=>["userprog_id = #{is_admin}"])
      @asigfiscales.each do |asigfiscal|
        titulacionesasignacion = Titulacionesasignacion.new
        titulacionesasignacion.titulacion_id = asigfiscal.titulacion_id
        titulacionesasignacion.user_id = @userid
        titulacionesasignacion.tipo = asigfiscal.clase
        titulacionesasignacion.fecha_asignacion = asigfiscal.created_at
        titulacionesasignacion.userprog_id = is_admin
        ActiveRecord::Base.connection.execute("update titulacionesasignaciones set fecha_fin = sysdate
                                               where  titulacion_id = #{asigfiscal.titulacion_id}
                                               and    fecha_fin is null
                                               and    tipo = '#{asigfiscal.clase.to_s}'")
        titulacionesasignacion.save
      end
      begin
        Notifier.deliver_titulacionesasignacionf_message(@user,@asigfiscales)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{@user.email rescue nil}")
      end
      ActiveRecord::Base.connection.execute("delete from asigfiscales where userprog_id = #{is_admin}")
      flash[:notice] = 'Atención: Proceso Asignado y enviada la solicitud'
      #redirect_to :controller=>"titulaciones", :action=>"seguimientorecomasivo", :user_id =>@user.id
      redirect_to titulaciones_path
    else
      flash[:warning] = 'Atención: Debe seleccionar un usuario valido'
      redirect_to asigfiscales_path
    end
  end

  def index
    #@asigfiscales = Asigfiscal.all
    @asigfiscales = Asigfiscal.find(:all, :conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asigfiscales }
    end
  end

  def show
    @asigfiscal = Asigfiscal.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asigfiscal }
    end
  end

  def new
    @asigfiscal = Asigfiscal.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asigfiscal }
    end
  end

  def edit
    @asigfiscal = Asigfiscal.find(params[:id])
  end

  def create
    @asigfiscal = Asigfiscal.new(params[:asigfiscal])
    @asigfiscal.user_id = is_admin
    respond_to do |format|
      if @asigfiscal.save
        flash[:notice] = 'Asigfiscal was successfully created.'
        format.html { redirect_to(@asigfiscal) }
        format.xml  { render :xml => @asigfiscal, :status => :created, :location => @asigfiscal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asigfiscal.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @asigfiscal = Asigfiscal.find(params[:id])
    @asigfiscal.destroy
    flash[:notice] = 'Registro eliminado con Exito'
    respond_to do |format|
      format.js
    end
  end

  def borrar
    ActiveRecord::Base.connection.execute("delete from asigfiscales where id = #{params[:consecutivo]}")
    flash[:notice] = 'Solicitud Eliminada con exito'
    redirect_to(:controller => 'asigfiscales', :action => 'solicitud')
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

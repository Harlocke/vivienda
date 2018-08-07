class AsigsantaelenasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def add_asigsantaelena
    @asigsantaelena = Asigsantaelena.new(params[:asigsantaelena])
    if params[:asigsantaelena][:cobama].to_s == "" or params[:asigsantaelena][:tipo].to_s == ""
      render :update do |page|
         page.alert "ATENCIÓN: Debe ingresar el cobama y la fase. Verifique!!!!"
      end
    else
      @cumple = ""
      if Titulacion.exists?(["cobama = '#{@asigsantaelena.cobama}'"])
        @titulacion = Titulacion.find(:first,:conditions=>["cobama = '#{@asigsantaelena.cobama}'"])
        #Inicia validacion segun el tipo
        if @asigsantaelena.tipo.to_s == 'SANTA ELENA - PREDIAGNOSTICO'
          @cumple = 'S'
        elsif @asigsantaelena.tipo.to_s == 'SANTA ELENA - DIAGNOSTICO'
          @cumple = 'S'
        end
        if @cumple == 'S'
          idtitulacion = @titulacion.id
          #logger.error("idtitulacion..."+idtitulacion.to_s)
          @asigsantaelena.userprog_id = is_admin
          @asigsantaelena.titulacion_id = idtitulacion
          if Asigsantaelena.exists?(["titulacion_id = #{idtitulacion}"])
            render :update do |page|
               page.alert "ATENCIÓN: Este cobama ya se encuentra en lista de Asignación. Verifique!!!!"
            end
          else
            respond_to do |format|
              if @asigsantaelena.save
                 @asigsantaelenas = Asigsantaelena.find(:all,:conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
                 format.html { redirect_to asigsantaelenas_path }
                 format.js
              else
                 @asigsantaelenas = Asigsantaelena.find(:all,:conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
                 format.html { redirect_to asigsantaelenas_path }
                 format.js
              end
            end
          end
        else
          render :update do |page|
             page.alert "ATENCIÓN: El cobama no cumple las condiciones establecidas segun el tipo de asignación. Verifique!!!!"
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
      @asigsantaelenas = Asigsantaelena.find(:all, :conditions=>["userprog_id = #{is_admin}"])
      @asigsantaelenas.each do |asigsantaelena|
        titulacionesasignacion = Titulacionesasignacion.new
        titulacionesasignacion.titulacion_id = asigsantaelena.titulacion_id
        titulacionesasignacion.user_id = @userid
        titulacionesasignacion.tipo = asigsantaelena.tipo
        titulacionesasignacion.fecha_asignacion = asigsantaelena.created_at
        titulacionesasignacion.userprog_id = is_admin
        ActiveRecord::Base.connection.execute("update titulacionesasignaciones set fecha_fin = sysdate
                                               where  titulacion_id = #{asigsantaelena.titulacion_id}
                                               and    fecha_fin is null")
        titulacionesasignacion.save
      end
      begin
        Notifier.deliver_santaelenasasignacion_message(@user,@asigsantaelenas)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{@user.email rescue nil}")
      end
      ActiveRecord::Base.connection.execute("delete from asigsantaelenas where userprog_id = #{is_admin}")
      flash[:notice] = 'Atención: Proceso Asignado y enviada la solicitud'
      #redirect_to :controller=>"titulaciones", :action=>"seguimientorecomasivo", :user_id =>@userid
      redirect_to titulaciones_path
    else
      flash[:warning] = 'Atención: Debe seleccionar un usuario valido'
      redirect_to asigsantaelenas_path
    end
  end

  def index
    #@asigsantaelenas = Asigsantaelena.all
    @asigsantaelenas = Asigsantaelena.find(:all, :conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asigsantaelenas }
    end
  end

  def show
    @asigsantaelena = Asigsantaelena.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asigsantaelena }
    end
  end

  def new
    @asigsantaelena = Asigsantaelena.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asigsantaelena }
    end
  end

  def edit
    @asigsantaelena = Asigsantaelena.find(params[:id])
  end

  def create
    @asigsantaelena = Asigsantaelena.new(params[:asigsantaelena])
    @asigsantaelena.user_id = is_admin
    respond_to do |format|
      if @asigsantaelena.save
        flash[:notice] = 'Asigsantaelena was successfully created.'
        format.html { redirect_to(@asigsantaelena) }
        format.xml  { render :xml => @asigsantaelena, :status => :created, :location => @asigsantaelena }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asigsantaelena.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @asigsantaelena = Asigsantaelena.find(params[:id])
    @asigsantaelena.destroy
    flash[:notice] = 'Registro eliminado con Exito'
    respond_to do |format|
      format.js
    end
  end

  def borrar
    ActiveRecord::Base.connection.execute("delete from asigsantaelenas where id = #{params[:consecutivo]}")
    flash[:notice] = 'Solicitud Eliminada con exito'
    redirect_to(:controller => 'asigsantaelenas', :action => 'solicitud')
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

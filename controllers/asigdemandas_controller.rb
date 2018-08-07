class AsigdemandasController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def add_asigdemanda
    @asigdemanda = Asigdemanda.new(params[:asigdemanda])
    if params[:asigdemanda][:cobama].to_s == "" or params[:asigdemanda][:tipo].to_s == ""
      render :update do |page|
         page.alert "ATENCIÓN: Debe ingresar el cobama y la fase. Verifique!!!!"
      end
    else
      @cumple = ""
      if Titulacion.exists?(["cobama = '#{@asigdemanda.cobama}'"])
        @titulacion = Titulacion.find(:first,:conditions=>["cobama = '#{@asigdemanda.cobama}'"])
        #Inicia validacion segun el tipo
        if @asigdemanda.tipo.to_s == 'PROCESO DE PROYECCION DE DEMANDA'
          if @titulacion.tipoproceso.to_s == 'PERTENENCIA' and @titulacion.estado.to_s == 'COMPLETO'
            @cumple = 'S'
          end
        elsif @asigdemanda.tipo.to_s == 'NOTIFICACION AL USUARIO'
          if @titulacion.tipoproceso.to_s == 'PERTENENCIA' and @titulacion.estado.to_s == 'FALLIDO'
            @cumple = 'S'
          end
        elsif @asigdemanda.tipo.to_s == 'REASIGNACION AL EQUIPO DE CAMPO'
          if @titulacion.tipoproceso.to_s == 'PERTENENCIA' and @titulacion.estado.to_s == 'INCOMPLETO'
            @cumple = 'S'
          end
        elsif @asigdemanda.tipo.to_s == 'REVISION JURIDICA DE EXPEDIENTES'
          if @titulacion.tipoproceso.to_s == 'PERTENENCIA'
            @cumple = 'S'
          end
        end
        if @cumple == 'S'
          idtitulacion = @titulacion.id
          #logger.error("idtitulacion..."+idtitulacion.to_s)
          @asigdemanda.userprog_id = is_admin
          @asigdemanda.titulacion_id = idtitulacion
          if Asigdemanda.exists?(["titulacion_id = #{idtitulacion}"])
            render :update do |page|
               page.alert "ATENCIÓN: Este cobama ya se encuentra en lista de Asignación. Verifique!!!!"
            end
          else
            respond_to do |format|
              if @asigdemanda.save
                 @asigdemandas = Asigdemanda.find(:all,:conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
                 format.html { redirect_to asigdemandas_path }
                 format.js
              else
                 @asigdemandas = Asigdemanda.find(:all,:conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
                 format.html { redirect_to asigdemandas_path }
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
      @asigdemandas = Asigdemanda.find(:all, :conditions=>["userprog_id = #{is_admin}"])
      @asigdemandas.each do |asigdemanda|
        titulacionesasignacion = Titulacionesasignacion.new
        titulacionesasignacion.titulacion_id = asigdemanda.titulacion_id
        titulacionesasignacion.user_id = @userid
        titulacionesasignacion.tipo = asigdemanda.tipo
        titulacionesasignacion.fecha_asignacion = asigdemanda.created_at
        titulacionesasignacion.userprog_id = is_admin
        ActiveRecord::Base.connection.execute("update titulacionesasignaciones set fecha_fin = sysdate
                                               where  titulacion_id = #{asigdemanda.titulacion_id}
                                               and    fecha_fin is null")
        titulacionesasignacion.save
      end
      begin
        Notifier.deliver_demandasasignacion_message(@user,@asigdemandas)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{@user.email rescue nil}")
      end
      ActiveRecord::Base.connection.execute("delete from asigdemandas where userprog_id = #{is_admin}")
      flash[:notice] = 'Atención: Proceso Asignado y enviada la solicitud'
      #redirect_to :controller=>"titulaciones", :action=>"seguimientorecomasivo", :user_id =>@userid
      redirect_to titulaciones_path
    else
      flash[:warning] = 'Atención: Debe seleccionar un usuario valido'
      redirect_to asigdemandas_path
    end
  end

  def index
    #@asigdemandas = Asigdemanda.all
    @asigdemandas = Asigdemanda.find(:all,:conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asigdemandas }
    end
  end

  def show
    @asigdemanda = Asigdemanda.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asigdemanda }
    end
  end

  def new
    @asigdemanda = Asigdemanda.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asigdemanda }
    end
  end

  def edit
    @asigdemanda = Asigdemanda.find(params[:id])
  end

  def create
    @asigdemanda = Asigdemanda.new(params[:asigdemanda])
    @asigdemanda.user_id = is_admin
    respond_to do |format|
      if @asigdemanda.save
        flash[:notice] = 'Asigdemanda was successfully created.'
        format.html { redirect_to(@asigdemanda) }
        format.xml  { render :xml => @asigdemanda, :status => :created, :location => @asigdemanda }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asigdemanda.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @asigdemanda = Asigdemanda.find(params[:id])
    @asigdemanda.destroy
    flash[:notice] = 'Registro eliminado con Exito'
    respond_to do |format|
      format.js
    end
  end

  def borrar
    ActiveRecord::Base.connection.execute("delete from asigdemandas where id = #{params[:consecutivo]}")
    flash[:notice] = 'Solicitud Eliminada con exito'
    redirect_to(:controller => 'asigdemandas', :action => 'solicitud')
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

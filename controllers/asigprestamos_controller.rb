class AsigprestamosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def add_asigprestamo
    @asigprestamo = Asigprestamo.new(params[:asigprestamo])
    if params[:asigprestamo][:cobama].to_s == ""
      render :update do |page|
         page.alert "ATENCIÓN: Debe ingresar el cobama. Verifique!!!!"
      end
    else
      @cumple = ""
      if Titulacion.exists?(["cobama = '#{@asigprestamo.cobama}'"])
        @titulacion = Titulacion.find(:first,:conditions=>["cobama = '#{@asigprestamo.cobama}'"])
        if Titulacionesprestamo.exists?(["titulacion_id = #{@titulacion.id} and fecha_devolucion is null"]) == false
          @cumple = 'S'
        else
          @cumple = 'N'
        end
        if @cumple == 'S'
          idtitulacion = @titulacion.id
          @asigprestamo.userprog_id = is_admin
          @asigprestamo.titulacion_id = idtitulacion
          if Asigprestamo.exists?(["titulacion_id = #{idtitulacion}"])
            render :update do |page|
               page.alert "ATENCIÓN: Este cobama ya se encuentra en lista de Asignación. Verifique!!!!"
            end
          else
            respond_to do |format|
              if @asigprestamo.save
                 @asigprestamos = Asigprestamo.find(:all, :order => 'created_at DESC')
                 format.html { redirect_to asigprestamos_path }
                 format.js
              else
                 @asigprestamos = Asigprestamo.find(:all, :order => 'created_at DESC')
                 format.html { redirect_to asigprestamos_path }
                 format.js
              end
            end
          end
        else
          render :update do |page|
             page.alert "ATENCIÓN: El cobama se encuentra prestado. Verifique!!!!"
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
      @asigprestamos = Asigprestamo.find(:all, :conditions=>["userprog_id = #{is_admin}"])
      @asigprestamos.each do |asigprestamo|
        titulacionesprestamo = Titulacionesprestamo.new
        titulacionesprestamo.titulacion_id = asigprestamo.titulacion_id
        titulacionesprestamo.userprestamo = @userid
        titulacionesprestamo.nro_folios = 0
        titulacionesprestamo.fecha_vence = fechaprogx(Time.now,5)
        titulacionesprestamo.userregistro = is_admin
        titulacionesprestamo.save
      end
      begin
        Notifier.deliver_prestamosasignacion_message(@user,@asigprestamos)
        rescue Exception => exc
           logger.error("SIFI Correo NO enviado a #{@user.email rescue nil}")
      end
      ActiveRecord::Base.connection.execute("delete from asigprestamos where userprog_id = #{is_admin}")
      flash[:notice] = 'Atención: Proceso Asignado y enviada la solicitud'
      #redirect_to :controller=>"titulaciones", :action=>"seguimientorecomasivo", :user_id =>@userid
      redirect_to titulaciones_path
    else
      flash[:warning] = 'Atención: Debe seleccionar un usuario valido'
      redirect_to asigprestamos_path
    end
  end

  def index
    #@asigprestamos = Asigprestamo.all
    @asigprestamos = Asigprestamo.find(:all, :conditions=>["userprog_id = #{is_admin}"], :order => 'created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @asigprestamos }
    end
  end

  def show
    @asigprestamo = Asigprestamo.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asigprestamo }
    end
  end

  def new
    @asigprestamo = Asigprestamo.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asigprestamo }
    end
  end

  def edit
    @asigprestamo = Asigprestamo.find(params[:id])
  end

  def create
    @asigprestamo = Asigprestamo.new(params[:asigprestamo])
    @asigprestamo.user_id = is_admin
    respond_to do |format|
      if @asigprestamo.save
        flash[:notice] = 'Asigprestamo was successfully created.'
        format.html { redirect_to(@asigprestamo) }
        format.xml  { render :xml => @asigprestamo, :status => :created, :location => @asigprestamo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asigprestamo.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @asigprestamo = Asigprestamo.find(params[:id])
    @asigprestamo.destroy
    flash[:notice] = 'Registro eliminado con Exito'
    respond_to do |format|
      format.js
    end
  end

  def borrar
    ActiveRecord::Base.connection.execute("delete from asigprestamos where id = #{params[:consecutivo]}")
    flash[:notice] = 'Solicitud Eliminada con exito'
    redirect_to(:controller => 'asigprestamos', :action => 'solicitud')
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

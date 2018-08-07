class AlmacenessolicitudesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def add_almacenessolicitud
    @almacenessolicitud = Almacenessolicitud.new(params[:almacenessolicitud])
    @almacenessolicitud.user_id = is_admin
    total = 0
    total1 = 0
    total = @almacenessolicitud.cantdisponble.to_i
    total1 = total - params[:almacenessolicitud][:cantidad].to_i
    if total1.to_i >= 0
      respond_to do |format|
        if @almacenessolicitud.save
           @almacenessolicitudes = Almacenessolicitud.find(:all, :conditions=>['user_id =? and fecha_envio is null and consecutivo is null', is_admin],:order => 'created_at DESC')
           format.html { redirect_to almacenessolicitudes_path }
           format.js
        else
           @almacenessolicitudes = Almacenessolicitud.find(:all, :conditions=>['user_id =? and fecha_envio is null and consecutivo is null', is_admin],:order => 'created_at DESC')
           format.html { redirect_to almacenessolicitudes_path }
           format.js
        end
      end
    else
      render :update do |page|
         page.alert "ATENCIÓN: No hay cantidad suficiente para el producto Solicitado. Cantidad disponible ( "+total.to_s+" )"
      end
    end
  end

  def index
    #@almacenessolicitudes = Almacenessolicitud.all
    @almacenessolicitudes = Almacenessolicitud.find(:all, :conditions=>['user_id =? and fecha_envio is null and consecutivo is null', is_admin],:order => 'created_at DESC')
    @existesolicitud = Almacenessolicitud.exists?(['user_id =? and fecha_envio is null and consecutivo is null', is_admin])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @almacenessolicitudes }
    end
  end

  def envio
    almacenessolicitudes = Almacenessolicitud.find(:all, :conditions=>['user_id =? and fecha_envio is null and consecutivo is null', is_admin],:order => 'created_at DESC')
    fechaenvio = Time.now
    maxconsecutivo = Almacenessolicitud.maximum('consecutivo')
    if maxconsecutivo.to_s == ""
      maxconsecutivo = 0
    end
    almacenessolicitudes.each do |almacenessolicitud|
      almacenessolicitud.fecha_envio = fechaenvio
      almacenessolicitud.consecutivo = maxconsecutivo + 1
      almacenessolicitud.save
    end
    flash[:notice] = 'Solicitud de Elementos enviada con Exito.'
    redirect_to menus_path
  end

  def solicitud
    #@almacenessolicitudes = Almacenessolicitud.all
    #@almacenessolicitudes = Almacenessolicitud.find_by_sql('select distinct user_id, fecha_envio, consecutivo from almacenessolicitudes where fecha_envio is not null and revisado is null order by fecha_envio desc')
    @almacenessolicitudes = Almacenessolicitud.find(:all, :select =>"user_id, fecha_envio, consecutivo, nro_salida", :conditions=>["fecha_envio is not null and revisado is null"], :group=>'user_id, fecha_envio, consecutivo, nro_salida', :order=>"fecha_envio desc")
    @almacenesssolicitudes = Almacenessolicitud.find(:all, :select =>"user_id, fecha_envio, consecutivo, nro_salida", :conditions=>["fecha_envio is not null and revisado is not null"],:limit=>200, :group=>'user_id, fecha_envio, consecutivo, nro_salida', :order=>"fecha_envio desc")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @almacenessolicitudes }
    end
  end

  def versolicitud
    @almacenessolicitudes = Almacenessolicitud.find(:all, :conditions=>['consecutivo=?', params[:consecutivo]],:order => 'created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @almacenessolicitudes }
    end
  end

  def versolicitudimp
    if Almacenessolicitud.exists?(["consecutivo = '#{params[:consecutivo]}' and nro_salida is null"])
        lastnrosalida = Almacenessolicitud.maximum('nro_salida').to_i rescue 0
        lastnrosalida = lastnrosalida + 1
        @almacenessolicitudes = Almacenessolicitud.find(:all, :conditions=>["consecutivo = '#{params[:consecutivo]}' and revisado = 'S'", ],:order => 'created_at DESC')
        @almacenessolicitudes.each do |almacenessolicitud|
          if almacenessolicitud.valor_unitario.to_i == 0
            almacenessolicitud.nro_salida     = lastnrosalida.to_i
            almacenessolicitud.valor_unitario = almacenessolicitud.producto.valor_promedio.to_i
            almacenessolicitud.valor_total    = (almacenessolicitud.producto.valor_promedio.to_i * almacenessolicitud.cantreal)
            almacenessolicitud.save
          end
        end
    else
        @almacenessolicitudes = Almacenessolicitud.find(:all, :conditions=>["consecutivo = '#{params[:consecutivo]}' and revisado = 'S'", ],:order => 'created_at DESC')
    end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @almacenessolicitudes }
    end
  end

  def solicitudmes
    @almacenesssolicitudes = Almacenessolicitud.find(:all, :select =>"user_id, fecha_envio, consecutivo, nro_salida", 
                                                           :conditions=>["to_char(trunc(fecha_envio),'YYYY-MM-DD') between '2015-12-01' and '2015-12-31' and revisado is not null"],:limit=>200, :group=>'user_id, fecha_envio, consecutivo, nro_salida', :order=>"fecha_envio desc")
  end

  def registrarsalida
    total = 0
    total1 = 0
    almacenessolicitud = Almacenessolicitud.find(params[:id])
    almacenessalida    = Almacenessalida.new
    almacenessalida.producto_id = almacenessolicitud.producto_id
    almacenessalida.user_id = almacenessolicitud.user_id
    if almacenessolicitud.cantidad_real.to_s != ""
      almacenessalida.cantidad = almacenessolicitud.cantidad_real
    else
      almacenessalida.cantidad = almacenessolicitud.cantidad
    end
    almacenessalida.observaciones = "Registrada por solicitud ..." + almacenessolicitud.consecutivo.to_s
    total = almacenessolicitud.cantdisponble.to_i
    total1 = total - almacenessalida.cantidad.to_i
    if total1.to_i >= 0
      almacenessalida.save
      almacenessolicitud.revisado = 'S'
      almacenessolicitud.save
      redirect_to(:controller => 'almacenessolicitudes', :action => 'versolicitud', :consecutivo=> almacenessolicitud.consecutivo)
    else
      flash[:notice] = 'La solicitud no puede ser registrada, no hay disponibilidad del elemento.'
      redirect_to(:controller => 'almacenessolicitudes', :action => 'versolicitud', :consecutivo=> almacenessolicitud.consecutivo)
    end
  end

  def show
    @almacenessolicitud = Almacenessolicitud.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @almacenessolicitud }
    end
  end

  def new
    @almacenessolicitud = Almacenessolicitud.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @almacenessolicitud }
    end
  end

  def edit
    @almacenessolicitud = Almacenessolicitud.find(params[:id])
  end

  def create
    @almacenessolicitud = Almacenessolicitud.new(params[:almacenessolicitud])
    @almacenessolicitud.user_id = is_admin
    respond_to do |format|
      if @almacenessolicitud.save
        flash[:notice] = 'Almacenessolicitud was successfully created.'
        format.html { redirect_to(@almacenessolicitud) }
        format.xml  { render :xml => @almacenessolicitud, :status => :created, :location => @almacenessolicitud }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @almacenessolicitud.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @almacenessolicitud = Almacenessolicitud.find(params[:id])
    total = 0
    total1 = 0
    total = @almacenessolicitud.cantdisponble.to_i
    total1 = total - params[:almacenessolicitud][:cantidad_real].to_i
    if total1.to_i >= 0
      respond_to do |format|
        if @almacenessolicitud.update_attributes(params[:almacenessolicitud])
          if @almacenessolicitud.cantidad_reintegra.to_i > 0
            ActiveRecord::Base.connection.execute("insert into almacenesentradas (id,producto_id, cantidad, observaciones, created_at, updated_at,user_id)
                                                   values (almacenesentradas_seq.nextval,#{@almacenessolicitud.producto_id},#{@almacenessolicitud.cantidad_reintegra},'REINTEGRO CONSECUTIVO #{@almacenessolicitud.consecutivo}',sysdate,sysdate,#{is_admin})")
            flash[:notice] = 'Reintegro realizado con exito'
            #redirect_to(:controller => 'almacenessolicitudes', :action => 'versolicitud', :consecutivo=>@almacenessolicitud.consecutivo)
          else
            flash[:notice] = 'Solicitud Modificada con Exito.'
          end
          format.html { redirect_to edit_almacenessolicitud_path(@almacenessolicitud.id) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @almacenessolicitud.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        flash[:notice] = "ATENCIÓN: No hay cantidad suficiente para el producto Solicitado. Cantidad disponible ( "+total.to_s+" )"
        format.html { redirect_to edit_almacenessolicitud_path(@almacenessolicitud.id) }
        format.xml  { head :ok }
      end
    end
  end

  def destroy
    @almacenessolicitud = Almacenessolicitud.find(params[:id])
    @almacenessolicitud.destroy
    @existesolicitud = Almacenessolicitud.exists?(['user_id =? and fecha_envio is null and consecutivo is null', is_admin])
    flash[:notice] = 'Registro eliminado con Exito'
    respond_to do |format|
      format.js
    end
  end

  def borrar
    ActiveRecord::Base.connection.execute("delete from almacenessolicitudes where consecutivo = #{params[:consecutivo]}")
    flash[:notice] = 'Solicitud Eliminada con exito'
    redirect_to(:controller => 'almacenessolicitudes', :action => 'solicitud')
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

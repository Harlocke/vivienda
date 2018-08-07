class MensajesenviosController < ApplicationController

  before_filter :require_user
  layout :determine_layout


  def index
    @mensajesenvios = Mensajesenvio.find(:all, :conditions => ["user_id = #{is_admin} and estado in ('A','I')"],:limit=>"20",:order => 'created_at DESC')
    @mensajesenviosc = Mensajesenvio.find(:all, :conditions => ["user_id = #{is_admin} and estado in ('V')"],:limit=>"50",:order => 'created_at DESC')
  end

  def show
    @mensajesenvio = Mensajesenvio.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mensajesenvio }
    end
  end

  def new
    @mensajesenvio = Mensajesenvio.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mensajesenvio }
    end
  end

 def edit
   @mensajesenvio = Mensajesenvio.find(params[:id])
   respond_to do |format|
     format.html { render :action => "mensajesenvio_form" }
   end
 end

  def create
    @mensajesenvio = Mensajesenvio.new(params[:mensajesenvio])
    if @mensajesenvio.save
     flash[:notice] = "Requerimiento realizado con Exito"
     redirect_to edit_mensajesenvio_path(@mensajesenvio)
    else
     flash[:warning] = "Problemas con la creacion del registro."
     render :action => "mensajesenvio_form"
    end
  end

 def update
   @mensajesenvio = Mensajesenvio.find(params[:id])
     @mensajesenvio.estado = 'I'
     if @mensajesenvio.update_attributes(params[:mensajesenvio])
        flash[:notice] = "El registro ha sido Calificado con Exito."
        redirect_to menus_path
     else
        render :action => "mensajesenvio_form"
     end
   rescue
     flash[:warning] = "Error general contacte al administador!"
     redirect_to edit_mensajesenvio_path(@mensajeenvio)
 end

#  def update
#    @mensajesenvio = Mensajesenvio.find(params[:id])
#    if @mensajesenvio.soporte_id.to_s != ""
#      soporte = Soporte.find(@mensajesenvio.soporte_id)
#      soporte.usuario_solucionado = params[:ubicacion][:solucionado]
#      soporte.usuario_observaciones = params[:observacion]
#      soporte.save
#    end
#    @mensajesenvio.estado = 'I'
#    if @mensajesenvio.update_attributes(params[:mensajesenvio])
#      flash[:notice] = "El registro ha sido actualizado con Exito."
#      redirect_to menus_path
#    else
#      redirect_to edit_mensajesenvio_path(@mensajeenvio)
#    end
#    rescue
#      flash[:warning] = "Ha ocurrido un error."
#      redirect_to edit_mensajesenvio_path(@mensajeenvio)
#  end

  def updateestado
    @mensajesenvio = Mensajesenvio.find(params[:id])
    @mensajesenvio.estado = 'I'
    @mensajesenvio.update_attributes(params[:mensajesenvio])
    redirect_to menus_path
  end

  def destroy
    #logger.error("Ingreso al destroy ....")
    ActiveRecord::Base.connection.execute("update mensajesenvios set estado = 'V', updated_at = sysdate where id = #{params[:id].to_i}")
    @mensajesenviosc = Mensajesenvio.find(:all, :conditions=>["user_id = #{is_admin} and estado = 'C'"])
    if @mensajesenviosc.count >= 1
      redirect_to menus_path
    else
      render :update do |page|
        page.redirect_to menus_path
      end
    end
  end

  def destroymasive
    @mensajesenvios = Mensajesenvio.find(:all, :conditions => ["user_id = #{is_admin} and estado = 'C'"],:order => 'created_at asc')
    @mensajesenvios.each do |mensajesenvio|
      ActiveRecord::Base.connection.execute(
      "update mensajesenvios set estado = 'V', updated_at = sysdate where id = #{mensajesenvio.id}")
    end
    redirect_to menus_path
  end

  private
  def determine_layout
    if [''].include?(action_name)
      "sistemas"
    else
      "sistemas"
    end
  end
end

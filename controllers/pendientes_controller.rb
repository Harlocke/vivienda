class PendientesController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    #@pendientes = Pendiente.search_pendiente(is_admin) 
    #@pendientesv = Pendiente.find(:all, :conditions=>["fecha_vence < trunc(sysdate) and estado in ('PENDIENTE', 'EN TRAMITE')"], :order=>"fecha_vence asc")   
  end

  def visualizar
    @pendiente = Pendiente.find(params[:id])
  end

  def buscar
    #logger.error("--------------------------------------------------------------------------")
    #ogger.error("El valor de control_int es..."+params[:ubicacion][:control_int].to_s)
    #logger.error("--------------------------------------------------------------------------")
    @pendientes = Pendiente.search(params[:ubicacion][:estado],
                                  params[:ubicacion][:inicial],
                                  params[:ubicacion][:final],
                                  params[:ubicacion][:finicial],
                                  params[:ubicacion][:ffinal],
                                  params[:ubicacion][:control_int],
                                  params[:ubicacion][:planeacion],
                                  params[:ubicacion][:administrativa] ,
                                  params[:ubicacion][:poblacional] ,
                                  params[:ubicacion][:juridica] ,
                                  params[:ubicacion][:dotacion],
                                  params[:ubicacion][:comunicaciones] ,
                                  params[:ubicacion][:direccion] )
    if @pendientes.count == 0 
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_pendientes_path
    elsif @pendientes.count == 1
      redirect_to edit_pendiente_path(@pendientes)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def sendpendienteind
    @pendiente = Pendiente.find(params[:id])
    #Notifier.deliver_queja_message(Sifi.find(38).valor.to_s,queja)
  end

 
  def new
    @pendiente = Pendiente.new
    render :action => "pendiente_form"
  end

  def edit
    @pendiente = Pendiente.find(params[:id])
    @pendientesnota = Pendientesnota.new
      respond_to do |format|
      format.html { render :action => "pendiente_form" }
    end
  end

  def create
    @pendiente = Pendiente.new(params[:pendiente])
    @pendiente.user_id = is_admin
    if @pendiente.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_pendiente_path(@pendiente)
    else
      render :action => "pendiente_form"
    end
  end

  def update
    @pendiente = Pendiente.find(params[:id])
    @pendiente.user_id = is_admin
    if @pendiente.update_attributes(params[:pendiente])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_pendiente_path(@pendiente)
    else
      @pendientesnota = Pendientesnota.new
      render :action => "pendiente_form"
    end
  rescue
    flash[:notice] = "Existen inconsistencias. Verifique!!!"
    redirect_to edit_pendiente_path(@pendiente)
  end

  # def enviomensaje
  #   @pendiente = Pendiente.find(params[:id])
  #   Pendiente.envio(@pendiente)
  #   flash[:notice] = "La informacion ha sido enviada con Exito via Electronica."
  #   redirect_to new_pendiente_path
  # end
  
  def destroy
    @pendiente = Pendiente.find(params[:id])
    @pendiente.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to busqueda_pendientes_path
      }
      format.xml  { head :ok }
    end
  end

#  def show
#    persona   = Persona.find(params[:pendiente_id])
#    @pendientes = persona.pendientes.all
#  end

  private
  def determine_layout
    if ['visualizar','buscarx'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
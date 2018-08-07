class ContratosController < ApplicationController
  layout :determine_layout
  before_filter :require_user
#  require 'win32ole'

  def index
    empleado   = Empleado.find(params[:empleado_id])
    @contratos = empleado.contratos.all
  end

  def edit
    @contrato  = Contrato.find(params[:id], :include => "empleado")
    @empleado  = @contrato.empleado
    respond_to do |format|
      format.js { render :action => "edit_contrato" }
    end
  end

  def ver
    @contrato = Contrato.find(params[:id])
  end

  def solicitarcompromiso
    @contrato = Contrato.find(params[:id])
    @calidadversion = Calidadversion.find(5)
    @correos  = Sifi.find(32).valor.to_s
    @estudiosprevio = Estudiosprevio.find(:first, :conditions=>["contrato_id = #{@contrato.id}"])
    begin
      Notifier.deliver_compromiso_message(@correos, @contrato, @estudiosprevio)
      flash[:notice] = "Correo ENVIADO con Exito"
      rescue Exception => exc
         #logger.error("SIFI ERROR solicitarcompromiso - Correo No enviado a #{@correos}")
         flash[:notice] = "Correo NO ENVIADO, Verifique! "+@estudiosprevio.id.to_s
    end
  end

  def actainicio
    @contrato = Contrato.find(params[:id])
    @calidadversion = Calidadversion.find(6)

  end


  def actainterventoria
    @contrato = Contrato.find(params[:id])
    if @contrato.notificacioninterventoria.to_s == ""
      correo = User.find(is_admin).email.to_s
      interventor = User.find_by_identificacion(Empleado.find(@contrato.interventorempleado_id).identificacion).email rescue nil
      abogado = User.find_by_identificacion(Empleado.find(@contrato.abogadoempleado_id).identificacion).email rescue nil
      if interventor
        correo = correo + ',' + interventor.to_s
      end
      if abogado
        correo = correo + ',' + abogado.to_s
      end
      begin
        Notifier.deliver_actainterventoria_message(correo, @contrato)
        flash[:notice] = "Correo ENVIADO con Exito"
        ActiveRecord::Base.connection.execute("update contratos set notificacioninterventoria = 'SI' where id = #{@contrato.id}")
        rescue Exception => exc
          flash[:notice] = "Correo NO ENVIADO, Verifique! "+@contrato.id.to_s
      end
    end
    @calidadversion = Calidadversion.find(7)
  end

  def actacarta1
   @contrato = Contrato.find(params[:id])
 end

  def actacarta2
    @contrato = Contrato.find(params[:id])
    @calidadversion = Calidadversion.find(9)
  end

  def certificado
    @contrato = Contrato.find(params[:id])
  end

  def create
    @empleado  = Empleado.find(params[:empleado_id])
    @contrato = Contrato.new(params[:contrato])
    if @contrato.valid?
      @contrato.user_id = is_admin
      #@contrato.nro_contrato = conse
      @contrato.nro_contrato = is_nextcontrato
      @empleado.contratos << @contrato
      @empleado.save
      is_trigger_interventoria(@contrato.id,@contrato.interventorempleado_id,is_admin)
      @contrato = Contrato.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "contratos" }
    end
  end

  def update
    @contrato        = Contrato.new
    contrato         = Contrato.find(params[:id])
    @empleado        = contrato.empleado
    #Deteccion Cambio de Interventor
    interactual = params[:contrato][:interventorempleado_id].to_i
    interbd = contrato.interventorempleado_id.to_i
    ok = contrato.update_attributes(params[:contrato])
    if ok == true
      #Deteccion Cambio de Interventor
      if interbd.to_i != interactual.to_i
        is_trigger_interventoria(contrato.id,interactual,is_admin)
      end
      flash[:notice] ="Contrato Actualizado correctamente"
      respond_to do |format|
        format.js { render :action => "contratos" }
      end
    else
      render :update do |page|
         page.alert "Debe completar todos los campos y recuerde que la fecha de inicio del contrato no puede ser inferior a la fecha de vinculacion inicial de la ARL. Verifique"
      end
    end
  end

  def destroy
    contrato   = Contrato.find(params[:id])
    @empleado  = contrato.empleado
    @contrato  = Contrato.new
    contrato.destroy
    respond_to do |format|
      format.js { render :action => "contratos" }
    end
  end

  private
  def determine_layout
    if ['ver','certificado','actainicio','actainterventoria','actacarta1','actacarta2','solicitarcompromiso'].include?(action_name)
      "vercontrato"
    else
      "application"
    end
  end
end

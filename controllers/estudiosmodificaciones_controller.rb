class EstudiosmodificacionesController < ApplicationController
  before_filter :require_user

  def index
    estudiosprevio   = Estudiosprevio.find(params[:estudiosprevio_id])
    @estudiosmodificaciones = estudiosprevio.estudiosmodificaciones.all
  end

  def edit
    @estudiosmodificacion  = Estudiosmodificacion.find(params[:id], :include => "estudiosprevio")
    @estudiosprevio  = @estudiosmodificacion.estudiosprevio
    respond_to do |format|
      format.js { render :action => "edit_estudiosmodificacion" }
    end
  end

  def ver
    @estudiosmodificacion  = Estudiosmodificacion.find(params[:id])
    @estudiosmrubro = Estudiosmrubro.new
  end

  def create
    @estudiosprevio  = Estudiosprevio.find(params[:estudiosprevio_id])
    @estudiosmodificacion = Estudiosmodificacion.new(params[:estudiosmodificacion])
    @estudiosmodificacion.user_id = is_admin
    @estudiosmodificacion.estado = 'PENDIENTE'
    if @estudiosmodificacion.valid?
      @estudiosprevio.estudiosmodificaciones << @estudiosmodificacion
      @estudiosprevio.save
      @estudiosmodificacion = Estudiosmodificacion.new
      flash[:estudiosmodificacion] = "Registro almacenado con Exito"
    else
      flash[:estudiosmodificacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "estudiosmodificaciones" }
    end
  end

  def update
    @estudiosmodificacion        = Estudiosmodificacion.new
    estudiosmodificacion         = Estudiosmodificacion.find(params[:id])
    @estudiosprevio        = estudiosmodificacion.estudiosprevio
    ok = estudiosmodificacion.update_attributes(params[:estudiosmodificacion])
    flash[:estudiosmodificacion] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "estudiosmodificaciones" }
    end
  end

  def destroy
    estudiosmodificacion   = Estudiosmodificacion.find(params[:id])
    @estudiosprevio  = estudiosmodificacion.estudiosprevio
    @estudiosmodificacion  = Estudiosmodificacion.new
    estudiosmodificacion.destroy
    respond_to do |format|
      format.js { render :action => "estudiosmodificaciones" }
    end
  end

  def solicitarcompromiso
    @estudiosmodificacion   = Estudiosmodificacion.find(params[:id])
    @correos  = Sifi.find(32).valor.to_s
    begin
      Notifier.deliver_compromiso2_message(@correos, @estudiosmodificacion)
      ActiveRecord::Base.connection.execute("update estudiosmodificaciones set estado = 'SOLICITADO' where id = #{@estudiosmodificacion.id}")
      flash[:notice] = "Correo ENVIADO con Exito"
      #rescue Exception => exc
#         #logger.error("SIFI ERROR solicitarcompromiso - Correo No enviado a #{@correos}")
 #        flash[:notice] = "Correo NO ENVIADO, Verifique! "+@estudiosmodificacion.id.to_s
    end
    redirect_to estudiosprevios_path
  end
  
=begin
  def crearmodificacion
    @estudiosmodificacion   = Estudiosmodificacion.find(params[:id])

    @estudiosmodificaciones = Estudiosmodificacion.find(:all, :conditions=>["trunc(created_at) >= '01-01-2016' and estado = 'SOLICITADO'"])
    @estudiosmodificaciones.each do |estudiosmodificacion|
      if Contratosmodificacion.exists?(["tipo_modificacion = '#{estudiosmodificacion.tipo_modificacion.to_s}' and contrato_id = (select contrato_id from estudiosprevios where id = #{estudiosmodificacion.estudiosprevio_id})"]) == false
        contratosmodificacion = Contratosmodificacion.new
        contratosmodificacion.contrato_id = estudiosmodificacion.estudiosprevio.contrato_id
        contratosmodificacion.tipo_modificacion = estudiosmodificacion.tipo_modificacion
        contratosmodificacion.valor = estudiosmodificacion.valor
        contratosmodificacion.fecha = estudiosmodificacion.created_at.strftime("%d-%m-%Y")
        contratosmodificacion.plazo_mes = estudiosmodificacion.plazo_mes
        contratosmodificacion.plazo_dias = estudiosmodificacion.plazo_dias
        contratosmodificacion.user_id = estudiosmodificacion.user_id
        contratosmodificacion.observaciones = 'MODIFICACIÓN CREADA AUTOMATICAMENTE'
        contratosmodificacion.created_at = estudiosmodificacion.created_at
        contratosmodificacion.updated_at = estudiosmodificacion.updated_at
        contratosmodificacion.save
        ActiveRecord::Base.connection.execute("update estudiosmodificaciones set estado = 'TERMINADO' where id = #{estudiosmodificacion.id}")
      end
    end
    redirect_to estudiosprevios_path
  end
=end

  def crearmodificacion
    estudiosmodificacion   = Estudiosmodificacion.find(params[:id])
    if estudiosmodificacion.estado.to_s == 'SOLICITADO'
      contratosmodificacion = Contratosmodificacion.new
      contratosmodificacion.contrato_id = estudiosmodificacion.estudiosprevio.contrato_id
      contratosmodificacion.tipo_modificacion = estudiosmodificacion.tipo_modificacion
      contratosmodificacion.valor = estudiosmodificacion.valor
      contratosmodificacion.fecha = estudiosmodificacion.created_at.strftime("%d-%m-%Y")
      contratosmodificacion.plazo_mes = estudiosmodificacion.plazo_mes
      contratosmodificacion.plazo_dias = estudiosmodificacion.plazo_dias
      contratosmodificacion.user_id = estudiosmodificacion.user_id
      contratosmodificacion.observaciones = 'MODIFICACIÓN CREADA AUTOMATICAMENTE'
      contratosmodificacion.created_at = estudiosmodificacion.created_at
      contratosmodificacion.updated_at = estudiosmodificacion.updated_at
      contratosmodificacion.save
      ActiveRecord::Base.connection.execute("update estudiosmodificaciones set estado = 'TERMINADO' where id = #{estudiosmodificacion.id}")
      flash[:notice] = "Modificación Cargada en el Contrato correctamente"    
      redirect_to estudiosprevios_path    
    else
      flash[:warning] = "Modificación Ya SOLICITADAAA"    
      redirect_to estudiosprevios_path    
    end
  end
end
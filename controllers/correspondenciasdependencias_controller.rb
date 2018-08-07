class CorrespondenciasdependenciasController < ApplicationController

  before_filter :require_user
  layout :determine_layout

  def index
    correspondenciasrecibida   = Correspondenciasrecibida.find(params[:correspondenciasrecibida_id])
    @correspondenciasdependencias = correspondenciasrecibida.correspondenciasdependencias.all
  end

 def edit
    @correspondenciasdependencia  = Correspondenciasdependencia.find(params[:id], :include => "correspondenciasrecibida")
    @correspondenciasrecibida  = @correspondenciasdependencia.correspondenciasrecibida
    respond_to do |format|
      format.js { render :action => "edit_correspondenciasdependencia" }
    end
  end

 def visualizar
    @correspondenciasdependencia  = Correspondenciasdependencia.find(params[:id])
  end

  def create
    @correspondenciasrecibida  = Correspondenciasrecibida.find(params[:correspondenciasrecibida_id])
    @correspondenciasdependencia = Correspondenciasdependencia.new(params[:correspondenciasdependencia])
    @correspondenciasdependencia.user_id = is_admin
    @correspondenciasdependencia.fecha = Time.now
    if @correspondenciasdependencia.valid?
      @correspondenciasrecibida.correspondenciasdependencias << @correspondenciasdependencia
      @correspondenciasrecibida.save
      @idcorrdep = @correspondenciasdependencia.id
      @correspondenciasdependencia = Correspondenciasdependencia.new
      ActiveRecord::Base.connection.execute("delete from correspondenciasasignadas where correspondenciasrecibida_id = #{params[:correspondenciasrecibida_id]}")
      ActiveRecord::Base.connection.execute("update correspondenciasdependencias set fecha_fin = sysdate
                                             where  correspondenciasrecibida_id = #{@correspondenciasrecibida.id}
                                             and    id != #{@idcorrdep}")
      @correspondenciasdependencia.bandejacorrespondencia
      flash[:correspondenciasdependencia] = "Creado con exito"
    else
      flash[:correspondenciasdependencia] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "correspondenciasdependencias" }
    end
  end

  def update
    @correspondenciasdependencia   = Correspondenciasdependencia.new
    correspondenciasdependencia    = Correspondenciasdependencia.find(params[:id])
    @correspondenciasrecibida        = correspondenciasdependencia.correspondenciasrecibida
    ok = correspondenciasdependencia.update_attributes(params[:correspondenciasdependencia])
    flash[:correspondenciasdependencia] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "correspondenciasdependencias" }
    end
  end

  def destroy
    correspondenciasdependencia   = Correspondenciasdependencia.find(params[:id])
    @correspondenciasrecibida  = correspondenciasdependencia.correspondenciasrecibida
    @correspondenciasdependencia  = Correspondenciasdependencia.new
    correspondenciasdependencia.destroy
    flash[:correspondenciasdependencia] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "correspondenciasdependencias" }
    end
  end

  def asignacion
    @correspondenciasdependencia   = Correspondenciasdependencia.new
    correspondenciasdependencia    = Correspondenciasdependencia.find(params[:id])
    @correspondenciasrecibida = Correspondenciasrecibida.find(correspondenciasdependencia.correspondenciasrecibida_id)
    if @correspondenciasrecibida.corresrecibidasimagenes.exists? == true
      @correos = correspondenciasdependencia.dependencia.depcorreo rescue nil
      @dependencianombre = correspondenciasdependencia.dependencia.descripcion rescue nil
      if @correos.to_s != ""
        begin
          Notifier.deliver_correspondenciasrecibida_message(@correspondenciasrecibida, @correos, @dependencianombre)
          sleep 10
          ActiveRecord::Base.connection.execute("update correspondenciasdependencias set fechaenvio = sysdate, user_envio = #{is_admin} where id = #{correspondenciasdependencia.id}")
          flash[:correspondenciasdependencia] = "Correo ENVIADO con Exito"
          rescue Exception => exc
            flash[:correspondenciasdependencia] = "Correo NO ENVIADO"
        end
      else
        flash[:correspondenciasdependencia] = "No hay correos para enviar - Correo NO Enviado"
      end
    else
      flash[:correspondenciasdependencia] = "No hay archivo digital para enviar en el Correo - Correo NO Enviado"
    end
    respond_to do |format|
      format.js { render :action => "correspondenciasdependencias" }
    end
  end
  
  private
  def determine_layout
    if ['create'].include?(action_name)
      "application"
    elsif ['asignacion'].include?(action_name)
      "vercontrato"
#    else
#      "basico"
    end
  end
end

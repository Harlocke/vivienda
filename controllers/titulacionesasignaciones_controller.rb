class TitulacionesasignacionesController < ApplicationController
  before_filter :require_user
  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesasignaciones = titulacion.titulacionesasignaciones.all
  end

  def edit
    @titulacionesasignacion  = Titulacionesasignacion.find(params[:id], :include => "titulacion")
    @titulacion  = @titulacionesasignacion.titulacion
    respond_to do |format|
      format.js { render :action => "edit_titulacionesasignacion" }
    end
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesasignacion = Titulacionesasignacion.new(params[:titulacionesasignacion])
      if @titulacionesasignacion.valid?
        ActiveRecord::Base.connection.execute("update titulacionesasignaciones set fecha_fin = sysdate
                                               where  titulacion_id = #{@titulacion.id}
                                               and    fecha_fin is null")
        @titulacion.titulacionesasignaciones << @titulacionesasignacion
        @titulacion.save
        is_trigger_tit(@titulacion.id,is_admin,'titulacionesasignacion','I')
        @titulacionesasignacion = Titulacionesasignacion.new
      else
        flash[:titulacionesasignacion] = "Se produjo un error al guardar el registro"
      end
      respond_to do |format|
        format.js { render :action => "titulacionesasignaciones" }
      end
  end

  def update
    @titulacionesasignacion        = Titulacionesasignacion.new
    titulacionesasignacion         = Titulacionesasignacion.find(params[:id])
    @titulacion        = titulacionesasignacion.titulacion
    ok = titulacionesasignacion.update_attributes(params[:titulacionesasignacion])
    flash[:titulacionesasignacion] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesasignacion','A')
    end
    respond_to do |format|
      format.js { render :action => "titulacionesasignaciones" }
    end
  end

  def cierra
    @titulacionesasignacion      = Titulacionesasignacion.new
    titulacionesasignacion       = Titulacionesasignacion.find(params[:id])
    titulacionesasignacion.fecha_fin = Time.now
    @titulacion       = titulacionesasignacion.titulacion
    ok = titulacionesasignacion.update_attributes(params[:titulacionesasignacion])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesasignacion','A')
    end
    respond_to do |format|
      format.js { render :action => "titulacionesasignaciones" }
    end
  end

  def destroy
    titulacionesasignacion   = Titulacionesasignacion.find(params[:id])
    @titulacion  = titulacionesasignacion.titulacion
    @titulacionesasignacion  = Titulacionesasignacion.new
    #titulacionesasignacion.respaldo(is_admin)
    titulacionesasignacion.destroy
    respond_to do |format|
      format.js { render :action => "titulacionesasignaciones" }
    end
  end

end
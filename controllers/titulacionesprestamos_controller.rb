class TitulacionesprestamosController < ApplicationController

  before_filter :require_user
  require 'ruby_plsql'

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesprestamos = titulacion.titulacionesprestamos.all
  end

  def edit
    @titulacionesprestamo      = Titulacionesprestamo.new
    titulacionesprestamo       = Titulacionesprestamo.find(params[:id])
    titulacionesprestamo.userdevolucion = is_admin
    titulacionesprestamo.fecha_devolucion = Time.now
    @titulacion       = titulacionesprestamo.titulacion
    ok = titulacionesprestamo.update_attributes(params[:titulacionesprestamo])
    respond_to do |format|
      format.js { render :action => "titulacionesprestamos" }
    end
  end

  def aplaza
    @titulacionesprestamo      = Titulacionesprestamo.new
    titulacionesprestamo       = Titulacionesprestamo.find(params[:id])
    titulacionesprestamo.fecha_vence = fechaprogx(titulacionesprestamo.fecha_vence,5)
    @titulacion       = titulacionesprestamo.titulacion
    ok = titulacionesprestamo.update_attributes(params[:titulacionesprestamo])
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesprestamo','A')
      flash[:titulacionesprestamo] = "Aplazamiento Individual realizado con exito..."
    else
      flash[:titulacionesprestamo] = "Aplazamiento Individual NO realizado..."
    end
    respond_to do |format|
      format.js { render :action => "titulacionesprestamos" }
    end
  end

  def aplazamasivo
    @titulacionesprestamo      = Titulacionesprestamo.new
    titulacionesprestamo       = Titulacionesprestamo.find(params[:id])
    titulacionesprestamo.fecha_vence = fechaprogx(titulacionesprestamo.fecha_vence,5)
    titulacionesprestamo.save
    flash[:notice] = "Aplazamiento Individual realizado con exito..."
    redirect_to pendientesentrega_titulaciones_path
  end

  def aplazamasivom
    ActiveRecord::Base.connection.execute("begin prc_titulacionaplaza(#{params[:id].to_i}); end;")    
    flash[:notice] = "Aplazamiento masivo realizado con exito..."
    redirect_to pendientesentrega_titulaciones_path
  end

  def entregamasivo
    @titulacionesprestamo      = Titulacionesprestamo.new
    titulacionesprestamo       = Titulacionesprestamo.find(params[:id])
    titulacionesprestamo.userdevolucion = is_admin
    titulacionesprestamo.fecha_devolucion = Time.now
    titulacionesprestamo.save
    redirect_to pendientesentrega_titulaciones_path
  end

  def entregavigentemasivo
    @titulacionesprestamo      = Titulacionesprestamo.new
    titulacionesprestamo       = Titulacionesprestamo.find(params[:id])
    titulacionesprestamo.userdevolucion = is_admin
    titulacionesprestamo.fecha_devolucion = Time.now
    titulacionesprestamo.save
    redirect_to vigentesentrega_titulaciones_path
  end

  def create
    @titulacion  = Titulacion.find(params[:titulacion_id])
    @titulacionesprestamo = Titulacionesprestamo.new(params[:titulacionesprestamo])
    @titulacionesprestamo.fecha_vence = fechaprogx(Time.now,5)
    @titulacionesprestamo.userregistro = is_admin
    if @titulacionesprestamo.valid?
      @titulacion.titulacionesprestamos << @titulacionesprestamo
      @titulacion.save
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesprestamo','I')
      @titulacionesprestamo = Titulacionesprestamo.new
      flash[:titulacionesprestamo] = "Registro almacenado con exito"
    else
      flash[:titulacionesprestamo] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "titulacionesprestamos" }
    end
  end

  def update
    @titulacionesprestamo  = Titulacionesprestamo.new
    titulacionesprestamo   = Titulacionesprestamo.find(params[:id])
    @titulacion           = titulacionesprestamo.titulacion
    ok = titulacionesprestamo.update_attributes(params[:titulacionesprestamo])
    flash[:titulacionesprestamo] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    if ok == true
      is_trigger_tit(@titulacion.id,is_admin,'titulacionesprestamo','A')
    end
    respond_to do |format|
      format.js { render :action => "titulacionesprestamos" }
    end
  end

  def destroy
    if params[:id2].to_s == '2'
      @titulacionesprestamo = Titulacionesprestamo.new
      titulacionesprestamo  = Titulacionesprestamo.find(params[:id])
      titulacionesprestamo.userdevolucion = is_admin
      titulacionesprestamo.fecha_devolucion = Time.now
      titulacionesprestamo.save
    else
      titulacionesprestamo   = Titulacionesprestamo.find(params[:id])
      @titulacion           = titulacionesprestamo.titulacion
      @titulacionesprestamo  = Titulacionesprestamo.new
      titulacionesprestamo.destroy
      respond_to do |format|
        format.js { render :action => "titulacionesprestamos" }
      end
    end
  end

end

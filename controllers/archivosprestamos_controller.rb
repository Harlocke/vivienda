class ArchivosprestamosController < ApplicationController

  before_filter :require_user
  require 'ruby_plsql'

  def index
    archivo   = Archivo.find(params[:archivo_id])
    @archivosprestamos = archivo.archivosprestamos.all
  end

  def edit
    @archivosprestamo      = Archivosprestamo.new
    archivosprestamo       = Archivosprestamo.find(params[:id])
    archivosprestamo.userdevolucion = is_admin
    archivosprestamo.fecha_devolucion = Time.now
    @archivo       = archivosprestamo.archivo
    ok = archivosprestamo.update_attributes(params[:archivosprestamo])
    archivosprestamo.mensajereturn
    respond_to do |format|
      format.js { render :action => "archivosprestamos" }
    end
  end

  def aplaza
    @archivosprestamo      = Archivosprestamo.new
    archivosprestamo       = Archivosprestamo.find(params[:id])
    archivosprestamo.fecha_vence = fechaprogx(archivosprestamo.fecha_vence,5)
    @archivo       = archivosprestamo.archivo
    ok = archivosprestamo.update_attributes(params[:archivosprestamo])
    archivosprestamo.mensajeaplaza
    respond_to do |format|
      format.js { render :action => "archivosprestamos" }
    end
  end

  def aplazamasivo
    @archivosprestamo      = Archivosprestamo.new
    archivosprestamo       = Archivosprestamo.find(params[:id])
    archivosprestamo.fecha_vence = fechaprogx(archivosprestamo.fecha_vence,5)
    archivosprestamo.save
    archivosprestamo.mensajeaplaza
    flash[:notice] = "Aplazamiento Individual realizado con exito..."
    redirect_to pendientesentrega_archivos_path
  end

  def aplazamasivom
    ActiveRecord::Base.connection.execute("begin prc_archivoaplaza(#{params[:id].to_i}); end;")
    flash[:notice] = "Aplazamiento masivo realizado con exito..."
    redirect_to pendientesentrega_archivos_path
  end

  def entregamasivo
    @archivosprestamo      = Archivosprestamo.new
    archivosprestamo       = Archivosprestamo.find(params[:id])
    archivosprestamo.userdevolucion = is_admin
    archivosprestamo.fecha_devolucion = Time.now
    archivosprestamo.save
    archivosprestamo.mensajereturn
    redirect_to pendientesentrega_archivos_path
  end

  def entregavigentemasivo
    @archivosprestamo      = Archivosprestamo.new
    archivosprestamo       = Archivosprestamo.find(params[:id])
    archivosprestamo.userdevolucion = is_admin
    archivosprestamo.fecha_devolucion = Time.now
    archivosprestamo.save
    archivosprestamo.mensajereturn    
    redirect_to vigentesentrega_archivos_path
  end

  def create
    @archivo  = Archivo.find(params[:archivo_id])
    @archivosprestamo = Archivosprestamo.new(params[:archivosprestamo])
    @archivosprestamo.fecha_vence = fechaprogx(Time.now,5)
    @archivosprestamo.userregistro = is_admin
    if @archivosprestamo.valid?
      @archivo.archivosprestamos << @archivosprestamo
      @archivo.save
      @archivosprestamo = Archivosprestamo.new
      flash[:archivosprestamo] = "Registro almacenado con exito"
    else
      flash[:archivosprestamo] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "archivosprestamos" }
    end
  end

  def update
    @archivosprestamo  = Archivosprestamo.new
    archivosprestamo   = Archivosprestamo.find(params[:id])
    @archivo           = archivosprestamo.archivo
    ok = archivosprestamo.update_attributes(params[:archivosprestamo])
    flash[:archivosprestamo] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "archivosprestamos" }
    end
  end

  def destroy
    archivosprestamo   = Archivosprestamo.find(params[:id])
    @archivo           = archivosprestamo.archivo
    @archivosprestamo  = Archivosprestamo.new
    archivosprestamo.deletemensajeenvio
    archivosprestamo.destroy
    respond_to do |format|
      format.js { render :action => "archivosprestamos" }
    end
  end

end

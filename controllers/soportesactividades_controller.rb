class SoportesactividadesController < ApplicationController

  before_filter :require_user

  def index
    soporte   = Soporte.find(params[:soporte_id])
    @soportesactividades = soporte.soportesactividades.all
  end

  def edit
    @soportesactividad  = Soportesactividad.find(params[:id], :include => "soporte")
    @soporte  = @soportesactividad.soporte
    respond_to do |format|
      format.js { render :action => "edit_soportesactividad" }
    end
  end

  def create
    @soporte  = Soporte.find(params[:soporte_id])
    @soportesactividad = Soportesactividad.new(params[:soportesactividad])
    @soportesactividad.user_id = is_admin
    if @soportesactividad.valid?
      @soporte.soportesactividades << @soportesactividad
      @soporte.save
      @soportesactividad = Soportesactividad.new
      flash[:soporteactividad] = "Creado con exito"
    else
      flash[:soporteactividad] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "soportesactividades" }
    end
  end

  def update
    @soportesactividad        = Soportesactividad.new
    soportesactividad         = Soportesactividad.find(params[:id])
    @soporte        = soportesactividad.soporte
    ok = soportesactividad.update_attributes(params[:soportesactividad])
    flash[:soporteactividad] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "soportesactividades" }
    end
  end

  def destroy
    soportesactividad   = Soportesactividad.find(params[:id])
    @soporte  = soportesactividad.soporte
    @soportesactividad  = Soportesactividad.new
    soportesactividad.destroy
    flash[:soporteactividad] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "soportesactividades" }
    end
  end
end

class ConveniosresolucionesController < ApplicationController
  before_filter :require_user

  def index
    convenio   = Convenio.find(params[:convenio_id])
    @conveniosresoluciones = convenio.conveniosresoluciones.all
  end

  def edit
    @conveniosresolucion  = Conveniosresolucion.find(params[:id], :include => "convenio")
    @convenio  = @conveniosresolucion.convenio
    respond_to do |format|
      format.js { render :action => "edit_conveniosresolucion" }
    end
  end

  def buscar
        respond_to do |format|
           format.html
           format.xls if params[:format] == 'xls'
        end
  end

  def create
    @convenio  = Convenio.find(params[:convenio_id])
    @conveniosresolucion = Conveniosresolucion.new(params[:conveniosresolucion])
    @conveniosresolucion.user_id = is_admin
    if Resolucion.exists?(["nro_resolucion = ? and anno = ? and modalidad = 'MEJORAMIENTO'", params[:conveniosresolucion][:nro_resolucion], params[:conveniosresolucion][:anno]]) == true
      if Conveniosresolucion.exists?(["nro_resolucion = ? and anno = ?", params[:conveniosresolucion][:nro_resolucion], params[:conveniosresolucion][:anno]]) == false
        @conveniosresolucion.resolucion_id = Resolucion.find_by_nro_resolucion_and_anno(params[:conveniosresolucion][:nro_resolucion], params[:conveniosresolucion][:anno]).id rescue nil
        if @conveniosresolucion.valid?
          @convenio.conveniosresoluciones << @conveniosresolucion
          @convenio.save
          ActiveRecord::Base.connection.execute("update convenios set cr ='SI' where id = #{@convenio.id}")
          @conveniosresolucion = Conveniosresolucion.new
          flash[:conveniosresolucion] = "Creado con exito"
        else
          flash[:conveniosresolucion] = "Se produjo un error al guardar el registro"
        end
      else
        flash[:conveniosresolucion] = "El Nro del Resolucion que indica ya esta registrado en un Convenio. Verifique!!"
      end
    else
      flash[:conveniosresolucion] = "El Nro del Resolucion que indica no es valido o no es de Mejoramiento. Verifique!!"
    end
    respond_to do |format|
      format.js { render :action => "conveniosresoluciones" }
    end
  end

  def update
    @conveniosresolucion        = Conveniosresolucion.new
    conveniosresolucion         = Conveniosresolucion.find(params[:id])
    params[:conveniosresolucion][:user_actualiza] = is_admin
    @convenio        = conveniosresolucion.convenio
    ok = conveniosresolucion.update_attributes(params[:conveniosresolucion])
    if ok == true
      flash[:conveniosresolucion] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "conveniosresoluciones" }
      end
    else
      render :update do |page|
        page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    conveniosresolucion   = Conveniosresolucion.find(params[:id])
    @convenio  = conveniosresolucion.convenio
    @conveniosresolucion  = Conveniosresolucion.new
    conveniosresolucion.destroy
    flash[:conveniosresolucion] = "Resolucion Eliminada con exito"
    respond_to do |format|
      format.js { render :action => "conveniosresoluciones" }
    end
  end
end

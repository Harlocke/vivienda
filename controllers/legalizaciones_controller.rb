include ChainSelectsHelper
class LegalizacionesController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    @legalizaciones = Legalizacion.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @legalizaciones }
    end
  end

  def show
    @legalizacion = Legalizacion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @legalizacion }
    end
  end

  def ver
    @legalizacion = Legalizacion.find(params[:id])
  end

  def informeconsolidado
    @legalizacionesc = Legalizacion.find_by_sql(["select 'REGIMEN DE PROPIEDAD HORIZONTAL' PP, count(distinct legalizacion_id) cantidad from legalizacionesreglamentos
                                                  union
                                                  select 'CESION DE ZONAS DE USO PUBLICO', count(distinct legalizacion_id) cantidad from legalizazonasreglamentos"])
    @legalizacionesd = Legalizacion.find_by_sql(["select descripcion, (select distinct 'SI' from legalizacionesreglamentos where legalizacion_id = legalizaciones.id) t1,
                                                       (select distinct 'SI' from legalizazonasreglamentos where legalizacion_id = legalizaciones.id) t2
                                                  from legalizaciones
                                                  where id in (select legalizacion_id from legalizazonasreglamentos)
                                                  order by descripcion"])
    @legalizacionese = Legalizacion.find_by_sql(["select descripcion, (select distinct 'SI' from legalizacionesreglamentos where legalizacion_id = legalizaciones.id) t1,
                                                       (select distinct 'SI' from legalizazonasreglamentos where legalizacion_id = legalizaciones.id) t2
                                                  from legalizaciones
                                                  where id not in (select legalizacion_id from legalizazonasreglamentos)
                                                  order by descripcion"])    
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="legalizacioninforme_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @legalizacionesobservaciones = Legalizacionesobservacion.search(params[:ubicacion][:usuario],
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal])
    respond_to do |format|
       format.xls
    end
  end

  def consolidado
    if params[:ubicacion][:proyecto] != ""
      @proyecto = params[:ubicacion][:proyecto].to_s
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="'+"#{@proyecto}"+'_consolidado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @legalizaciones = Legalizacion.find(:all, :conditions=>["proyecto = '#{params[:ubicacion][:proyecto]}'"])
    else
      flash[:notice] = "Debe seleccionar el Proyecto"
      redirect_to legalizaciones_path
    end

  end

  def informespago
    if params[:ubicacion][:proyecto] != ""
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="'+"#{params[:ubicacion][:proyecto]}"+'_pagos_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @legalizaciones = Legalizacion.find(:all, :conditions=>["proyecto = '#{params[:ubicacion][:proyecto]}'"])
      @legalizacionespagos = Legalizacionespago.find(:all, :conditions=>["legalizacion_id in (select id from legalizaciones where proyecto = '#{params[:ubicacion][:proyecto]}')"])
      respond_to do |format|
         format.xls
      end
    else
      flash[:notice] = "Debe seleccionar el Proyecto"
      redirect_to legalizaciones_path
    end
  end

  def new
    @legalizacion = Legalizacion.new
    render :action => "legalizacion_form"
  end

  def edit
    @legalizacion = Legalizacion.find(params[:id])
    @legalizacionesproyecto = Legalizacionesproyecto.new
    @legalizacionesreglamento = Legalizacionesreglamento.new
    @legalizacionesmatricula = Legalizacionesmatricula.new
    @legalizazonasreglamento = Legalizazonasreglamento.new
    @legalizazonasmatricula  = Legalizazonasmatricula.new
    @legalizacionesimagen = Legalizacionesimagen.new
    respond_to do |format|
      format.html { render :action => "legalizacion_form" }
    end
  end

  def create
    @legalizacion = Legalizacion.new(params[:legalizacion])
    @legalizacion.user_id = is_admin
    if @legalizacion.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_legalizacion_path(@legalizacion)
    else
      render :action => "legalizacion_form"
    end
  end

  def update
    @legalizacion = Legalizacion.find(params[:id])
    if @legalizacion.update_attributes(params[:legalizacion])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_legalizacion_path(@legalizacion)
    else
      @legalizacionesproyecto = Legalizacionesproyecto.new
      @legalizacionesreglamento = Legalizacionesreglamento.new
      @legalizacionesmatricula = Legalizacionesmatricula.new
      @legalizazonasreglamento = Legalizazonasreglamento.new
      @legalizazonasmatricula = Legalizazonasmatricula.new
      @legalizacionesimagen = Legalizacionesimagen.new
      flash[:notice] = "Error al realizar la actualizacion."
      render :action => "legalizacion_form"
    end
    rescue
     redirect_to edit_legalizacion_path(@legalizacion)
  end

  def destroy
    @legalizacion = Legalizacion.find(params[:id])
    @legalizacion.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to legalizaciones_path
        }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['cierre','ver','informeconsolidado'].include?(action_name)
      "atencion"
    elsif ['consolidado'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

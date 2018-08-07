class ValorizacionesController < ApplicationController
  layout :determine_layout
  before_filter :require_user

  def index
    @valorizaciones = Valorizacion.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @valorizaciones }
    end
  end

  def cierre
    @valorizacion = Valorizacion.find(params[:id])
  end

  def show
    @valorizacion = Valorizacion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @valorizacion }
    end
  end

  def select_user2
    @users = User.find(:all, :order=>"nombre")
    return @users
  end

  def buscar
    @valorizacion  = Valorizacion.new
    if params[:ubicacion][:proyecto] != ""
      @valorizacion.valorizacionesobra_id =  params[:ubicacion][:valorizacionesobra_id]
      @valorizacion.valorizacionesestado_id =  params[:ubicacion][:valorizacionesestado_id]
      @valorizacion.cobama =  params[:cobama]
      @valorizaciones = Valorizacion.search(@valorizacion,params[:identificacion])
      if @valorizaciones.count == 0 and params[:format] != 'xls'
        flash[:notice] = "No hay resultados de la busqueda"
        redirect_to valorizaciones_path
      elsif @valorizaciones.count == 1 and params[:format] != 'xls'
        redirect_to edit_valorizacion_path(@valorizaciones)
      else
        if params[:format] == 'xls'
          headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
          headers['Content-Disposition'] = 'attachment; filename="SIFI_valorizacion_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
          headers['Cache-Control'] = 'max-age=0'
          headers['pragma']="public"
          respond_to do |format|
             format.xls
          end
        else
          respond_to do |format|
            format.html
          end
        end
      end
    else
      flash[:notice] = "Debe seleccionar el Proyecto"
      redirect_to valorizaciones_path
    end
  end

  def informe
    headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Disposition'] = 'attachment; filename="valorizacioninforme_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @valorizacionesobservaciones = Valorizacionesobservacion.search(params[:ubicacion][:usuario],
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
      @valorizaciones = Valorizacion.find(:all, :conditions=>["proyecto = '#{params[:ubicacion][:proyecto]}'"])
    else
      flash[:notice] = "Debe seleccionar el Proyecto"
      redirect_to valorizaciones_path
    end

  end

  def informespago
    if params[:ubicacion][:proyecto] != ""
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="'+"#{params[:ubicacion][:proyecto]}"+'_pagos_'+"#{Time.now.strftime("%Y_%m_%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      @valorizaciones = Valorizacion.find(:all, :conditions=>["proyecto = '#{params[:ubicacion][:proyecto]}'"])
      @valorizacionespagos = Valorizacionespago.find(:all, :conditions=>["valorizacion_id in (select id from valorizaciones where proyecto = '#{params[:ubicacion][:proyecto]}')"])
      respond_to do |format|
         format.xls
      end
    else
      flash[:notice] = "Debe seleccionar el Proyecto"
      redirect_to valorizaciones_path
    end
  end

  def new
    #@valorizaciones = Valorizacion.all
    @valorizacion = Valorizacion.new
    render :action => "valorizacion_form"
  end

  def edit
    @valorizacion = Valorizacion.find(params[:id])
    @valorizacionespersona = Valorizacionespersona.new
    @valorizacionesrentista = Valorizacionesrentista.new
    @valorizacionespago  = Valorizacionespago.new
    @valorizacionesimagen = Valorizacionesimagen.new
    @valorizacionesnota = Valorizacionesnota.new
    respond_to do |format|
      format.html { render :action => "valorizacion_form" }
    end
  end

  def create
    @valorizacion = Valorizacion.new(params[:valorizacion])
    @valorizacion.fecha_limite = fechaprog(@valorizacion.fecha_sol_rev_avaluo, 214)
    @valorizacion.user_id = is_admin
    @valorizacion.useract_id = is_admin
    if @valorizacion.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_valorizacion_path(@valorizacion)
    else
      render :action => "valorizacion_form"
    end
  end

  def update
    @valorizacion = Valorizacion.find(params[:id])
    params[:valorizacion][:useract_id] = is_admin
    if @valorizacion.update_attributes(params[:valorizacion])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_valorizacion_path(@valorizacion)
    else
      @valorizacionespersona = Valorizacionespersona.new
      @valorizacionesrentista = Valorizacionesrentista.new
      @valorizacionespago  = Valorizacionespago.new
      @valorizacionesobservacion = Valorizacionesobservacion.new
      @valorizacionesimagen = Valorizacionesimagen.new
      @valorizacionespersona = Valorizacionespersona.new
      flash[:notice] = "Error al realizar la actualizacion."
      render :action => "valorizacion_form"
    end
    rescue
     redirect_to edit_valorizacion_path(@valorizacion)
  end

  def destroy
    @valorizacion = Valorizacion.find(params[:id])
    @valorizacion.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro y sus componentes han sido Eliminados con Exito."
        redirect_to valorizaciones_path
        }
      format.xml  { head :ok }
    end
  end

  def buscacobama
    cobamaid = ""
    valor = params[:valor].to_s  #valor digitado en la variable
    if valor.to_s != ""
      if Comuna.exists?(["codigo_barrio = '#{valor.to_s[0,4]}'"]) == true
        comuna = Comuna.find_by_codigo_barrio(valor.to_s[0,4])
        cobamaid = comuna.id
            render :update do |page|
              page[:valorizacion_direccion][:value] = nil
              page[:valorizacion_comuna_id][:value] = cobamaid
              page[:valorizacion_manzana][:value] = valor.to_s[4,3]
              page[:valorizacion_lote][:value] = valor.to_s[7,4]
            end
      else
        render :update do |page|
          page[:valorizacion_direccion][:value] = nil
          page[:valorizacion_comuna_id][:value] = nil
          page[:valorizacion_manzana][:value] = nil
          page[:valorizacion_lote][:value] = nil
        end
      end
    end
  end

  private
  def determine_layout
    if ['cierre'].include?(action_name)
      "atencion"
    elsif ['consolidado'].include?(action_name)
      "excel"
    else
      "application"
    end
  end
end

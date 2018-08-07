class SeguimientosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    @seguimientos = Seguimiento.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seguimientos }
    end
  end

  def mostrar
    @seguimiento = Seguimiento.find(params[:id])
    if params[:format] == 'xls'
      headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Disposition'] = 'attachment; filename="Seguimiento_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
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

  def show
    @seguimiento = Seguimiento.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seguimiento }
    end
  end

  def new
    @seguimiento = Seguimiento.new
    render :action => "seguimiento_form"
  end

  def edit
    @seguimiento = Seguimiento.find(params[:id])
    @seguimientoslicitacion = Seguimientoslicitacion.new
    @seguimientosimagen = Seguimientosimagen.new
    @seguimientosobservacion = Seguimientosobservacion.new
    @seguimientosmodificacion = Seguimientosmodificacion.new
    respond_to do |format|
      format.html { render :action => "seguimiento_form" }
    end
  end

  def create
    @seguimiento = Seguimiento.new(params[:seguimiento])
    @seguimiento.user_id = is_admin
    if @seguimiento.save
      flash[:notice] = "Registro Creado con Exito."
      redirect_to edit_seguimiento_path(@seguimiento)
    else
      @seguimientoslicitacion = Seguimientoslicitacion.new
      @seguimientosimagen = Seguimientosimagen.new
      @seguimientosobservacion = Seguimientosobservacion.new
      @seguimientosmodificacion = Seguimientosmodificacion.new
      render :action => "seguimiento_form"
    end
  end

  def update
    @seguimiento = Seguimiento.find(params[:id])
    @seguimiento.user_actualiza = is_admin
    if @seguimiento.update_attributes(params[:seguimiento])
      flash[:notice] = "Registro Actualizado con Exito."
      redirect_to edit_seguimiento_path(@seguimiento)
    else
      @seguimientoslicitacion = Seguimientoslicitacion.new
      @seguimientosimagen = Seguimientosimagen.new
      @seguimientosobservacion = Seguimientosobservacion.new
      @seguimientosmodificacion = Seguimientosmodificacion.new
      render :action => "seguimiento_form"
    end
  end

  def destroy
    @seguimiento = Seguimiento.find(params[:id])
    @seguimiento.destroy
    respond_to do |format|
      format.html {
        flash[:notice] = "El registro ha sido eliminado con Exito."
        redirect_to busqueda_seguimientos_path
      }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['mostrar','mostrarconsolidado'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end

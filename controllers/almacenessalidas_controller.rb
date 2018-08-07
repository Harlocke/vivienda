class AlmacenessalidasController < ApplicationController

  before_filter :require_user

  def index
    @almacenessalidas = Almacenessalida.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @almacenessalidas }
    end
  end

  def buscar
    @almacenessalidas = Almacenessalida.search(params[:ubicacion][:producto_id],
                                               params[:ubicacion][:usuario],
                                               params[:ubicacion][:inicial],
                                               params[:ubicacion][:final])
    if @almacenessalidas.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_almacenessalidas_path
    elsif @almacenessalidas.count == 1 and params[:format] != 'xls'
      redirect_to edit_almacenessalida_path(@almacenessalidas)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def new
    @almacenessalida = Almacenessalida.new
    render :action => "almacenessalida_form"
  end

  def edit
    @almacenessalida = Almacenessalida.find(params[:id])
    respond_to do |format|
      format.html { render :action => "almacenessalida_form" }
    end
  end

  def create
    @almacenessalida = Almacenessalida.new(params[:almacenessalida])
    if @almacenessalida.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_almacenessalida_path(@almacenessalida)
    else
      render :action => "almacenessalida_form"
    end
  end

  def update
    @almacenessalida = Almacenessalida.find(params[:id])
    if @almacenessalida.update_attributes(params[:almacenessalida])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_almacenessalida_path(@almacenessalida)
    else
      render :action => "almacenessalida_form"
    end
    rescue
      redirect_to edit_almacenessalida_path(@almacenessalida)
  end

  def destroy
    @almacenessalida = Almacenessalida.find(params[:id])
    @almacenessalida.destroy
    respond_to do |format|
      format.html { redirect_to busqueda_almacenessalidas_path }
      format.xml  { head :ok }
    end
  end
end
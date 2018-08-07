class ProductosController < ApplicationController

  before_filter :require_user
    
  def index
    @productos = Producto.search(params[:search], params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @productos }
    end
  end

  def listar
      @productos = Producto.find(:all, :conditions => [" descripcion like upper('%%#{params[:search]}%%')"])
      #@personas = Persona.find(:all, :conditions => [' autobuscar LIKE ?', "%#{params[:search]}%"])
  end

  def new
    @producto = Producto.new
    render :action => "producto_form"
  end

  def edit
    @producto = Producto.find(params[:id])
    respond_to do |format|
      format.html { render :action => "producto_form" }
    end
  end

  def create
    @producto = Producto.new(params[:producto])
    if @producto.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_producto_path(@producto)
    else
      render :action => "producto_form"
    end
  end

  def update
    @producto = Producto.find(params[:id])
    if @producto.update_attributes(params[:producto])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_producto_path(@producto)
    else
      render :action => "producto_form"
    end
    rescue
      redirect_to edit_producto_path(@producto)
  end

  def destroy
    @producto = Producto.find(params[:id])
    @producto.destroy
    respond_to do |format|
      format.html { redirect_to(productos_url) }
      format.xml  { head :ok }
    end
  end
end

class AlmacenesinmueblesController < ApplicationController
  before_filter :require_user

  def index
    @almacenesinmuebles = Almacenesinmueble.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @almacenesinmuebles }
    end
  end

  def buscar
    @almacenesinmuebles = Almacenesinmueble.search(
                             params[:matricula],
                             params[:descripcion],
                             params[:lugar],
                             params[:ubicacion][:estado]
                             )
    if @almacenesinmuebles.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_almacenesinmuebles_path
    elsif @almacenesinmuebles.count == 1 and params[:format] != 'xls'
      redirect_to edit_almacenesinmueble_path(@almacenesinmuebles)
    else
      respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
      end
    end
  end

  def new
    @almacenesinmueble = Almacenesinmueble.new
    render :action => "almacenesinmueble_form"
  end

  def edit
    @almacenesinmueble = Almacenesinmueble.find(params[:id])
    respond_to do |format|
      format.html { render :action => "almacenesinmueble_form" }
    end
  end

  def create
    @almacenesinmueble = Almacenesinmueble.new(params[:almacenesinmueble])
    if @almacenesinmueble.save
      flash[:notice] = "El registro ha sido registrado con Exito."
      redirect_to edit_almacenesinmueble_path(@almacenesinmueble)
    else
      render :action => "almacenesinmueble_form"
    end
  end

  def update
    @almacenesinmueble = Almacenesinmueble.find(params[:id])
    if @almacenesinmueble.update_attributes(params[:almacenesinmueble])
      flash[:notice] = "El registro ha sido actualizado con Exito."
      redirect_to edit_almacenesinmueble_path(@almacenesinmueble)
    else
      render :action => "almacenesinmueble_form"
    end
    rescue
      redirect_to edit_almacenesinmueble_path(@almacenesinmueble)
  end

  def destroy
    @almacenesinmueble = Almacenesinmueble.find(params[:id])
    @almacenesinmueble.destroy
    respond_to do |format|
      format.html { redirect_to(almacenesinmuebles_url) }
      format.xml  { head :ok }
    end
  end
end

  #  # GET /almacenesinmuebles
#  # GET /almacenesinmuebles.xml
#  def index
#    @almacenesinmuebles = Almacenesinmueble.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @almacenesinmuebles }
#    end
#  end
#
#  # GET /almacenesinmuebles/1
#  # GET /almacenesinmuebles/1.xml
#  def show
#    @almacenesinmueble = Almacenesinmueble.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @almacenesinmueble }
#    end
#  end
#
#  # GET /almacenesinmuebles/new
#  # GET /almacenesinmuebles/new.xml
#  def new
#    @almacenesinmueble = Almacenesinmueble.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @almacenesinmueble }
#    end
#  end
#
#  # GET /almacenesinmuebles/1/edit
#  def edit
#    @almacenesinmueble = Almacenesinmueble.find(params[:id])
#  end
#
#  # POST /almacenesinmuebles
#  # POST /almacenesinmuebles.xml
#  def create
#    @almacenesinmueble = Almacenesinmueble.new(params[:almacenesinmueble])
#
#    respond_to do |format|
#      if @almacenesinmueble.save
#        flash[:notice] = 'Almacenesinmueble was successfully created.'
#        format.html { redirect_to(@almacenesinmueble) }
#        format.xml  { render :xml => @almacenesinmueble, :status => :created, :location => @almacenesinmueble }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @almacenesinmueble.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /almacenesinmuebles/1
#  # PUT /almacenesinmuebles/1.xml
#  def update
#    @almacenesinmueble = Almacenesinmueble.find(params[:id])
#
#    respond_to do |format|
#      if @almacenesinmueble.update_attributes(params[:almacenesinmueble])
#        flash[:notice] = 'Almacenesinmueble was successfully updated.'
#        format.html { redirect_to(@almacenesinmueble) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @almacenesinmueble.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /almacenesinmuebles/1
#  # DELETE /almacenesinmuebles/1.xml
#  def destroy
#    @almacenesinmueble = Almacenesinmueble.find(params[:id])
#    @almacenesinmueble.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(almacenesinmuebles_url) }
#      format.xml  { head :ok }
#    end
#  end
#end

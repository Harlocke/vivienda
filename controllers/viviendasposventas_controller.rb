class ViviendasposventasController < ApplicationController

  before_filter :require_user

  def index
    vivienda   = Vivienda.find(params[:vivienda_id])
    @viviendasposventas = vivienda.viviendasposventas.all
  end

  def edit
    @viviendasposventa  = Viviendasposventa.find(params[:id], :include => "vivienda")
    @vivienda  = @viviendasposventa.vivienda
    respond_to do |format|
      format.js { render :action => "edit_viviendasposventa" }
    end
  end

  def buscar
        respond_to do |format|
           format.html
           format.xls if params[:format] == 'xls'
        end
  end

  def create
    @vivienda  = Vivienda.find(params[:vivienda_id])
    @viviendasposventa = Viviendasposventa.new(params[:viviendasposventa])
    if @viviendasposventa.valid?
      @vivienda.viviendasposventas << @viviendasposventa
      @vivienda.save
      @viviendasposventa = Viviendasposventa.new
      flash[:viviendasposventa] = "Registro almacenado con Exito"
    else
      flash[:viviendasposventa] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "viviendasposventas" }
    end
  end

  def update
    @viviendasposventa        = Viviendasposventa.new
    viviendasposventa         = Viviendasposventa.find(params[:id])
    @vivienda        = viviendasposventa.vivienda
    ok = viviendasposventa.update_attributes(params[:viviendasposventa])
    flash[:viviendasposventa] = ok ? "Registro actualizado Correctamente." : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "viviendasposventas" }
    end
  end

  def destroy
    viviendasposventa   = Viviendasposventa.find(params[:id])
    @vivienda  = viviendasposventa.vivienda
    @viviendasposventa  = Viviendasposventa.new
    viviendasposventa.destroy
    respond_to do |format|
      format.js { render :action => "viviendasposventas" }
    end
  end
end

  #  # GET /viviendasposventas
#  # GET /viviendasposventas.xml
#  def index
#    @viviendasposventas = Viviendasposventa.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @viviendasposventas }
#    end
#  end
#
#  # GET /viviendasposventas/1
#  # GET /viviendasposventas/1.xml
#  def show
#    @viviendasposventa = Viviendasposventa.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @viviendasposventa }
#    end
#  end
#
#  # GET /viviendasposventas/new
#  # GET /viviendasposventas/new.xml
#  def new
#    @viviendasposventa = Viviendasposventa.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @viviendasposventa }
#    end
#  end
#
#  # GET /viviendasposventas/1/edit
#  def edit
#    @viviendasposventa = Viviendasposventa.find(params[:id])
#  end
#
#  # POST /viviendasposventas
#  # POST /viviendasposventas.xml
#  def create
#    @viviendasposventa = Viviendasposventa.new(params[:viviendasposventa])
#
#    respond_to do |format|
#      if @viviendasposventa.save
#        flash[:notice] = 'Viviendasposventa was successfully created.'
#        format.html { redirect_to(@viviendasposventa) }
#        format.xml  { render :xml => @viviendasposventa, :status => :created, :location => @viviendasposventa }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @viviendasposventa.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /viviendasposventas/1
#  # PUT /viviendasposventas/1.xml
#  def update
#    @viviendasposventa = Viviendasposventa.find(params[:id])
#
#    respond_to do |format|
#      if @viviendasposventa.update_attributes(params[:viviendasposventa])
#        flash[:notice] = 'Viviendasposventa was successfully updated.'
#        format.html { redirect_to(@viviendasposventa) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @viviendasposventa.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /viviendasposventas/1
#  # DELETE /viviendasposventas/1.xml
#  def destroy
#    @viviendasposventa = Viviendasposventa.find(params[:id])
#    @viviendasposventa.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(viviendasposventas_url) }
#      format.xml  { head :ok }
#    end
#  end
#end

class OcupacionesController < ApplicationController

  before_filter :require_user

  def index
    @ocupaciones = Ocupacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ocupaciones }
    end
  end

  def show
    @ocupacion = Ocupacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ocupacion }
    end
  end

  # GET /ocupaciones/new
  # GET /ocupaciones/new.xml
  def new
    @ocupacion = Ocupacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ocupacion }
    end
  end

  # GET /ocupaciones/1/edit
  def edit
    @ocupacion = Ocupacion.find(params[:id])
  end

  # POST /ocupaciones
  # POST /ocupaciones.xml
  def create
    @ocupacion = Ocupacion.new(params[:ocupacion])

    respond_to do |format|
      if @ocupacion.save
        flash[:notice] = 'Ocupacion was successfully created.'
        format.html { redirect_to(@ocupacion) }
        format.xml  { render :xml => @ocupacion, :status => :created, :location => @ocupacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ocupacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ocupaciones/1
  # PUT /ocupaciones/1.xml
  def update
    @ocupacion = Ocupacion.find(params[:id])

    respond_to do |format|
      if @ocupacion.update_attributes(params[:ocupacion])
        flash[:notice] = 'Ocupacion was successfully updated.'
        format.html { redirect_to(@ocupacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ocupacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ocupaciones/1
  # DELETE /ocupaciones/1.xml
  def destroy
    @ocupacion = Ocupacion.find(params[:id])
    @ocupacion.destroy

    respond_to do |format|
      format.html { redirect_to(ocupaciones_url) }
      format.xml  { head :ok }
    end
  end
end

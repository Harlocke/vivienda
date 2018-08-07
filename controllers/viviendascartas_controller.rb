class ViviendascartasController < ApplicationController
  # GET /viviendascartas
  # GET /viviendascartas.xml
  def index
    @viviendascartas = Viviendascarta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @viviendascartas }
    end
  end

  # GET /viviendascartas/1
  # GET /viviendascartas/1.xml
  def show
    @viviendascarta = Viviendascarta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @viviendascarta }
    end
  end

  # GET /viviendascartas/new
  # GET /viviendascartas/new.xml
  def new
    @viviendascarta = Viviendascarta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viviendascarta }
    end
  end

  # GET /viviendascartas/1/edit
  def edit
    @viviendascarta = Viviendascarta.find(params[:id])
  end

  # POST /viviendascartas
  # POST /viviendascartas.xml
  def create
    @viviendascarta = Viviendascarta.new(params[:viviendascarta])

    respond_to do |format|
      if @viviendascarta.save
        flash[:notice] = 'Viviendascarta was successfully created.'
        format.html { redirect_to(@viviendascarta) }
        format.xml  { render :xml => @viviendascarta, :status => :created, :location => @viviendascarta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viviendascarta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /viviendascartas/1
  # PUT /viviendascartas/1.xml
  def update
    @viviendascarta = Viviendascarta.find(params[:id])

    respond_to do |format|
      if @viviendascarta.update_attributes(params[:viviendascarta])
        flash[:notice] = 'Viviendascarta was successfully updated.'
        format.html { redirect_to(@viviendascarta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @viviendascarta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /viviendascartas/1
  # DELETE /viviendascartas/1.xml
  def destroy
    @viviendascarta = Viviendascarta.find(params[:id])
    @viviendascarta.destroy

    respond_to do |format|
      format.html { redirect_to(viviendascartas_url) }
      format.xml  { head :ok }
    end
  end
end

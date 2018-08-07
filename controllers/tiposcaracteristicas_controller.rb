class TiposcaracteristicasController < ApplicationController
  # GET /tiposcaracteristicas
  # GET /tiposcaracteristicas.xml
  def index
    @tiposcaracteristicas = Tiposcaracteristica.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposcaracteristicas }
    end
  end

  # GET /tiposcaracteristicas/1
  # GET /tiposcaracteristicas/1.xml
  def show
    @tiposcaracteristica = Tiposcaracteristica.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposcaracteristica }
    end
  end

  # GET /tiposcaracteristicas/new
  # GET /tiposcaracteristicas/new.xml
  def new
    @tiposcaracteristica = Tiposcaracteristica.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposcaracteristica }
    end
  end

  # GET /tiposcaracteristicas/1/edit
  def edit
    @tiposcaracteristica = Tiposcaracteristica.find(params[:id])
  end

  # POST /tiposcaracteristicas
  # POST /tiposcaracteristicas.xml
  def create
    @tiposcaracteristica = Tiposcaracteristica.new(params[:tiposcaracteristica])

    respond_to do |format|
      if @tiposcaracteristica.save
        flash[:notice] = 'Tiposcaracteristica was successfully created.'
        format.html { redirect_to(@tiposcaracteristica) }
        format.xml  { render :xml => @tiposcaracteristica, :status => :created, :location => @tiposcaracteristica }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposcaracteristica.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposcaracteristicas/1
  # PUT /tiposcaracteristicas/1.xml
  def update
    @tiposcaracteristica = Tiposcaracteristica.find(params[:id])

    respond_to do |format|
      if @tiposcaracteristica.update_attributes(params[:tiposcaracteristica])
        flash[:notice] = 'Tiposcaracteristica was successfully updated.'
        format.html { redirect_to(@tiposcaracteristica) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposcaracteristica.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposcaracteristicas/1
  # DELETE /tiposcaracteristicas/1.xml
  def destroy
    @tiposcaracteristica = Tiposcaracteristica.find(params[:id])
    @tiposcaracteristica.destroy

    respond_to do |format|
      format.html { redirect_to(tiposcaracteristicas_url) }
      format.xml  { head :ok }
    end
  end
end

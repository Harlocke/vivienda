class IguanasactualizacionesController < ApplicationController
  # GET /iguanasactualizaciones
  # GET /iguanasactualizaciones.xml
  def index
    @iguanasactualizaciones = Iguanasactualizacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iguanasactualizaciones }
    end
  end

  # GET /iguanasactualizaciones/1
  # GET /iguanasactualizaciones/1.xml
  def show
    @iguanasactualizacion = Iguanasactualizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @iguanasactualizacion }
    end
  end

  # GET /iguanasactualizaciones/new
  # GET /iguanasactualizaciones/new.xml
  def new
    @iguanasactualizacion = Iguanasactualizacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @iguanasactualizacion }
    end
  end

  # GET /iguanasactualizaciones/1/edit
  def edit
    @iguanasactualizacion = Iguanasactualizacion.find(params[:id])
  end

  # POST /iguanasactualizaciones
  # POST /iguanasactualizaciones.xml
  def create
    @iguanasactualizacion = Iguanasactualizacion.new(params[:iguanasactualizacion])

    respond_to do |format|
      if @iguanasactualizacion.save
        format.html { redirect_to(@iguanasactualizacion, :notice => 'Iguanasactualizacion was successfully created.') }
        format.xml  { render :xml => @iguanasactualizacion, :status => :created, :location => @iguanasactualizacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @iguanasactualizacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /iguanasactualizaciones/1
  # PUT /iguanasactualizaciones/1.xml
  def update
    @iguanasactualizacion = Iguanasactualizacion.find(params[:id])

    respond_to do |format|
      if @iguanasactualizacion.update_attributes(params[:iguanasactualizacion])
        format.html { redirect_to(@iguanasactualizacion, :notice => 'Iguanasactualizacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @iguanasactualizacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /iguanasactualizaciones/1
  # DELETE /iguanasactualizaciones/1.xml
  def destroy
    @iguanasactualizacion = Iguanasactualizacion.find(params[:id])
    @iguanasactualizacion.destroy

    respond_to do |format|
      format.html { redirect_to(iguanasactualizaciones_url) }
      format.xml  { head :ok }
    end
  end
end

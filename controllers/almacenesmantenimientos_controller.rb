class AlmacenesmantenimientosController < ApplicationController
  # GET /almacenesmantenimientos
  # GET /almacenesmantenimientos.xml
  def index
    @almacenesmantenimientos = Almacenesmantenimiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @almacenesmantenimientos }
    end
  end

  # GET /almacenesmantenimientos/1
  # GET /almacenesmantenimientos/1.xml
  def show
    @almacenesmantenimiento = Almacenesmantenimiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @almacenesmantenimiento }
    end
  end

  # GET /almacenesmantenimientos/new
  # GET /almacenesmantenimientos/new.xml
  def new
    @almacenesmantenimiento = Almacenesmantenimiento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @almacenesmantenimiento }
    end
  end

  # GET /almacenesmantenimientos/1/edit
  def edit
    @almacenesmantenimiento = Almacenesmantenimiento.find(params[:id])
  end

  # POST /almacenesmantenimientos
  # POST /almacenesmantenimientos.xml
  def create
    @almacenesmantenimiento = Almacenesmantenimiento.new(params[:almacenesmantenimiento])

    respond_to do |format|
      if @almacenesmantenimiento.save
        format.html { redirect_to(@almacenesmantenimiento, :notice => 'Almacenesmantenimiento was successfully created.') }
        format.xml  { render :xml => @almacenesmantenimiento, :status => :created, :location => @almacenesmantenimiento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @almacenesmantenimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /almacenesmantenimientos/1
  # PUT /almacenesmantenimientos/1.xml
  def update
    @almacenesmantenimiento = Almacenesmantenimiento.find(params[:id])

    respond_to do |format|
      if @almacenesmantenimiento.update_attributes(params[:almacenesmantenimiento])
        format.html { redirect_to(@almacenesmantenimiento, :notice => 'Almacenesmantenimiento was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @almacenesmantenimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /almacenesmantenimientos/1
  # DELETE /almacenesmantenimientos/1.xml
  def destroy
    @almacenesmantenimiento = Almacenesmantenimiento.find(params[:id])
    @almacenesmantenimiento.destroy

    respond_to do |format|
      format.html { redirect_to(almacenesmantenimientos_url) }
      format.xml  { head :ok }
    end
  end
end

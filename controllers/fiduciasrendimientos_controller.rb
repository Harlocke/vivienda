class FiduciasrendimientosController < ApplicationController
  # GET /fiduciasrendimientos
  # GET /fiduciasrendimientos.xml
  def index
    @fiduciasrendimientos = Fiduciasrendimiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fiduciasrendimientos }
    end
  end

  # GET /fiduciasrendimientos/1
  # GET /fiduciasrendimientos/1.xml
  def show
    @fiduciasrendimiento = Fiduciasrendimiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fiduciasrendimiento }
    end
  end

  # GET /fiduciasrendimientos/new
  # GET /fiduciasrendimientos/new.xml
  def new
    @fiduciasrendimiento = Fiduciasrendimiento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fiduciasrendimiento }
    end
  end

  # GET /fiduciasrendimientos/1/edit
  def edit
    @fiduciasrendimiento = Fiduciasrendimiento.find(params[:id])
  end

  # POST /fiduciasrendimientos
  # POST /fiduciasrendimientos.xml
  def create
    @fiduciasrendimiento = Fiduciasrendimiento.new(params[:fiduciasrendimiento])

    respond_to do |format|
      if @fiduciasrendimiento.save
        format.html { redirect_to(@fiduciasrendimiento, :notice => 'Fiduciasrendimiento was successfully created.') }
        format.xml  { render :xml => @fiduciasrendimiento, :status => :created, :location => @fiduciasrendimiento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fiduciasrendimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fiduciasrendimientos/1
  # PUT /fiduciasrendimientos/1.xml
  def update
    @fiduciasrendimiento = Fiduciasrendimiento.find(params[:id])

    respond_to do |format|
      if @fiduciasrendimiento.update_attributes(params[:fiduciasrendimiento])
        format.html { redirect_to(@fiduciasrendimiento, :notice => 'Fiduciasrendimiento was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fiduciasrendimiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fiduciasrendimientos/1
  # DELETE /fiduciasrendimientos/1.xml
  def destroy
    @fiduciasrendimiento = Fiduciasrendimiento.find(params[:id])
    @fiduciasrendimiento.destroy

    respond_to do |format|
      format.html { redirect_to(fiduciasrendimientos_url) }
      format.xml  { head :ok }
    end
  end
end

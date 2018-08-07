class EmpleadosgruposController < ApplicationController
  # GET /empleadosgrupos
  # GET /empleadosgrupos.xml
  def index
    @empleadosgrupos = Empleadosgrupo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @empleadosgrupos }
    end
  end

  # GET /empleadosgrupos/1
  # GET /empleadosgrupos/1.xml
  def show
    @empleadosgrupo = Empleadosgrupo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @empleadosgrupo }
    end
  end

  # GET /empleadosgrupos/new
  # GET /empleadosgrupos/new.xml
  def new
    @empleadosgrupo = Empleadosgrupo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @empleadosgrupo }
    end
  end

  # GET /empleadosgrupos/1/edit
  def edit
    @empleadosgrupo = Empleadosgrupo.find(params[:id])
  end

  # POST /empleadosgrupos
  # POST /empleadosgrupos.xml
  def create
    @empleadosgrupo = Empleadosgrupo.new(params[:empleadosgrupo])

    respond_to do |format|
      if @empleadosgrupo.save
        format.html { redirect_to(@empleadosgrupo, :notice => 'Empleadosgrupo was successfully created.') }
        format.xml  { render :xml => @empleadosgrupo, :status => :created, :location => @empleadosgrupo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empleadosgrupo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /empleadosgrupos/1
  # PUT /empleadosgrupos/1.xml
  def update
    @empleadosgrupo = Empleadosgrupo.find(params[:id])

    respond_to do |format|
      if @empleadosgrupo.update_attributes(params[:empleadosgrupo])
        format.html { redirect_to(@empleadosgrupo, :notice => 'Empleadosgrupo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @empleadosgrupo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /empleadosgrupos/1
  # DELETE /empleadosgrupos/1.xml
  def destroy
    @empleadosgrupo = Empleadosgrupo.find(params[:id])
    @empleadosgrupo.destroy

    respond_to do |format|
      format.html { redirect_to(empleadosgrupos_url) }
      format.xml  { head :ok }
    end
  end
end

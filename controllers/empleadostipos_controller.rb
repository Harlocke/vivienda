class EmpleadostiposController < ApplicationController
  # GET /empleadostipos
  # GET /empleadostipos.xml
  def index
    @empleadostipos = Empleadostipo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @empleadostipos }
    end
  end

  # GET /empleadostipos/1
  # GET /empleadostipos/1.xml
  def show
    @empleadostipo = Empleadostipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @empleadostipo }
    end
  end

  # GET /empleadostipos/new
  # GET /empleadostipos/new.xml
  def new
    @empleadostipo = Empleadostipo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @empleadostipo }
    end
  end

  # GET /empleadostipos/1/edit
  def edit
    @empleadostipo = Empleadostipo.find(params[:id])
  end

  # POST /empleadostipos
  # POST /empleadostipos.xml
  def create
    @empleadostipo = Empleadostipo.new(params[:empleadostipo])

    respond_to do |format|
      if @empleadostipo.save
        format.html { redirect_to(@empleadostipo, :notice => 'Empleadostipo was successfully created.') }
        format.xml  { render :xml => @empleadostipo, :status => :created, :location => @empleadostipo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empleadostipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /empleadostipos/1
  # PUT /empleadostipos/1.xml
  def update
    @empleadostipo = Empleadostipo.find(params[:id])

    respond_to do |format|
      if @empleadostipo.update_attributes(params[:empleadostipo])
        format.html { redirect_to(@empleadostipo, :notice => 'Empleadostipo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @empleadostipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /empleadostipos/1
  # DELETE /empleadostipos/1.xml
  def destroy
    @empleadostipo = Empleadostipo.find(params[:id])
    @empleadostipo.destroy

    respond_to do |format|
      format.html { redirect_to(empleadostipos_url) }
      format.xml  { head :ok }
    end
  end
end

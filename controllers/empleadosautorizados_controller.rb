class EmpleadosautorizadosController < ApplicationController
  # GET /empleadosautorizados
  # GET /empleadosautorizados.xml
  def index
    @empleadosautorizados = Empleadosautorizado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @empleadosautorizados }
    end
  end

  # GET /empleadosautorizados/1
  # GET /empleadosautorizados/1.xml
  def show
    @empleadosautorizado = Empleadosautorizado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @empleadosautorizado }
    end
  end

  # GET /empleadosautorizados/new
  # GET /empleadosautorizados/new.xml
  def new
    @empleadosautorizado = Empleadosautorizado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @empleadosautorizado }
    end
  end

  # GET /empleadosautorizados/1/edit
  def edit
    @empleadosautorizado = Empleadosautorizado.find(params[:id])
  end

  # POST /empleadosautorizados
  # POST /empleadosautorizados.xml
  def create
    @empleadosautorizado = Empleadosautorizado.new(params[:empleadosautorizado])

    respond_to do |format|
      if @empleadosautorizado.save
        format.html { redirect_to(@empleadosautorizado, :notice => 'Empleadosautorizado was successfully created.') }
        format.xml  { render :xml => @empleadosautorizado, :status => :created, :location => @empleadosautorizado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empleadosautorizado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /empleadosautorizados/1
  # PUT /empleadosautorizados/1.xml
  def update
    @empleadosautorizado = Empleadosautorizado.find(params[:id])

    respond_to do |format|
      if @empleadosautorizado.update_attributes(params[:empleadosautorizado])
        format.html { redirect_to(@empleadosautorizado, :notice => 'Empleadosautorizado was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @empleadosautorizado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /empleadosautorizados/1
  # DELETE /empleadosautorizados/1.xml
  def destroy
    @empleadosautorizado = Empleadosautorizado.find(params[:id])
    @empleadosautorizado.destroy

    respond_to do |format|
      format.html { redirect_to(empleadosautorizados_url) }
      format.xml  { head :ok }
    end
  end
end

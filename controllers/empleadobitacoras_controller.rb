class EmpleadobitacorasController < ApplicationController
  # GET /empleadobitacoras
  # GET /empleadobitacoras.xml
  def index
    @empleadobitacoras = Empleadobitacora.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @empleadobitacoras }
    end
  end

  # GET /empleadobitacoras/1
  # GET /empleadobitacoras/1.xml
  def show
    @empleadobitacora = Empleadobitacora.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @empleadobitacora }
    end
  end

  # GET /empleadobitacoras/new
  # GET /empleadobitacoras/new.xml
  def new
    @empleadobitacora = Empleadobitacora.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @empleadobitacora }
    end
  end

  # GET /empleadobitacoras/1/edit
  def edit
    @empleadobitacora = Empleadobitacora.find(params[:id])
  end

  # POST /empleadobitacoras
  # POST /empleadobitacoras.xml
  def create
    @empleadobitacora = Empleadobitacora.new(params[:empleadobitacora])

    respond_to do |format|
      if @empleadobitacora.save
        format.html { redirect_to(@empleadobitacora, :notice => 'Empleadobitacora was successfully created.') }
        format.xml  { render :xml => @empleadobitacora, :status => :created, :location => @empleadobitacora }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @empleadobitacora.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /empleadobitacoras/1
  # PUT /empleadobitacoras/1.xml
  def update
    @empleadobitacora = Empleadobitacora.find(params[:id])

    respond_to do |format|
      if @empleadobitacora.update_attributes(params[:empleadobitacora])
        format.html { redirect_to(@empleadobitacora, :notice => 'Empleadobitacora was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @empleadobitacora.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /empleadobitacoras/1
  # DELETE /empleadobitacoras/1.xml
  def destroy
    @empleadobitacora = Empleadobitacora.find(params[:id])
    @empleadobitacora.destroy

    respond_to do |format|
      format.html { redirect_to(empleadobitacoras_url) }
      format.xml  { head :ok }
    end
  end
end

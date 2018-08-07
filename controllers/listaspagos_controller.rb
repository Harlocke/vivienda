class ListaspagosController < ApplicationController
  # GET /listaspagos
  # GET /listaspagos.xml
  def index
    @listaspagos = Listaspago.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listaspagos }
    end
  end

  # GET /listaspagos/1
  # GET /listaspagos/1.xml
  def show
    @listaspago = Listaspago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @listaspago }
    end
  end

  # GET /listaspagos/new
  # GET /listaspagos/new.xml
  def new
    @listaspago = Listaspago.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @listaspago }
    end
  end

  # GET /listaspagos/1/edit
  def edit
    @listaspago = Listaspago.find(params[:id])
  end

  # POST /listaspagos
  # POST /listaspagos.xml
  def create
    @listaspago = Listaspago.new(params[:listaspago])

    respond_to do |format|
      if @listaspago.save
        format.html { redirect_to(@listaspago, :notice => 'Listaspago was successfully created.') }
        format.xml  { render :xml => @listaspago, :status => :created, :location => @listaspago }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @listaspago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /listaspagos/1
  # PUT /listaspagos/1.xml
  def update
    @listaspago = Listaspago.find(params[:id])

    respond_to do |format|
      if @listaspago.update_attributes(params[:listaspago])
        format.html { redirect_to(@listaspago, :notice => 'Listaspago was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @listaspago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /listaspagos/1
  # DELETE /listaspagos/1.xml
  def destroy
    @listaspago = Listaspago.find(params[:id])
    @listaspago.destroy

    respond_to do |format|
      format.html { redirect_to(listaspagos_url) }
      format.xml  { head :ok }
    end
  end
end

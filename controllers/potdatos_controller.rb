class PotdatosController < ApplicationController
  # GET /potdatos
  # GET /potdatos.xml
  def index
    @potdatos = Potdato.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @potdatos }
    end
  end

  # GET /potdatos/1
  # GET /potdatos/1.xml
  def show
    @potdato = Potdato.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @potdato }
    end
  end

  # GET /potdatos/new
  # GET /potdatos/new.xml
  def new
    @potdato = Potdato.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @potdato }
    end
  end

  # GET /potdatos/1/edit
  def edit
    @potdato = Potdato.find(params[:id])
  end

  # POST /potdatos
  # POST /potdatos.xml
  def create
    @potdato = Potdato.new(params[:potdato])

    respond_to do |format|
      if @potdato.save
        format.html { redirect_to(@potdato, :notice => 'Potdato was successfully created.') }
        format.xml  { render :xml => @potdato, :status => :created, :location => @potdato }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @potdato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /potdatos/1
  # PUT /potdatos/1.xml
  def update
    @potdato = Potdato.find(params[:id])

    respond_to do |format|
      if @potdato.update_attributes(params[:potdato])
        format.html { redirect_to(@potdato, :notice => 'Potdato was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @potdato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /potdatos/1
  # DELETE /potdatos/1.xml
  def destroy
    @potdato = Potdato.find(params[:id])
    @potdato.destroy

    respond_to do |format|
      format.html { redirect_to(potdatos_url) }
      format.xml  { head :ok }
    end
  end
end

class AetapasController < ApplicationController
  # GET /aetapas
  # GET /aetapas.xml
  def index
    @aetapas = Aetapa.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @aetapas }
    end
  end

  # GET /aetapas/1
  # GET /aetapas/1.xml
  def show
    @aetapa = Aetapa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aetapa }
    end
  end

  # GET /aetapas/new
  # GET /aetapas/new.xml
  def new
    @aetapa = Aetapa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @aetapa }
    end
  end

  # GET /aetapas/1/edit
  def edit
    @aetapa = Aetapa.find(params[:id])
  end

  # POST /aetapas
  # POST /aetapas.xml
  def create
    @aetapa = Aetapa.new(params[:aetapa])

    respond_to do |format|
      if @aetapa.save
        format.html { redirect_to(@aetapa, :notice => 'Aetapa was successfully created.') }
        format.xml  { render :xml => @aetapa, :status => :created, :location => @aetapa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @aetapa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /aetapas/1
  # PUT /aetapas/1.xml
  def update
    @aetapa = Aetapa.find(params[:id])

    respond_to do |format|
      if @aetapa.update_attributes(params[:aetapa])
        format.html { redirect_to(@aetapa, :notice => 'Aetapa was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @aetapa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /aetapas/1
  # DELETE /aetapas/1.xml
  def destroy
    @aetapa = Aetapa.find(params[:id])
    @aetapa.destroy

    respond_to do |format|
      format.html { redirect_to(aetapas_url) }
      format.xml  { head :ok }
    end
  end
end

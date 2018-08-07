class AptosController < ApplicationController

  before_filter :require_user

  def index
    @aptos = Apto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @aptos }
    end
  end

  # GET /aptos/1
  # GET /aptos/1.xml
  def show
    @apto = Apto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @apto }
    end
  end

  # GET /aptos/new
  # GET /aptos/new.xml
  def new
    @apto = Apto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @apto }
    end
  end

  # GET /aptos/1/edit
  def edit
    @apto = Apto.find(params[:id])
  end

  # POST /aptos
  # POST /aptos.xml
  def create
    @apto = Apto.new(params[:apto])

    respond_to do |format|
      if @apto.save
        flash[:notice] = 'Apto was successfully created.'
        format.html { redirect_to(@apto) }
        format.xml  { render :xml => @apto, :status => :created, :location => @apto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @apto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /aptos/1
  # PUT /aptos/1.xml
  def update
    @apto = Apto.find(params[:id])

    respond_to do |format|
      if @apto.update_attributes(params[:apto])
        flash[:notice] = 'Apto was successfully updated.'
        format.html { redirect_to(@apto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @apto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /aptos/1
  # DELETE /aptos/1.xml
  def destroy
    @apto = Apto.find(params[:id])
    @apto.destroy

    respond_to do |format|
      format.html { redirect_to(aptos_url) }
      format.xml  { head :ok }
    end
  end
end

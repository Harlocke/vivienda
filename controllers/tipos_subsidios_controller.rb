class TiposSubsidiosController < ApplicationController

  before_filter :require_user

  def index
    @tipos_subsidios = TiposSubsidio.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipos_subsidios }
    end
  end

  # GET /tipos_subsidios/1
  # GET /tipos_subsidios/1.xml
  def show
    @tipos_subsidio = TiposSubsidio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipos_subsidio }
    end
  end

  # GET /tipos_subsidios/new
  # GET /tipos_subsidios/new.xml
  def new
    @tipos_subsidio = TiposSubsidio.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipos_subsidio }
    end
  end

  # GET /tipos_subsidios/1/edit
  def edit
    @tipos_subsidio = TiposSubsidio.find(params[:id])
  end

  # POST /tipos_subsidios
  # POST /tipos_subsidios.xml
  def create
    @tipos_subsidio = TiposSubsidio.new(params[:tipos_subsidio])

    respond_to do |format|
      if @tipos_subsidio.save
        format.html { redirect_to(@tipos_subsidio, :notice => 'TiposSubsidio was successfully created.') }
        format.xml  { render :xml => @tipos_subsidio, :status => :created, :location => @tipos_subsidio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipos_subsidio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipos_subsidios/1
  # PUT /tipos_subsidios/1.xml
  def update
    @tipos_subsidio = TiposSubsidio.find(params[:id])

    respond_to do |format|
      if @tipos_subsidio.update_attributes(params[:tipos_subsidio])
        format.html { redirect_to(@tipos_subsidio, :notice => 'TiposSubsidio was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipos_subsidio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipos_subsidios/1
  # DELETE /tipos_subsidios/1.xml
  def destroy
    @tipos_subsidio = TiposSubsidio.find(params[:id])
    @tipos_subsidio.destroy

    respond_to do |format|
      format.html { redirect_to(tipos_subsidios_url) }
      format.xml  { head :ok }
    end
  end
end

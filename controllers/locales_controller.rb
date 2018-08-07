class LocalesController < ApplicationController

  before_filter :require_user

  def index
    @locales = Local.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locales }
    end
  end

  # GET /locales/1
  # GET /locales/1.xml
  def show
    @local = Local.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @local }
    end
  end

  # GET /locales/new
  # GET /locales/new.xml
  def new
    @local = Local.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @local }
    end
  end

  # GET /locales/1/edit
  def edit
    @local = Local.find(params[:id])
  end

  # POST /locales
  # POST /locales.xml
  def create
    @local = Local.new(params[:local])

    respond_to do |format|
      if @local.save
        flash[:notice] = 'Local was successfully created.'
        format.html { redirect_to(@local) }
        format.xml  { render :xml => @local, :status => :created, :location => @local }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @local.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locales/1
  # PUT /locales/1.xml
  def update
    @local = Local.find(params[:id])

    respond_to do |format|
      if @local.update_attributes(params[:local])
        flash[:notice] = 'Local was successfully updated.'
        format.html { redirect_to(@local) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @local.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locales/1
  # DELETE /locales/1.xml
  def destroy
    @local = Local.find(params[:id])
    @local.destroy

    respond_to do |format|
      format.html { redirect_to(locales_url) }
      format.xml  { head :ok }
    end
  end
end

class EspecialesController < ApplicationController

  before_filter :require_user

  def index
    @especiales = Especial.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @especiales }
    end
  end

  # GET /especiales/1
  # GET /especiales/1.xml
  def show
    @especial = Especial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @especial }
    end
  end

  # GET /especiales/new
  # GET /especiales/new.xml
  def new
    @especial = Especial.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @especial }
    end
  end

  # GET /especiales/1/edit
  def edit
    @especial = Especial.find(params[:id])
  end

  # POST /especiales
  # POST /especiales.xml
  def create
    @especial = Especial.new(params[:especial])

    respond_to do |format|
      if @especial.save
        flash[:notice] = 'Especial was successfully created.'
        format.html { redirect_to(@especial) }
        format.xml  { render :xml => @especial, :status => :created, :location => @especial }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @especial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /especiales/1
  # PUT /especiales/1.xml
  def update
    @especial = Especial.find(params[:id])

    respond_to do |format|
      if @especial.update_attributes(params[:especial])
        flash[:notice] = 'Especial was successfully updated.'
        format.html { redirect_to(@especial) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @especial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /especiales/1
  # DELETE /especiales/1.xml
  def destroy
    @especial = Especial.find(params[:id])
    @especial.destroy

    respond_to do |format|
      format.html { redirect_to(especiales_url) }
      format.xml  { head :ok }
    end
  end
end

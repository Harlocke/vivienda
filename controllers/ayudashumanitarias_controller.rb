class AyudashumanitariasController < ApplicationController

  before_filter :require_user
  
  # GET /ayudashumanitarias
  # GET /ayudashumanitarias.xml
  def index
    @ayudashumanitarias = Ayudashumanitaria.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ayudashumanitarias }
    end
  end

  # GET /ayudashumanitarias/1
  # GET /ayudashumanitarias/1.xml
  def show
    @ayudashumanitaria = Ayudashumanitaria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ayudashumanitaria }
    end
  end

  # GET /ayudashumanitarias/new
  # GET /ayudashumanitarias/new.xml
  def new
    @ayudashumanitaria = Ayudashumanitaria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ayudashumanitaria }
    end
  end

  # GET /ayudashumanitarias/1/edit
  def edit
    @ayudashumanitaria = Ayudashumanitaria.find(params[:id])
  end

  # POST /ayudashumanitarias
  # POST /ayudashumanitarias.xml
  def create
    @ayudashumanitaria = Ayudashumanitaria.new(params[:ayudashumanitaria])

    respond_to do |format|
      if @ayudashumanitaria.save
        flash[:notice] = 'Ayudashumanitaria was successfully created.'
        format.html { redirect_to(@ayudashumanitaria) }
        format.xml  { render :xml => @ayudashumanitaria, :status => :created, :location => @ayudashumanitaria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ayudashumanitaria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ayudashumanitarias/1
  # PUT /ayudashumanitarias/1.xml
  def update
    @ayudashumanitaria = Ayudashumanitaria.find(params[:id])

    respond_to do |format|
      if @ayudashumanitaria.update_attributes(params[:ayudashumanitaria])
        flash[:notice] = 'Ayudashumanitaria was successfully updated.'
        format.html { redirect_to(@ayudashumanitaria) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ayudashumanitaria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ayudashumanitarias/1
  # DELETE /ayudashumanitarias/1.xml
  def destroy
    @ayudashumanitaria = Ayudashumanitaria.find(params[:id])
    @ayudashumanitaria.destroy

    respond_to do |format|
      format.html { redirect_to(ayudashumanitarias_url) }
      format.xml  { head :ok }
    end
  end
end

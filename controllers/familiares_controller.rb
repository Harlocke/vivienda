class FamiliaresController < ApplicationController

  before_filter :require_user

  def index
    @familiares = Familiar.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @familiares }
    end
  end

  # GET /familiares/1
  # GET /familiares/1.xml
  def show
    @familiar = Familiar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @familiar }
    end
  end

  # GET /familiares/new
  # GET /familiares/new.xml
  def new
    @familiar = Familiar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @familiar }
    end
  end

  # GET /familiares/1/edit
  def edit
    @familiar = Familiar.find(params[:id])
  end

  # POST /familiares
  # POST /familiares.xml
  def create
    @familiar = Familiar.new(params[:familiar])

    respond_to do |format|
      if @familiar.save
        flash[:notice] = 'Familiar was successfully created.'
        format.html { redirect_to(@familiar) }
        format.xml  { render :xml => @familiar, :status => :created, :location => @familiar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @familiar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /familiares/1
  # PUT /familiares/1.xml
  def update
    @familiar = Familiar.find(params[:id])

    respond_to do |format|
      if @familiar.update_attributes(params[:familiar])
        flash[:notice] = 'Familiar was successfully updated.'
        format.html { redirect_to(@familiar) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @familiar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /familiares/1
  # DELETE /familiares/1.xml
  def destroy
    @familiar = Familiar.find(params[:id])
    @familiar.destroy

    respond_to do |format|
      format.html { redirect_to(familiares_url) }
      format.xml  { head :ok }
    end
  end
end

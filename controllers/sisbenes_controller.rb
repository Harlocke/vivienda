class SisbenesController < ApplicationController
  before_filter :require_user

  def index
    @sisbenes = Sisben.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sisbenes }
    end
  end

  # GET /sisbenes/1
  # GET /sisbenes/1.xml
  def show
    @sisben = Sisben.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sisben }
    end
  end

  # GET /sisbenes/new
  # GET /sisbenes/new.xml
  def new
    @sisben = Sisben.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sisben }
    end
  end

  # GET /sisbenes/1/edit
  def edit
    @sisben = Sisben.find(params[:id])
  end

  # POST /sisbenes
  # POST /sisbenes.xml
  def create
    @sisben = Sisben.new(params[:sisben])

    respond_to do |format|
      if @sisben.save
        flash[:notice] = 'Sisben was successfully created.'
        format.html { redirect_to(@sisben) }
        format.xml  { render :xml => @sisben, :status => :created, :location => @sisben }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sisben.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sisbenes/1
  # PUT /sisbenes/1.xml
  def update
    @sisben = Sisben.find(params[:id])

    respond_to do |format|
      if @sisben.update_attributes(params[:sisben])
        flash[:notice] = 'Sisben was successfully updated.'
        format.html { redirect_to(@sisben) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sisben.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sisbenes/1
  # DELETE /sisbenes/1.xml
  def destroy
    @sisben = Sisben.find(params[:id])
    @sisben.destroy

    respond_to do |format|
      format.html { redirect_to(sisbenes_url) }
      format.xml  { head :ok }
    end
  end
end

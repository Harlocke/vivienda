class AgendasusersController < ApplicationController
  # GET /agendasusers
  # GET /agendasusers.xml
  def index
    @agendasusers = Agendasuser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @agendasusers }
    end
  end

  # GET /agendasusers/1
  # GET /agendasusers/1.xml
  def show
    @agendasuser = Agendasuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @agendasuser }
    end
  end

  # GET /agendasusers/new
  # GET /agendasusers/new.xml
  def new
    @agendasuser = Agendasuser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @agendasuser }
    end
  end

  # GET /agendasusers/1/edit
  def edit
    @agendasuser = Agendasuser.find(params[:id])
  end

  # POST /agendasusers
  # POST /agendasusers.xml
  def create
    @agendasuser = Agendasuser.new(params[:agendasuser])

    respond_to do |format|
      if @agendasuser.save
        format.html { redirect_to(@agendasuser, :notice => 'Agendasuser was successfully created.') }
        format.xml  { render :xml => @agendasuser, :status => :created, :location => @agendasuser }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @agendasuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /agendasusers/1
  # PUT /agendasusers/1.xml
  def update
    @agendasuser = Agendasuser.find(params[:id])

    respond_to do |format|
      if @agendasuser.update_attributes(params[:agendasuser])
        format.html { redirect_to(@agendasuser, :notice => 'Agendasuser was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agendasuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /agendasusers/1
  # DELETE /agendasusers/1.xml
  def destroy
    @agendasuser = Agendasuser.find(params[:id])
    @agendasuser.destroy

    respond_to do |format|
      format.html { redirect_to(agendasusers_url) }
      format.xml  { head :ok }
    end
  end
end

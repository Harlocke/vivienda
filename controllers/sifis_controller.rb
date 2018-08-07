class SifisController < ApplicationController
  
  before_filter :require_user
  def index
    @sifis = Sifi.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sifis }
    end
  end

  # GET /sifis/1
  # GET /sifis/1.xml
  def show
    @sifi = Sifi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sifi }
    end
  end

  # GET /sifis/new
  # GET /sifis/new.xml
  def new
    @sifi = Sifi.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sifi }
    end
  end

  # GET /sifis/1/edit
  def edit
    @sifi = Sifi.find(params[:id])
  end

  # POST /sifis
  # POST /sifis.xml
  def create
    @sifi = Sifi.new(params[:sifi])

    respond_to do |format|
      if @sifi.save
        flash[:notice] = 'Sifi was successfully created.'
        format.html { redirect_to(@sifi) }
        format.xml  { render :xml => @sifi, :status => :created, :location => @sifi }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sifi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sifis/1
  # PUT /sifis/1.xml
  def update
    @sifi = Sifi.find(params[:id])

    respond_to do |format|
      if @sifi.update_attributes(params[:sifi])
        flash[:notice] = 'Sifi was successfully updated.'
        format.html { redirect_to(@sifi) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sifi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sifis/1
  # DELETE /sifis/1.xml
  def destroy
    @sifi = Sifi.find(params[:id])
    @sifi.destroy

    respond_to do |format|
      format.html { redirect_to(sifis_url) }
      format.xml  { head :ok }
    end
  end

  def act
    @user = User.find(params[:id])
    @user.activo = 'S'
    @user.save
    flash[:notice] = "Activado"
    redirect_to users_path
  end

  def bact
    @user = User.find(params[:id])
    @user.activo = 'N'
    @user.save
    flash[:notice] = "Inactivado"
    redirect_to users_path
  end      
end

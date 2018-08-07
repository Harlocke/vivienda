class ComunicacionesusersController < ApplicationController
  # GET /comunicacionesusers
  # GET /comunicacionesusers.xml
  def index
    @comunicacionesusers = Comunicacionesuser.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comunicacionesusers }
    end
  end

  # GET /comunicacionesusers/1
  # GET /comunicacionesusers/1.xml
  def show
    @comunicacionesuser = Comunicacionesuser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comunicacionesuser }
    end
  end

  # GET /comunicacionesusers/new
  # GET /comunicacionesusers/new.xml
  def new
    @comunicacionesuser = Comunicacionesuser.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comunicacionesuser }
    end
  end

  # GET /comunicacionesusers/1/edit
  def edit
    @comunicacionesuser = Comunicacionesuser.find(params[:id])
  end

  # POST /comunicacionesusers
  # POST /comunicacionesusers.xml
  def create
    @comunicacionesuser = Comunicacionesuser.new(params[:comunicacionesuser])

    respond_to do |format|
      if @comunicacionesuser.save
        format.html { redirect_to(@comunicacionesuser, :notice => 'Comunicacionesuser was successfully created.') }
        format.xml  { render :xml => @comunicacionesuser, :status => :created, :location => @comunicacionesuser }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comunicacionesuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comunicacionesusers/1
  # PUT /comunicacionesusers/1.xml
  def update
    @comunicacionesuser = Comunicacionesuser.find(params[:id])

    respond_to do |format|
      if @comunicacionesuser.update_attributes(params[:comunicacionesuser])
        format.html { redirect_to(@comunicacionesuser, :notice => 'Comunicacionesuser was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comunicacionesuser.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comunicacionesusers/1
  # DELETE /comunicacionesusers/1.xml
  def destroy
    @comunicacionesuser = Comunicacionesuser.find(params[:id])
    @comunicacionesuser.destroy

    respond_to do |format|
      format.html { redirect_to(comunicacionesusers_url) }
      format.xml  { head :ok }
    end
  end
end

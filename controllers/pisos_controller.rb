class PisosController < ApplicationController

  before_filter :require_user

  def index
    @pisos = Piso.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pisos }
    end
  end

  # GET /pisos/1
  # GET /pisos/1.xml
  def show
    @piso = Piso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @piso }
    end
  end

  # GET /pisos/new
  # GET /pisos/new.xml
  def new
    @piso = Piso.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @piso }
    end
  end

  # GET /pisos/1/edit
  def edit
    @piso = Piso.find(params[:id])
  end

  # POST /pisos
  # POST /pisos.xml
  def create
    @piso = Piso.new(params[:piso])

    respond_to do |format|
      if @piso.save
        flash[:notice] = 'Piso was successfully created.'
        format.html { redirect_to(@piso) }
        format.xml  { render :xml => @piso, :status => :created, :location => @piso }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @piso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pisos/1
  # PUT /pisos/1.xml
  def update
    @piso = Piso.find(params[:id])

    respond_to do |format|
      if @piso.update_attributes(params[:piso])
        flash[:notice] = 'Piso was successfully updated.'
        format.html { redirect_to(@piso) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @piso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pisos/1
  # DELETE /pisos/1.xml
  def destroy
    @piso = Piso.find(params[:id])
    @piso.destroy

    respond_to do |format|
      format.html { redirect_to(pisos_url) }
      format.xml  { head :ok }
    end
  end
end

class PoblacionesespecialesController < ApplicationController
  before_filter :require_user
  # GET /poblacionesespeciales
  # GET /poblacionesespeciales.xml
  def index
    @poblacionesespeciales = Poblacionesespecial.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @poblacionesespeciales }
    end
  end

  # GET /poblacionesespeciales/1
  # GET /poblacionesespeciales/1.xml
  def show
    @poblacionesespecial = Poblacionesespecial.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @poblacionesespecial }
    end
  end

  # GET /poblacionesespeciales/new
  # GET /poblacionesespeciales/new.xml
  def new
    @poblacionesespecial = Poblacionesespecial.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @poblacionesespecial }
    end
  end

  # GET /poblacionesespeciales/1/edit
  def edit
    @poblacionesespecial = Poblacionesespecial.find(params[:id])
  end

  # POST /poblacionesespeciales
  # POST /poblacionesespeciales.xml
  def create
    @poblacionesespecial = Poblacionesespecial.new(params[:poblacionesespecial])

    respond_to do |format|
      if @poblacionesespecial.save
        flash[:notice] = 'Poblacionesespecial was successfully created.'
        format.html { redirect_to(@poblacionesespecial) }
        format.xml  { render :xml => @poblacionesespecial, :status => :created, :location => @poblacionesespecial }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @poblacionesespecial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /poblacionesespeciales/1
  # PUT /poblacionesespeciales/1.xml
  def update
    @poblacionesespecial = Poblacionesespecial.find(params[:id])

    respond_to do |format|
      if @poblacionesespecial.update_attributes(params[:poblacionesespecial])
        flash[:notice] = 'Poblacionesespecial was successfully updated.'
        format.html { redirect_to(@poblacionesespecial) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @poblacionesespecial.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /poblacionesespeciales/1
  # DELETE /poblacionesespeciales/1.xml
  def destroy
    @poblacionesespecial = Poblacionesespecial.find(params[:id])
    @poblacionesespecial.destroy

    respond_to do |format|
      format.html { redirect_to(poblacionesespeciales_url) }
      format.xml  { head :ok }
    end
  end
end

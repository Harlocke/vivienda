class CorrespondenciasclasesController < ApplicationController
  # GET /correspondenciasclases
  # GET /correspondenciasclases.xml
  def index
    @correspondenciasclases = Correspondenciasclase.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @correspondenciasclases }
    end
  end

  # GET /correspondenciasclases/1
  # GET /correspondenciasclases/1.xml
  def show
    @correspondenciasclase = Correspondenciasclase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @correspondenciasclase }
    end
  end

  # GET /correspondenciasclases/new
  # GET /correspondenciasclases/new.xml
  def new
    @correspondenciasclase = Correspondenciasclase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @correspondenciasclase }
    end
  end

  # GET /correspondenciasclases/1/edit
  def edit
    @correspondenciasclase = Correspondenciasclase.find(params[:id])
  end

  # POST /correspondenciasclases
  # POST /correspondenciasclases.xml
  def create
    @correspondenciasclase = Correspondenciasclase.new(params[:correspondenciasclase])

    respond_to do |format|
      if @correspondenciasclase.save
        flash[:notice] = 'Correspondenciasclase was successfully created.'
        format.html { redirect_to(@correspondenciasclase) }
        format.xml  { render :xml => @correspondenciasclase, :status => :created, :location => @correspondenciasclase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @correspondenciasclase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /correspondenciasclases/1
  # PUT /correspondenciasclases/1.xml
  def update
    @correspondenciasclase = Correspondenciasclase.find(params[:id])

    respond_to do |format|
      if @correspondenciasclase.update_attributes(params[:correspondenciasclase])
        flash[:notice] = 'Correspondenciasclase was successfully updated.'
        format.html { redirect_to(@correspondenciasclase) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @correspondenciasclase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /correspondenciasclases/1
  # DELETE /correspondenciasclases/1.xml
  def destroy
    @correspondenciasclase = Correspondenciasclase.find(params[:id])
    @correspondenciasclase.destroy

    respond_to do |format|
      format.html { redirect_to(correspondenciasclases_url) }
      format.xml  { head :ok }
    end
  end
end

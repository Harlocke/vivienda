class CatastrosController < ApplicationController
  before_filter :require_user
  def index
    #@catastros = Catastro.all

    respond_to do |format|
      format.html # index.html.erb
      #format.xml  { render :xml => @catastros }
    end
  end

  # GET /catastros/1
  # GET /catastros/1.xml
  def show
    @catastro = Catastro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catastro }
    end
  end

  # GET /catastros/new
  # GET /catastros/new.xml
  def new
    @catastro = Catastro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catastro }
    end
  end

  # GET /catastros/1/edit
  def edit
    @catastro = Catastro.find(params[:id])
  end

  # POST /catastros
  # POST /catastros.xml
  def create
    @catastro = Catastro.new(params[:catastro])

    respond_to do |format|
      if @catastro.save
        flash[:notice] = 'Catastro was successfully created.'
        format.html { redirect_to(@catastro) }
        format.xml  { render :xml => @catastro, :status => :created, :location => @catastro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catastro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catastros/1
  # PUT /catastros/1.xml
  def update
    @catastro = Catastro.find(params[:id])

    respond_to do |format|
      if @catastro.update_attributes(params[:catastro])
        flash[:notice] = 'Catastro was successfully updated.'
        format.html { redirect_to(@catastro) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catastro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catastros/1
  # DELETE /catastros/1.xml
  def destroy
    @catastro = Catastro.find(params[:id])
    @catastro.destroy

    respond_to do |format|
      format.html { redirect_to(catastros_url) }
      format.xml  { head :ok }
    end
  end
end

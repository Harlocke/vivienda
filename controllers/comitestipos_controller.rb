class ComitestiposController < ApplicationController
  # GET /comitestipos
  # GET /comitestipos.xml
  def index
    @comitestipos = Comitestipo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comitestipos }
    end
  end

  # GET /comitestipos/1
  # GET /comitestipos/1.xml
  def show
    @comitestipo = Comitestipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comitestipo }
    end
  end

  # GET /comitestipos/new
  # GET /comitestipos/new.xml
  def new
    @comitestipo = Comitestipo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comitestipo }
    end
  end

  # GET /comitestipos/1/edit
  def edit
    @comitestipo = Comitestipo.find(params[:id])
  end

  # POST /comitestipos
  # POST /comitestipos.xml
  def create
    @comitestipo = Comitestipo.new(params[:comitestipo])

    respond_to do |format|
      if @comitestipo.save
        flash[:notice] = 'Comitestipo was successfully created.'
        format.html { redirect_to(@comitestipo) }
        format.xml  { render :xml => @comitestipo, :status => :created, :location => @comitestipo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comitestipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comitestipos/1
  # PUT /comitestipos/1.xml
  def update
    @comitestipo = Comitestipo.find(params[:id])

    respond_to do |format|
      if @comitestipo.update_attributes(params[:comitestipo])
        flash[:notice] = 'Comitestipo was successfully updated.'
        format.html { redirect_to(@comitestipo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comitestipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comitestipos/1
  # DELETE /comitestipos/1.xml
  def destroy
    @comitestipo = Comitestipo.find(params[:id])
    @comitestipo.destroy

    respond_to do |format|
      format.html { redirect_to(comitestipos_url) }
      format.xml  { head :ok }
    end
  end
end

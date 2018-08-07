class BdhogaresbienestaresController < ApplicationController
  # GET /bdhogaresbienestares
  # GET /bdhogaresbienestares.xml
  def index
    @bdhogaresbienestares = Bdhogaresbienestar.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bdhogaresbienestares }
    end
  end

  # GET /bdhogaresbienestares/1
  # GET /bdhogaresbienestares/1.xml
  def show
    @bdhogaresbienestar = Bdhogaresbienestar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bdhogaresbienestar }
    end
  end

  # GET /bdhogaresbienestares/new
  # GET /bdhogaresbienestares/new.xml
  def new
    @bdhogaresbienestar = Bdhogaresbienestar.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bdhogaresbienestar }
    end
  end

  # GET /bdhogaresbienestares/1/edit
  def edit
    @bdhogaresbienestar = Bdhogaresbienestar.find(params[:id])
  end

  # POST /bdhogaresbienestares
  # POST /bdhogaresbienestares.xml
  def create
    @bdhogaresbienestar = Bdhogaresbienestar.new(params[:bdhogaresbienestar])

    respond_to do |format|
      if @bdhogaresbienestar.save
        format.html { redirect_to(@bdhogaresbienestar, :notice => 'Bdhogaresbienestar was successfully created.') }
        format.xml  { render :xml => @bdhogaresbienestar, :status => :created, :location => @bdhogaresbienestar }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bdhogaresbienestar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bdhogaresbienestares/1
  # PUT /bdhogaresbienestares/1.xml
  def update
    @bdhogaresbienestar = Bdhogaresbienestar.find(params[:id])

    respond_to do |format|
      if @bdhogaresbienestar.update_attributes(params[:bdhogaresbienestar])
        format.html { redirect_to(@bdhogaresbienestar, :notice => 'Bdhogaresbienestar was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bdhogaresbienestar.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bdhogaresbienestares/1
  # DELETE /bdhogaresbienestares/1.xml
  def destroy
    @bdhogaresbienestar = Bdhogaresbienestar.find(params[:id])
    @bdhogaresbienestar.destroy

    respond_to do |format|
      format.html { redirect_to(bdhogaresbienestares_url) }
      format.xml  { head :ok }
    end
  end
end

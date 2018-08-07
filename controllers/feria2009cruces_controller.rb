class Feria2009crucesController < ApplicationController
  before_filter :require_user
  # GET /feria2009cruces
  # GET /feria2009cruces.xml
  def index
    @feria2009cruces = Feria2009cruce.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2009cruces }
    end
  end

  # GET /feria2009cruces/1
  # GET /feria2009cruces/1.xml
  def show
    @feria2009cruce = Feria2009cruce.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2009cruce }
    end
  end

  # GET /feria2009cruces/new
  # GET /feria2009cruces/new.xml
  def new
    @feria2009cruce = Feria2009cruce.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2009cruce }
    end
  end

  # GET /feria2009cruces/1/edit
  def edit
    @feria2009cruce = Feria2009cruce.find(params[:id])
  end

  # POST /feria2009cruces
  # POST /feria2009cruces.xml
  def create
    @feria2009cruce = Feria2009cruce.new(params[:feria2009cruce])

    respond_to do |format|
      if @feria2009cruce.save
        format.html { redirect_to(@feria2009cruce, :notice => 'Feria2009cruce was successfully created.') }
        format.xml  { render :xml => @feria2009cruce, :status => :created, :location => @feria2009cruce }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2009cruce.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2009cruces/1
  # PUT /feria2009cruces/1.xml
  def update
    @feria2009cruce = Feria2009cruce.find(params[:id])

    respond_to do |format|
      if @feria2009cruce.update_attributes(params[:feria2009cruce])
        format.html { redirect_to(@feria2009cruce, :notice => 'Feria2009cruce was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2009cruce.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2009cruces/1
  # DELETE /feria2009cruces/1.xml
  def destroy
    @feria2009cruce = Feria2009cruce.find(params[:id])
    @feria2009cruce.destroy

    respond_to do |format|
      format.html { redirect_to(feria2009cruces_url) }
      format.xml  { head :ok }
    end
  end
end

class PlanesController < ApplicationController

  require 'ruby_plsql'

  def buscar
    var1 = params[:var1]
    var2 = params[:var2]
    var3 = params[:var3]
    var4 = params[:var4]
    ActiveRecord::Base.connection.execute("truncate table planes")
    ActiveRecord::Base.connection.execute("begin prc_plan(#{var1.to_s},#{var2.to_s},#{var3.to_s}); end;")
    @planes = Plan.all
    respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
    end
  end

  def index
    @planes = Plan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planes }
    end
  end

  # GET /planes/1
  # GET /planes/1.xml
  def show
    @plan = Plan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plan }
    end
  end

  # GET /planes/new
  # GET /planes/new.xml
  def new
    @plan = Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plan }
    end
  end

  # GET /planes/1/edit
  def edit
    @plan = Plan.find(params[:id])
  end

  # POST /planes
  # POST /planes.xml
  def create
    @plan = Plan.new(params[:plan])

    respond_to do |format|
      if @plan.save
        flash[:notice] = 'Plan was successfully created.'
        format.html { redirect_to(@plan) }
        format.xml  { render :xml => @plan, :status => :created, :location => @plan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planes/1
  # PUT /planes/1.xml
  def update
    @plan = Plan.find(params[:id])

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        flash[:notice] = 'Plan was successfully updated.'
        format.html { redirect_to(@plan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planes/1
  # DELETE /planes/1.xml
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to(planes_url) }
      format.xml  { head :ok }
    end
  end
end

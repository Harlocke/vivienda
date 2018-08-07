class CensosController < ApplicationController
  # GET /censos
  # GET /censos.xml
  def index
    @censos = Censo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @censos }
    end
  end

  # GET /censos/1
  # GET /censos/1.xml
  def show
    @censo = Censo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @censo }
    end
  end

  # GET /censos/new
  # GET /censos/new.xml
  def new
    @censo = Censo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @censo }
    end
  end

  # GET /censos/1/edit
  def edit
    @censo = Censo.find(params[:id])
  end

  # POST /censos
  # POST /censos.xml
  def create
    @censo = Censo.new(params[:censo])

    respond_to do |format|
      if @censo.save
        flash[:notice] = 'Censo was successfully created.'
        format.html { redirect_to(@censo) }
        format.xml  { render :xml => @censo, :status => :created, :location => @censo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @censo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /censos/1
  # PUT /censos/1.xml
  def update
    @censo = Censo.find(params[:id])

    respond_to do |format|
      if @censo.update_attributes(params[:censo])
        flash[:notice] = 'Censo was successfully updated.'
        format.html { redirect_to(@censo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @censo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /censos/1
  # DELETE /censos/1.xml
  def destroy
    @censo = Censo.find(params[:id])
    @censo.destroy

    respond_to do |format|
      format.html { redirect_to(censos_url) }
      format.xml  { head :ok }
    end
  end
end

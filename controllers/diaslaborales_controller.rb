class DiaslaboralesController < ApplicationController
  # GET /diaslaborales
  # GET /diaslaborales.xml
  def index
    @diaslaborales = Diaslaboral.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @diaslaborales }
    end
  end

  # GET /diaslaborales/1
  # GET /diaslaborales/1.xml
  def show
    @diaslaboral = Diaslaboral.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @diaslaboral }
    end
  end

  # GET /diaslaborales/new
  # GET /diaslaborales/new.xml
  def new
    @diaslaboral = Diaslaboral.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @diaslaboral }
    end
  end

  # GET /diaslaborales/1/edit
  def edit
    @diaslaboral = Diaslaboral.find(params[:id])
  end

  # POST /diaslaborales
  # POST /diaslaborales.xml
  def create
    @diaslaboral = Diaslaboral.new(params[:diaslaboral])

    respond_to do |format|
      if @diaslaboral.save
        flash[:notice] = 'Diaslaboral was successfully created.'
        format.html { redirect_to(@diaslaboral) }
        format.xml  { render :xml => @diaslaboral, :status => :created, :location => @diaslaboral }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @diaslaboral.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /diaslaborales/1
  # PUT /diaslaborales/1.xml
  def update
    @diaslaboral = Diaslaboral.find(params[:id])

    respond_to do |format|
      if @diaslaboral.update_attributes(params[:diaslaboral])
        flash[:notice] = 'Diaslaboral was successfully updated.'
        format.html { redirect_to(@diaslaboral) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @diaslaboral.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /diaslaborales/1
  # DELETE /diaslaborales/1.xml
  def destroy
    @diaslaboral = Diaslaboral.find(params[:id])
    @diaslaboral.destroy

    respond_to do |format|
      format.html { redirect_to(diaslaborales_url) }
      format.xml  { head :ok }
    end
  end
end

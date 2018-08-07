class IguanastiposController < ApplicationController
  # GET /iguanastipos
  # GET /iguanastipos.xml
  def index
    @iguanastipos = Iguanastipo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iguanastipos }
    end
  end

  # GET /iguanastipos/1
  # GET /iguanastipos/1.xml
  def show
    @iguanastipo = Iguanastipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @iguanastipo }
    end
  end

  # GET /iguanastipos/new
  # GET /iguanastipos/new.xml
  def new
    @iguanastipo = Iguanastipo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @iguanastipo }
    end
  end

  # GET /iguanastipos/1/edit
  def edit
    @iguanastipo = Iguanastipo.find(params[:id])
  end

  # POST /iguanastipos
  # POST /iguanastipos.xml
  def create
    @iguanastipo = Iguanastipo.new(params[:iguanastipo])

    respond_to do |format|
      if @iguanastipo.save
        format.html { redirect_to(@iguanastipo, :notice => 'Iguanastipo was successfully created.') }
        format.xml  { render :xml => @iguanastipo, :status => :created, :location => @iguanastipo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @iguanastipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /iguanastipos/1
  # PUT /iguanastipos/1.xml
  def update
    @iguanastipo = Iguanastipo.find(params[:id])

    respond_to do |format|
      if @iguanastipo.update_attributes(params[:iguanastipo])
        format.html { redirect_to(@iguanastipo, :notice => 'Iguanastipo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @iguanastipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /iguanastipos/1
  # DELETE /iguanastipos/1.xml
  def destroy
    @iguanastipo = Iguanastipo.find(params[:id])
    @iguanastipo.destroy

    respond_to do |format|
      format.html { redirect_to(iguanastipos_url) }
      format.xml  { head :ok }
    end
  end
end

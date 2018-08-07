class ValorizacionesobrasController < ApplicationController
  # GET /valorizacionesobras
  # GET /valorizacionesobras.xml
  def index
    @valorizacionesobras = Valorizacionesobra.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @valorizacionesobras }
    end
  end

  # GET /valorizacionesobras/1
  # GET /valorizacionesobras/1.xml
  def show
    @valorizacionesobra = Valorizacionesobra.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @valorizacionesobra }
    end
  end

  # GET /valorizacionesobras/new
  # GET /valorizacionesobras/new.xml
  def new
    @valorizacionesobra = Valorizacionesobra.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @valorizacionesobra }
    end
  end

  # GET /valorizacionesobras/1/edit
  def edit
    @valorizacionesobra = Valorizacionesobra.find(params[:id])
  end

  # POST /valorizacionesobras
  # POST /valorizacionesobras.xml
  def create
    @valorizacionesobra = Valorizacionesobra.new(params[:valorizacionesobra])

    respond_to do |format|
      if @valorizacionesobra.save
        format.html { redirect_to(@valorizacionesobra, :notice => 'Valorizacionesobra was successfully created.') }
        format.xml  { render :xml => @valorizacionesobra, :status => :created, :location => @valorizacionesobra }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @valorizacionesobra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /valorizacionesobras/1
  # PUT /valorizacionesobras/1.xml
  def update
    @valorizacionesobra = Valorizacionesobra.find(params[:id])

    respond_to do |format|
      if @valorizacionesobra.update_attributes(params[:valorizacionesobra])
        format.html { redirect_to(@valorizacionesobra, :notice => 'Valorizacionesobra was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @valorizacionesobra.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /valorizacionesobras/1
  # DELETE /valorizacionesobras/1.xml
  def destroy
    @valorizacionesobra = Valorizacionesobra.find(params[:id])
    @valorizacionesobra.destroy

    respond_to do |format|
      format.html { redirect_to(valorizacionesobras_url) }
      format.xml  { head :ok }
    end
  end
end

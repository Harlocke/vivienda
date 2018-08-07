class TiposactosController < ApplicationController
  # GET /tiposactos
  # GET /tiposactos.xml
  def index
    @tiposactos = Tiposacto.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposactos }
    end
  end

  # GET /tiposactos/1
  # GET /tiposactos/1.xml
  def show
    @tiposacto = Tiposacto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposacto }
    end
  end

  # GET /tiposactos/new
  # GET /tiposactos/new.xml
  def new
    @tiposacto = Tiposacto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposacto }
    end
  end

  # GET /tiposactos/1/edit
  def edit
    @tiposacto = Tiposacto.find(params[:id])
  end

  # POST /tiposactos
  # POST /tiposactos.xml
  def create
    @tiposacto = Tiposacto.new(params[:tiposacto])

    respond_to do |format|
      if @tiposacto.save
        format.html { redirect_to(@tiposacto, :notice => 'Tiposacto was successfully created.') }
        format.xml  { render :xml => @tiposacto, :status => :created, :location => @tiposacto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposacto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposactos/1
  # PUT /tiposactos/1.xml
  def update
    @tiposacto = Tiposacto.find(params[:id])

    respond_to do |format|
      if @tiposacto.update_attributes(params[:tiposacto])
        format.html { redirect_to(@tiposacto, :notice => 'Tiposacto was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposacto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposactos/1
  # DELETE /tiposactos/1.xml
  def destroy
    @tiposacto = Tiposacto.find(params[:id])
    @tiposacto.destroy

    respond_to do |format|
      format.html { redirect_to(tiposactos_url) }
      format.xml  { head :ok }
    end
  end
end

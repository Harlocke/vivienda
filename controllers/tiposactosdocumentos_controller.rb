class TiposactosdocumentosController < ApplicationController
  # GET /tiposactosdocumentos
  # GET /tiposactosdocumentos.xml
  def index
    @tiposactosdocumentos = Tiposactosdocumento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposactosdocumentos }
    end
  end

  # GET /tiposactosdocumentos/1
  # GET /tiposactosdocumentos/1.xml
  def show
    @tiposactosdocumento = Tiposactosdocumento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposactosdocumento }
    end
  end

  # GET /tiposactosdocumentos/new
  # GET /tiposactosdocumentos/new.xml
  def new
    @tiposactosdocumento = Tiposactosdocumento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposactosdocumento }
    end
  end

  # GET /tiposactosdocumentos/1/edit
  def edit
    @tiposactosdocumento = Tiposactosdocumento.find(params[:id])
  end

  # POST /tiposactosdocumentos
  # POST /tiposactosdocumentos.xml
  def create
    @tiposactosdocumento = Tiposactosdocumento.new(params[:tiposactosdocumento])

    respond_to do |format|
      if @tiposactosdocumento.save
        format.html { redirect_to(@tiposactosdocumento, :notice => 'Tiposactosdocumento was successfully created.') }
        format.xml  { render :xml => @tiposactosdocumento, :status => :created, :location => @tiposactosdocumento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposactosdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposactosdocumentos/1
  # PUT /tiposactosdocumentos/1.xml
  def update
    @tiposactosdocumento = Tiposactosdocumento.find(params[:id])

    respond_to do |format|
      if @tiposactosdocumento.update_attributes(params[:tiposactosdocumento])
        format.html { redirect_to(@tiposactosdocumento, :notice => 'Tiposactosdocumento was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposactosdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposactosdocumentos/1
  # DELETE /tiposactosdocumentos/1.xml
  def destroy
    @tiposactosdocumento = Tiposactosdocumento.find(params[:id])
    @tiposactosdocumento.destroy

    respond_to do |format|
      format.html { redirect_to(tiposactosdocumentos_url) }
      format.xml  { head :ok }
    end
  end
end

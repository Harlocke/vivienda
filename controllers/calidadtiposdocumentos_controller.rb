class CalidadtiposdocumentosController < ApplicationController
  # GET /calidadtiposdocumentos
  # GET /calidadtiposdocumentos.xml
  def index
    @calidadtiposdocumentos = Calidadtiposdocumento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calidadtiposdocumentos }
    end
  end

  # GET /calidadtiposdocumentos/1
  # GET /calidadtiposdocumentos/1.xml
  def show
    @calidadtiposdocumento = Calidadtiposdocumento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calidadtiposdocumento }
    end
  end

  # GET /calidadtiposdocumentos/new
  # GET /calidadtiposdocumentos/new.xml
  def new
    @calidadtiposdocumento = Calidadtiposdocumento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @calidadtiposdocumento }
    end
  end

  # GET /calidadtiposdocumentos/1/edit
  def edit
    @calidadtiposdocumento = Calidadtiposdocumento.find(params[:id])
  end

  # POST /calidadtiposdocumentos
  # POST /calidadtiposdocumentos.xml
  def create
    @calidadtiposdocumento = Calidadtiposdocumento.new(params[:calidadtiposdocumento])

    respond_to do |format|
      if @calidadtiposdocumento.save
        format.html { redirect_to(@calidadtiposdocumento, :notice => 'Calidadtiposdocumento was successfully created.') }
        format.xml  { render :xml => @calidadtiposdocumento, :status => :created, :location => @calidadtiposdocumento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calidadtiposdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /calidadtiposdocumentos/1
  # PUT /calidadtiposdocumentos/1.xml
  def update
    @calidadtiposdocumento = Calidadtiposdocumento.find(params[:id])

    respond_to do |format|
      if @calidadtiposdocumento.update_attributes(params[:calidadtiposdocumento])
        format.html { redirect_to(@calidadtiposdocumento, :notice => 'Calidadtiposdocumento was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calidadtiposdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /calidadtiposdocumentos/1
  # DELETE /calidadtiposdocumentos/1.xml
  def destroy
    @calidadtiposdocumento = Calidadtiposdocumento.find(params[:id])
    @calidadtiposdocumento.destroy

    respond_to do |format|
      format.html { redirect_to(calidadtiposdocumentos_url) }
      format.xml  { head :ok }
    end
  end
end

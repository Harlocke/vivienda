class TiposcontratosController < ApplicationController
  before_filter :require_user

  # GET /tiposcontratos
  # GET /tiposcontratos.xml
  def index
    @tiposcontratos = Tiposcontrato.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposcontratos }
    end
  end

  # GET /tiposcontratos/1
  # GET /tiposcontratos/1.xml
  def show
    @tiposcontrato = Tiposcontrato.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposcontrato }
    end
  end

  # GET /tiposcontratos/new
  # GET /tiposcontratos/new.xml
  def new
    @tiposcontrato = Tiposcontrato.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposcontrato }
    end
  end

  # GET /tiposcontratos/1/edit
  def edit
    @tiposcontrato = Tiposcontrato.find(params[:id])
  end

  # POST /tiposcontratos
  # POST /tiposcontratos.xml
  def create
    @tiposcontrato = Tiposcontrato.new(params[:tiposcontrato])

    respond_to do |format|
      if @tiposcontrato.save
        flash[:notice] = 'Tiposcontrato was successfully created.'
        format.html { redirect_to(@tiposcontrato) }
        format.xml  { render :xml => @tiposcontrato, :status => :created, :location => @tiposcontrato }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposcontrato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposcontratos/1
  # PUT /tiposcontratos/1.xml
  def update
    @tiposcontrato = Tiposcontrato.find(params[:id])

    respond_to do |format|
      if @tiposcontrato.update_attributes(params[:tiposcontrato])
        flash[:notice] = 'Tiposcontrato was successfully updated.'
        format.html { redirect_to(@tiposcontrato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposcontrato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposcontratos/1
  # DELETE /tiposcontratos/1.xml
  def destroy
    @tiposcontrato = Tiposcontrato.find(params[:id])
    @tiposcontrato.destroy

    respond_to do |format|
      format.html { redirect_to(tiposcontratos_url) }
      format.xml  { head :ok }
    end
  end
end

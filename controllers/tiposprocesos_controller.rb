class TiposprocesosController < ApplicationController

  before_filter :require_user

  def index
    @tiposprocesos = Tiposproceso.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposprocesos }
    end
  end

  # GET /tiposprocesos/1
  # GET /tiposprocesos/1.xml
  def show
    @tiposproceso = Tiposproceso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposproceso }
    end
  end

  # GET /tiposprocesos/new
  # GET /tiposprocesos/new.xml
  def new
    @tiposproceso = Tiposproceso.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposproceso }
    end
  end

  # GET /tiposprocesos/1/edit
  def edit
    @tiposproceso = Tiposproceso.find(params[:id])
  end

  # POST /tiposprocesos
  # POST /tiposprocesos.xml
  def create
    @tiposproceso = Tiposproceso.new(params[:tiposproceso])

    respond_to do |format|
      if @tiposproceso.save
        format.html { redirect_to(@tiposproceso, :notice => 'Tiposproceso was successfully created.') }
        format.xml  { render :xml => @tiposproceso, :status => :created, :location => @tiposproceso }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposproceso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposprocesos/1
  # PUT /tiposprocesos/1.xml
  def update
    @tiposproceso = Tiposproceso.find(params[:id])

    respond_to do |format|
      if @tiposproceso.update_attributes(params[:tiposproceso])
        format.html { redirect_to(@tiposproceso, :notice => 'Tiposproceso was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposproceso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposprocesos/1
  # DELETE /tiposprocesos/1.xml
  def destroy
    @tiposproceso = Tiposproceso.find(params[:id])
    @tiposproceso.destroy

    respond_to do |format|
      format.html { redirect_to(tiposprocesos_url) }
      format.xml  { head :ok }
    end
  end
end

class InterventoriasfechasController < ApplicationController
  # GET /interventoriasfechas
  # GET /interventoriasfechas.xml
  def index
    @interventoriasfechas = Interventoriasfecha.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @interventoriasfechas }
    end
  end

  # GET /interventoriasfechas/1
  # GET /interventoriasfechas/1.xml
  def show
    @interventoriasfecha = Interventoriasfecha.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @interventoriasfecha }
    end
  end

  # GET /interventoriasfechas/new
  # GET /interventoriasfechas/new.xml
  def new
    @interventoriasfecha = Interventoriasfecha.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @interventoriasfecha }
    end
  end

  # GET /interventoriasfechas/1/edit
  def edit
    @interventoriasfecha = Interventoriasfecha.find(params[:id])
  end

  # POST /interventoriasfechas
  # POST /interventoriasfechas.xml
  def create
    @interventoriasfecha = Interventoriasfecha.new(params[:interventoriasfecha])

    respond_to do |format|
      if @interventoriasfecha.save
        format.html { redirect_to(@interventoriasfecha, :notice => 'Interventoriasfecha was successfully created.') }
        format.xml  { render :xml => @interventoriasfecha, :status => :created, :location => @interventoriasfecha }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @interventoriasfecha.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /interventoriasfechas/1
  # PUT /interventoriasfechas/1.xml
  def update
    @interventoriasfecha = Interventoriasfecha.find(params[:id])

    respond_to do |format|
      if @interventoriasfecha.update_attributes(params[:interventoriasfecha])
        format.html { redirect_to(@interventoriasfecha, :notice => 'Interventoriasfecha was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interventoriasfecha.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /interventoriasfechas/1
  # DELETE /interventoriasfechas/1.xml
  def destroy
    @interventoriasfecha = Interventoriasfecha.find(params[:id])
    @interventoriasfecha.destroy

    respond_to do |format|
      format.html { redirect_to(interventoriasfechas_url) }
      format.xml  { head :ok }
    end
  end
end

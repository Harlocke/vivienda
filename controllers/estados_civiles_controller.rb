class EstadosCivilesController < ApplicationController

  before_filter :require_user

  def index
    @estados_civiles = EstadosCivil.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @estados_civiles }
    end
  end

  # GET /estados_civiles/1
  # GET /estados_civiles/1.xml
  def show
    @estados_civil = EstadosCivil.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estados_civil }
    end
  end

  # GET /estados_civiles/new
  # GET /estados_civiles/new.xml
  def new
    @estados_civil = EstadosCivil.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estados_civil }
    end
  end

  # GET /estados_civiles/1/edit
  def edit
    @estados_civil = EstadosCivil.find(params[:id])
  end

  # POST /estados_civiles
  # POST /estados_civiles.xml
  def create
    @estados_civil = EstadosCivil.new(params[:estados_civil])

    respond_to do |format|
      if @estados_civil.save
        flash[:notice] = 'EstadosCivil was successfully created.'
        format.html { redirect_to(@estados_civil) }
        format.xml  { render :xml => @estados_civil, :status => :created, :location => @estados_civil }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @estados_civil.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /estados_civiles/1
  # PUT /estados_civiles/1.xml
  def update
    @estados_civil = EstadosCivil.find(params[:id])

    respond_to do |format|
      if @estados_civil.update_attributes(params[:estados_civil])
        flash[:notice] = 'EstadosCivil was successfully updated.'
        format.html { redirect_to(@estados_civil) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @estados_civil.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /estados_civiles/1
  # DELETE /estados_civiles/1.xml
  def destroy
    @estados_civil = EstadosCivil.find(params[:id])
    @estados_civil.destroy

    respond_to do |format|
      format.html { redirect_to(estados_civiles_url) }
      format.xml  { head :ok }
    end
  end
end

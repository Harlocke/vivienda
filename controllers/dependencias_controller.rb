class DependenciasController < ApplicationController
  before_filter :require_user

  def add_dependencia
    @dependencia = Dependencia.new(params[:dependencia])
    @dependencia.save
    @dependencias = Dependencia.all
    respond_to do |format|
      if @dependencia.save
        format.html { redirect_to dependencias_path }
        format.js
      else
        format.html { redirect_to dependencias_path }
        format.js
      end
    end
  end

  def index
    @dependencias = Dependencia.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dependencias }
    end
  end

  # GET /dependencias/1
  # GET /dependencias/1.xml
  def show
    @dependencia = Dependencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dependencia }
    end
  end

  # GET /dependencias/new
  # GET /dependencias/new.xml
  def new
    @dependencia = Dependencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dependencia }
    end
  end

  # GET /dependencias/1/edit
  def edit
    @dependencia = Dependencia.find(params[:id])
  end

  # POST /dependencias
  # POST /dependencias.xml
  def create
    @dependencia = Dependencia.new(params[:dependencia])

    respond_to do |format|
      if @dependencia.save
        flash[:notice] = 'Dependencia was successfully created.'
        format.html { redirect_to(@dependencia) }
        format.xml  { render :xml => @dependencia, :status => :created, :location => @dependencia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dependencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dependencias/1
  # PUT /dependencias/1.xml
  def update
    @dependencia = Dependencia.find(params[:id])

    respond_to do |format|
      if @dependencia.update_attributes(params[:dependencia])
        flash[:notice] = 'Dependencia was successfully updated.'
        format.html { redirect_to(@dependencia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dependencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dependencias/1
  # DELETE /dependencias/1.xml
  def destroy
    @dependencia = Dependencia.find(params[:id])
    @dependencia.destroy

    respond_to do |format|
      format.html { redirect_to(dependencias_url) }
      format.xml  { head :ok }
    end
  end
end

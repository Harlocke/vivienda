class TipospoblacionesController < ApplicationController

  before_filter :require_user
  # GET /tipospoblaciones
  # GET /tipospoblaciones.xml
  def index
    @tipospoblaciones = Tipospoblacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipospoblaciones }
    end
  end

  # GET /tipospoblaciones/1
  # GET /tipospoblaciones/1.xml
  def show
    @tipospoblacion = Tipospoblacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipospoblacion }
    end
  end

  # GET /tipospoblaciones/new
  # GET /tipospoblaciones/new.xml
  def new
    @tipospoblacion = Tipospoblacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipospoblacion }
    end
  end

  # GET /tipospoblaciones/1/edit
  def edit
    @tipospoblacion = Tipospoblacion.find(params[:id])
  end

  # POST /tipospoblaciones
  # POST /tipospoblaciones.xml
  def create
    @tipospoblacion = Tipospoblacion.new(params[:tipospoblacion])

    respond_to do |format|
      if @tipospoblacion.save
        format.html { redirect_to(@tipospoblacion, :notice => 'Tipospoblacion was successfully created.') }
        format.xml  { render :xml => @tipospoblacion, :status => :created, :location => @tipospoblacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipospoblacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipospoblaciones/1
  # PUT /tipospoblaciones/1.xml
  def update
    @tipospoblacion = Tipospoblacion.find(params[:id])

    respond_to do |format|
      if @tipospoblacion.update_attributes(params[:tipospoblacion])
        format.html { redirect_to(@tipospoblacion, :notice => 'Tipospoblacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipospoblacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipospoblaciones/1
  # DELETE /tipospoblaciones/1.xml
  def destroy
    @tipospoblacion = Tipospoblacion.find(params[:id])
    @tipospoblacion.destroy

    respond_to do |format|
      format.html { redirect_to(tipospoblaciones_url) }
      format.xml  { head :ok }
    end
  end
end

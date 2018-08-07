class CajasController < ApplicationController
  before_filter :require_user

  def index
    @cajas = Caja.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cajas }
    end
  end

  # GET /cajas/1
  # GET /cajas/1.xml
  def show
    @caja = Caja.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @caja }
    end
  end

  # GET /cajas/new
  # GET /cajas/new.xml
  def new
    @caja = Caja.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @caja }
    end
  end

  # GET /cajas/1/edit
  def edit
    @caja = Caja.find(params[:id])
  end

  # POST /cajas
  # POST /cajas.xml
  def create
    @caja = Caja.new(params[:caja])

    respond_to do |format|
      if @caja.save
        flash[:notice] = 'Caja was successfully created.'
        format.html { redirect_to(@caja) }
        format.xml  { render :xml => @caja, :status => :created, :location => @caja }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @caja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cajas/1
  # PUT /cajas/1.xml
  def update
    @caja = Caja.find(params[:id])

    respond_to do |format|
      if @caja.update_attributes(params[:caja])
        flash[:notice] = 'Caja was successfully updated.'
        format.html { redirect_to(@caja) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @caja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cajas/1
  # DELETE /cajas/1.xml
  def destroy
    @caja = Caja.find(params[:id])
    @caja.destroy

    respond_to do |format|
      format.html { redirect_to(cajas_url) }
      format.xml  { head :ok }
    end
  end
end

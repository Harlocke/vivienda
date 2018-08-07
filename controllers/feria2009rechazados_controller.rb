class Feria2009rechazadosController < ApplicationController
  before_filter :require_user
  # GET /feria2009rechazados
  # GET /feria2009rechazados.xml
  def index
    @feria2009rechazados = Feria2009rechazado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2009rechazados }
    end
  end

  # GET /feria2009rechazados/1
  # GET /feria2009rechazados/1.xml
  def show
    @feria2009rechazado = Feria2009rechazado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2009rechazado }
    end
  end

  # GET /feria2009rechazados/new
  # GET /feria2009rechazados/new.xml
  def new
    @feria2009rechazado = Feria2009rechazado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2009rechazado }
    end
  end

  # GET /feria2009rechazados/1/edit
  def edit
    @feria2009rechazado = Feria2009rechazado.find(params[:id])
  end

  # POST /feria2009rechazados
  # POST /feria2009rechazados.xml
  def create
    @feria2009rechazado = Feria2009rechazado.new(params[:feria2009rechazado])

    respond_to do |format|
      if @feria2009rechazado.save
        format.html { redirect_to(@feria2009rechazado, :notice => 'Feria2009rechazado was successfully created.') }
        format.xml  { render :xml => @feria2009rechazado, :status => :created, :location => @feria2009rechazado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2009rechazado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2009rechazados/1
  # PUT /feria2009rechazados/1.xml
  def update
    @feria2009rechazado = Feria2009rechazado.find(params[:id])

    respond_to do |format|
      if @feria2009rechazado.update_attributes(params[:feria2009rechazado])
        format.html { redirect_to(@feria2009rechazado, :notice => 'Feria2009rechazado was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2009rechazado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2009rechazados/1
  # DELETE /feria2009rechazados/1.xml
  def destroy
    @feria2009rechazado = Feria2009rechazado.find(params[:id])
    @feria2009rechazado.destroy

    respond_to do |format|
      format.html { redirect_to(feria2009rechazados_url) }
      format.xml  { head :ok }
    end
  end
end

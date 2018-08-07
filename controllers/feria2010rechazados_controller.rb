class Feria2010rechazadosController < ApplicationController
  before_filter :require_user
  # GET /feria2010rechazados
  # GET /feria2010rechazados.xml
  def index
    @feria2010rechazados = Feria2010rechazado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2010rechazados }
    end
  end

  # GET /feria2010rechazados/1
  # GET /feria2010rechazados/1.xml
  def show
    @feria2010rechazado = Feria2010rechazado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2010rechazado }
    end
  end

  # GET /feria2010rechazados/new
  # GET /feria2010rechazados/new.xml
  def new
    @feria2010rechazado = Feria2010rechazado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2010rechazado }
    end
  end

  # GET /feria2010rechazados/1/edit
  def edit
    @feria2010rechazado = Feria2010rechazado.find(params[:id])
  end

  # POST /feria2010rechazados
  # POST /feria2010rechazados.xml
  def create
    @feria2010rechazado = Feria2010rechazado.new(params[:feria2010rechazado])

    respond_to do |format|
      if @feria2010rechazado.save
        format.html { redirect_to(@feria2010rechazado, :notice => 'Feria2010rechazado was successfully created.') }
        format.xml  { render :xml => @feria2010rechazado, :status => :created, :location => @feria2010rechazado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2010rechazado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2010rechazados/1
  # PUT /feria2010rechazados/1.xml
  def update
    @feria2010rechazado = Feria2010rechazado.find(params[:id])

    respond_to do |format|
      if @feria2010rechazado.update_attributes(params[:feria2010rechazado])
        format.html { redirect_to(@feria2010rechazado, :notice => 'Feria2010rechazado was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2010rechazado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2010rechazados/1
  # DELETE /feria2010rechazados/1.xml
  def destroy
    @feria2010rechazado = Feria2010rechazado.find(params[:id])
    @feria2010rechazado.destroy

    respond_to do |format|
      format.html { redirect_to(feria2010rechazados_url) }
      format.xml  { head :ok }
    end
  end
end

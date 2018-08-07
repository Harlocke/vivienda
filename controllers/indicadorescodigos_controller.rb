class IndicadorescodigosController < ApplicationController
  # GET /indicadorescodigos
  # GET /indicadorescodigos.xml
  def index
    @indicadorescodigos = Indicadorescodigo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @indicadorescodigos }
    end
  end

  # GET /indicadorescodigos/1
  # GET /indicadorescodigos/1.xml
  def show
    @indicadorescodigo = Indicadorescodigo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @indicadorescodigo }
    end
  end

  # GET /indicadorescodigos/new
  # GET /indicadorescodigos/new.xml
  def new
    @indicadorescodigo = Indicadorescodigo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @indicadorescodigo }
    end
  end

  # GET /indicadorescodigos/1/edit
  def edit
    @indicadorescodigo = Indicadorescodigo.find(params[:id])
  end

  # POST /indicadorescodigos
  # POST /indicadorescodigos.xml
  def create
    @indicadorescodigo = Indicadorescodigo.new(params[:indicadorescodigo])

    respond_to do |format|
      if @indicadorescodigo.save
        format.html { redirect_to(@indicadorescodigo, :notice => 'Indicadorescodigo was successfully created.') }
        format.xml  { render :xml => @indicadorescodigo, :status => :created, :location => @indicadorescodigo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @indicadorescodigo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /indicadorescodigos/1
  # PUT /indicadorescodigos/1.xml
  def update
    @indicadorescodigo = Indicadorescodigo.find(params[:id])

    respond_to do |format|
      if @indicadorescodigo.update_attributes(params[:indicadorescodigo])
        format.html { redirect_to(@indicadorescodigo, :notice => 'Indicadorescodigo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @indicadorescodigo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /indicadorescodigos/1
  # DELETE /indicadorescodigos/1.xml
  def destroy
    @indicadorescodigo = Indicadorescodigo.find(params[:id])
    @indicadorescodigo.destroy

    respond_to do |format|
      format.html { redirect_to(indicadorescodigos_url) }
      format.xml  { head :ok }
    end
  end
end

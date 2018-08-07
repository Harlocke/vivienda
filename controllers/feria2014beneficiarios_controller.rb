class Feria2014beneficiariosController < ApplicationController
  # GET /feria2014beneficiarios
  # GET /feria2014beneficiarios.xml
  def index
    @feria2014beneficiarios = Feria2014beneficiario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2014beneficiarios }
    end
  end

  # GET /feria2014beneficiarios/1
  # GET /feria2014beneficiarios/1.xml
  def show
    @feria2014beneficiario = Feria2014beneficiario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2014beneficiario }
    end
  end

  # GET /feria2014beneficiarios/new
  # GET /feria2014beneficiarios/new.xml
  def new
    @feria2014beneficiario = Feria2014beneficiario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2014beneficiario }
    end
  end

  # GET /feria2014beneficiarios/1/edit
  def edit
    @feria2014beneficiario = Feria2014beneficiario.find(params[:id])
  end

  # POST /feria2014beneficiarios
  # POST /feria2014beneficiarios.xml
  def create
    @feria2014beneficiario = Feria2014beneficiario.new(params[:feria2014beneficiario])

    respond_to do |format|
      if @feria2014beneficiario.save
        format.html { redirect_to(@feria2014beneficiario, :notice => 'Feria2014beneficiario was successfully created.') }
        format.xml  { render :xml => @feria2014beneficiario, :status => :created, :location => @feria2014beneficiario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2014beneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2014beneficiarios/1
  # PUT /feria2014beneficiarios/1.xml
  def update
    @feria2014beneficiario = Feria2014beneficiario.find(params[:id])

    respond_to do |format|
      if @feria2014beneficiario.update_attributes(params[:feria2014beneficiario])
        format.html { redirect_to(@feria2014beneficiario, :notice => 'Feria2014beneficiario was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2014beneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2014beneficiarios/1
  # DELETE /feria2014beneficiarios/1.xml
  def destroy
    @feria2014beneficiario = Feria2014beneficiario.find(params[:id])
    @feria2014beneficiario.destroy

    respond_to do |format|
      format.html { redirect_to(feria2014beneficiarios_url) }
      format.xml  { head :ok }
    end
  end
end

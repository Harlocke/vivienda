class Feria2010beneficiariosController < ApplicationController
  before_filter :require_user
  # GET /feria2010beneficiarios
  # GET /feria2010beneficiarios.xml
  def index
    @feria2010beneficiarios = Feria2010beneficiario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2010beneficiarios }
    end
  end

  # GET /feria2010beneficiarios/1
  # GET /feria2010beneficiarios/1.xml
  def show
    @feria2010beneficiario = Feria2010beneficiario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2010beneficiario }
    end
  end

  # GET /feria2010beneficiarios/new
  # GET /feria2010beneficiarios/new.xml
  def new
    @feria2010beneficiario = Feria2010beneficiario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2010beneficiario }
    end
  end

  # GET /feria2010beneficiarios/1/edit
  def edit
    @feria2010beneficiario = Feria2010beneficiario.find(params[:id])
  end

  # POST /feria2010beneficiarios
  # POST /feria2010beneficiarios.xml
  def create
    @feria2010beneficiario = Feria2010beneficiario.new(params[:feria2010beneficiario])

    respond_to do |format|
      if @feria2010beneficiario.save
        format.html { redirect_to(@feria2010beneficiario, :notice => 'Feria2010beneficiario was successfully created.') }
        format.xml  { render :xml => @feria2010beneficiario, :status => :created, :location => @feria2010beneficiario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2010beneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2010beneficiarios/1
  # PUT /feria2010beneficiarios/1.xml
  def update
    @feria2010beneficiario = Feria2010beneficiario.find(params[:id])

    respond_to do |format|
      if @feria2010beneficiario.update_attributes(params[:feria2010beneficiario])
        format.html { redirect_to(@feria2010beneficiario, :notice => 'Feria2010beneficiario was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2010beneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2010beneficiarios/1
  # DELETE /feria2010beneficiarios/1.xml
  def destroy
    @feria2010beneficiario = Feria2010beneficiario.find(params[:id])
    @feria2010beneficiario.destroy

    respond_to do |format|
      format.html { redirect_to(feria2010beneficiarios_url) }
      format.xml  { head :ok }
    end
  end
end

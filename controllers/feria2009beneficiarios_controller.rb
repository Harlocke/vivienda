class Feria2009beneficiariosController < ApplicationController
  before_filter :require_user
  # GET /feria2009beneficiarios
  # GET /feria2009beneficiarios.xml
  def index
    @feria2009beneficiarios = Feria2009beneficiario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2009beneficiarios }
    end
  end

  # GET /feria2009beneficiarios/1
  # GET /feria2009beneficiarios/1.xml
  def show
    @feria2009beneficiario = Feria2009beneficiario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2009beneficiario }
    end
  end

  # GET /feria2009beneficiarios/new
  # GET /feria2009beneficiarios/new.xml
  def new
    @feria2009beneficiario = Feria2009beneficiario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2009beneficiario }
    end
  end

  # GET /feria2009beneficiarios/1/edit
  def edit
    @feria2009beneficiario = Feria2009beneficiario.find(params[:id])
  end

  # POST /feria2009beneficiarios
  # POST /feria2009beneficiarios.xml
  def create
    @feria2009beneficiario = Feria2009beneficiario.new(params[:feria2009beneficiario])

    respond_to do |format|
      if @feria2009beneficiario.save
        format.html { redirect_to(@feria2009beneficiario, :notice => 'Feria2009beneficiario was successfully created.') }
        format.xml  { render :xml => @feria2009beneficiario, :status => :created, :location => @feria2009beneficiario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2009beneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2009beneficiarios/1
  # PUT /feria2009beneficiarios/1.xml
  def update
    @feria2009beneficiario = Feria2009beneficiario.find(params[:id])

    respond_to do |format|
      if @feria2009beneficiario.update_attributes(params[:feria2009beneficiario])
        format.html { redirect_to(@feria2009beneficiario, :notice => 'Feria2009beneficiario was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2009beneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2009beneficiarios/1
  # DELETE /feria2009beneficiarios/1.xml
  def destroy
    @feria2009beneficiario = Feria2009beneficiario.find(params[:id])
    @feria2009beneficiario.destroy

    respond_to do |format|
      format.html { redirect_to(feria2009beneficiarios_url) }
      format.xml  { head :ok }
    end
  end
end

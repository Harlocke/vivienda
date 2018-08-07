class Fase2beneficiariosController < ApplicationController
  # GET /fase2beneficiarios
  # GET /fase2beneficiarios.xml
  def index
    @fase2beneficiarios = Fase2beneficiario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fase2beneficiarios }
    end
  end

  # GET /fase2beneficiarios/1
  # GET /fase2beneficiarios/1.xml
  def show
    @fase2beneficiario = Fase2beneficiario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fase2beneficiario }
    end
  end

  # GET /fase2beneficiarios/new
  # GET /fase2beneficiarios/new.xml
  def new
    @fase2beneficiario = Fase2beneficiario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fase2beneficiario }
    end
  end

  # GET /fase2beneficiarios/1/edit
  def edit
    @fase2beneficiario = Fase2beneficiario.find(params[:id])
  end

  # POST /fase2beneficiarios
  # POST /fase2beneficiarios.xml
  def create
    @fase2beneficiario = Fase2beneficiario.new(params[:fase2beneficiario])

    respond_to do |format|
      if @fase2beneficiario.save
        format.html { redirect_to(@fase2beneficiario, :notice => 'Fase2beneficiario was successfully created.') }
        format.xml  { render :xml => @fase2beneficiario, :status => :created, :location => @fase2beneficiario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fase2beneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fase2beneficiarios/1
  # PUT /fase2beneficiarios/1.xml
  def update
    @fase2beneficiario = Fase2beneficiario.find(params[:id])

    respond_to do |format|
      if @fase2beneficiario.update_attributes(params[:fase2beneficiario])
        format.html { redirect_to(@fase2beneficiario, :notice => 'Fase2beneficiario was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fase2beneficiario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fase2beneficiarios/1
  # DELETE /fase2beneficiarios/1.xml
  def destroy
    @fase2beneficiario = Fase2beneficiario.find(params[:id])
    @fase2beneficiario.destroy

    respond_to do |format|
      format.html { redirect_to(fase2beneficiarios_url) }
      format.xml  { head :ok }
    end
  end
end

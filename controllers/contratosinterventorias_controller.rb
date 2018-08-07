class ContratosinterventoriasController < ApplicationController
  # GET /contratosinterventorias
  # GET /contratosinterventorias.xml
  def index
    @contratosinterventorias = Contratosinterventoria.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contratosinterventorias }
    end
  end

  # GET /contratosinterventorias/1
  # GET /contratosinterventorias/1.xml
  def show
    @contratosinterventoria = Contratosinterventoria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contratosinterventoria }
    end
  end

  # GET /contratosinterventorias/new
  # GET /contratosinterventorias/new.xml
  def new
    @contratosinterventoria = Contratosinterventoria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contratosinterventoria }
    end
  end

  # GET /contratosinterventorias/1/edit
  def edit
    @contratosinterventoria = Contratosinterventoria.find(params[:id])
  end

  # POST /contratosinterventorias
  # POST /contratosinterventorias.xml
  def create
    @contratosinterventoria = Contratosinterventoria.new(params[:contratosinterventoria])

    respond_to do |format|
      if @contratosinterventoria.save
        format.html { redirect_to(@contratosinterventoria, :notice => 'Contratosinterventoria was successfully created.') }
        format.xml  { render :xml => @contratosinterventoria, :status => :created, :location => @contratosinterventoria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contratosinterventoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contratosinterventorias/1
  # PUT /contratosinterventorias/1.xml
  def update
    @contratosinterventoria = Contratosinterventoria.find(params[:id])

    respond_to do |format|
      if @contratosinterventoria.update_attributes(params[:contratosinterventoria])
        format.html { redirect_to(@contratosinterventoria, :notice => 'Contratosinterventoria was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contratosinterventoria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contratosinterventorias/1
  # DELETE /contratosinterventorias/1.xml
  def destroy
    @contratosinterventoria = Contratosinterventoria.find(params[:id])
    @contratosinterventoria.destroy

    respond_to do |format|
      format.html { redirect_to(contratosinterventorias_url) }
      format.xml  { head :ok }
    end
  end
end

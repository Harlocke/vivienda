class CatastrosdatosController < ApplicationController
  # GET /catastrosdatos
  # GET /catastrosdatos.xml
  def index
    @catastrosdatos = Catastrosdato.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catastrosdatos }
    end
  end

  # GET /catastrosdatos/1
  # GET /catastrosdatos/1.xml
  def show
    @catastrosdato = Catastrosdato.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catastrosdato }
    end
  end

  # GET /catastrosdatos/new
  # GET /catastrosdatos/new.xml
  def new
    @catastrosdato = Catastrosdato.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catastrosdato }
    end
  end

  # GET /catastrosdatos/1/edit
  def edit
    @catastrosdato = Catastrosdato.find(params[:id])
  end

  # POST /catastrosdatos
  # POST /catastrosdatos.xml
  def create
    @catastrosdato = Catastrosdato.new(params[:catastrosdato])

    respond_to do |format|
      if @catastrosdato.save
        format.html { redirect_to(@catastrosdato, :notice => 'Catastrosdato was successfully created.') }
        format.xml  { render :xml => @catastrosdato, :status => :created, :location => @catastrosdato }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catastrosdato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catastrosdatos/1
  # PUT /catastrosdatos/1.xml
  def update
    @catastrosdato = Catastrosdato.find(params[:id])

    respond_to do |format|
      if @catastrosdato.update_attributes(params[:catastrosdato])
        format.html { redirect_to(@catastrosdato, :notice => 'Catastrosdato was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catastrosdato.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catastrosdatos/1
  # DELETE /catastrosdatos/1.xml
  def destroy
    @catastrosdato = Catastrosdato.find(params[:id])
    @catastrosdato.destroy

    respond_to do |format|
      format.html { redirect_to(catastrosdatos_url) }
      format.xml  { head :ok }
    end
  end
end

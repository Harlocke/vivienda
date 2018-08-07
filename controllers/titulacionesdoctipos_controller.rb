class TitulacionesdoctiposController < ApplicationController
  # GET /titulacionesdoctipos
  # GET /titulacionesdoctipos.xml
  def index
    @titulacionesdoctipos = Titulacionesdoctipo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @titulacionesdoctipos }
    end
  end

  # GET /titulacionesdoctipos/1
  # GET /titulacionesdoctipos/1.xml
  def show
    @titulacionesdoctipo = Titulacionesdoctipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @titulacionesdoctipo }
    end
  end

  # GET /titulacionesdoctipos/new
  # GET /titulacionesdoctipos/new.xml
  def new
    @titulacionesdoctipo = Titulacionesdoctipo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @titulacionesdoctipo }
    end
  end

  # GET /titulacionesdoctipos/1/edit
  def edit
    @titulacionesdoctipo = Titulacionesdoctipo.find(params[:id])
  end

  # POST /titulacionesdoctipos
  # POST /titulacionesdoctipos.xml
  def create
    @titulacionesdoctipo = Titulacionesdoctipo.new(params[:titulacionesdoctipo])

    respond_to do |format|
      if @titulacionesdoctipo.save
        format.html { redirect_to(@titulacionesdoctipo, :notice => 'Titulacionesdoctipo was successfully created.') }
        format.xml  { render :xml => @titulacionesdoctipo, :status => :created, :location => @titulacionesdoctipo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @titulacionesdoctipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /titulacionesdoctipos/1
  # PUT /titulacionesdoctipos/1.xml
  def update
    @titulacionesdoctipo = Titulacionesdoctipo.find(params[:id])

    respond_to do |format|
      if @titulacionesdoctipo.update_attributes(params[:titulacionesdoctipo])
        format.html { redirect_to(@titulacionesdoctipo, :notice => 'Titulacionesdoctipo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @titulacionesdoctipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /titulacionesdoctipos/1
  # DELETE /titulacionesdoctipos/1.xml
  def destroy
    @titulacionesdoctipo = Titulacionesdoctipo.find(params[:id])
    @titulacionesdoctipo.destroy

    respond_to do |format|
      format.html { redirect_to(titulacionesdoctipos_url) }
      format.xml  { head :ok }
    end
  end
end

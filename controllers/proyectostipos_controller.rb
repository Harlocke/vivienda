class ProyectostiposController < ApplicationController
  # GET /proyectostipos
  # GET /proyectostipos.xml
  def index
    @proyectostipos = Proyectostipo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proyectostipos }
    end
  end

  # GET /proyectostipos/1
  # GET /proyectostipos/1.xml
  def show
    @proyectostipo = Proyectostipo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proyectostipo }
    end
  end

  # GET /proyectostipos/new
  # GET /proyectostipos/new.xml
  def new
    @proyectostipo = Proyectostipo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proyectostipo }
    end
  end

  # GET /proyectostipos/1/edit
  def edit
    @proyectostipo = Proyectostipo.find(params[:id])
  end

  # POST /proyectostipos
  # POST /proyectostipos.xml
  def create
    @proyectostipo = Proyectostipo.new(params[:proyectostipo])

    respond_to do |format|
      if @proyectostipo.save
        flash[:notice] = 'Proyectostipo was successfully created.'
        format.html { redirect_to(@proyectostipo) }
        format.xml  { render :xml => @proyectostipo, :status => :created, :location => @proyectostipo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proyectostipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proyectostipos/1
  # PUT /proyectostipos/1.xml
  def update
    @proyectostipo = Proyectostipo.find(params[:id])

    respond_to do |format|
      if @proyectostipo.update_attributes(params[:proyectostipo])
        flash[:notice] = 'Proyectostipo was successfully updated.'
        format.html { redirect_to(@proyectostipo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proyectostipo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proyectostipos/1
  # DELETE /proyectostipos/1.xml
  def destroy
    @proyectostipo = Proyectostipo.find(params[:id])
    @proyectostipo.destroy

    respond_to do |format|
      format.html { redirect_to(proyectostipos_url) }
      format.xml  { head :ok }
    end
  end
end

class ResolucionesclasesController < ApplicationController
  # GET /resolucionesclases
  # GET /resolucionesclases.xml
  def index
    @resolucionesclases = Resolucionesclase.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resolucionesclases }
    end
  end

  # GET /resolucionesclases/1
  # GET /resolucionesclases/1.xml
  def show
    @resolucionesclase = Resolucionesclase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resolucionesclase }
    end
  end

  # GET /resolucionesclases/new
  # GET /resolucionesclases/new.xml
  def new
    @resolucionesclase = Resolucionesclase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resolucionesclase }
    end
  end

  # GET /resolucionesclases/1/edit
  def edit
    @resolucionesclase = Resolucionesclase.find(params[:id])
  end

  # POST /resolucionesclases
  # POST /resolucionesclases.xml
  def create
    @resolucionesclase = Resolucionesclase.new(params[:resolucionesclase])

    respond_to do |format|
      if @resolucionesclase.save
        flash[:notice] = 'Resolucionesclase was successfully created.'
        format.html { redirect_to(@resolucionesclase) }
        format.xml  { render :xml => @resolucionesclase, :status => :created, :location => @resolucionesclase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resolucionesclase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resolucionesclases/1
  # PUT /resolucionesclases/1.xml
  def update
    @resolucionesclase = Resolucionesclase.find(params[:id])

    respond_to do |format|
      if @resolucionesclase.update_attributes(params[:resolucionesclase])
        flash[:notice] = 'Resolucionesclase was successfully updated.'
        format.html { redirect_to(@resolucionesclase) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resolucionesclase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resolucionesclases/1
  # DELETE /resolucionesclases/1.xml
  def destroy
    @resolucionesclase = Resolucionesclase.find(params[:id])
    @resolucionesclase.destroy

    respond_to do |format|
      format.html { redirect_to(resolucionesclases_url) }
      format.xml  { head :ok }
    end
  end
end

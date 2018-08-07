class ArrendamientossoportesController < ApplicationController
  # GET /arrendamientossoportes
  # GET /arrendamientossoportes.xml
  def index
    @arrendamientossoportes = Arrendamientossoporte.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @arrendamientossoportes }
    end
  end

  # GET /arrendamientossoportes/1
  # GET /arrendamientossoportes/1.xml
  def show
    @arrendamientossoporte = Arrendamientossoporte.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @arrendamientossoporte }
    end
  end

  # GET /arrendamientossoportes/new
  # GET /arrendamientossoportes/new.xml
  def new
    @arrendamientossoporte = Arrendamientossoporte.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @arrendamientossoporte }
    end
  end

  # GET /arrendamientossoportes/1/edit
  def edit
    @arrendamientossoporte = Arrendamientossoporte.find(params[:id])
  end

  # POST /arrendamientossoportes
  # POST /arrendamientossoportes.xml
  def create
    @arrendamientossoporte = Arrendamientossoporte.new(params[:arrendamientossoporte])

    respond_to do |format|
      if @arrendamientossoporte.save
        format.html { redirect_to(@arrendamientossoporte, :notice => 'Arrendamientossoporte was successfully created.') }
        format.xml  { render :xml => @arrendamientossoporte, :status => :created, :location => @arrendamientossoporte }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @arrendamientossoporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /arrendamientossoportes/1
  # PUT /arrendamientossoportes/1.xml
  def update
    @arrendamientossoporte = Arrendamientossoporte.find(params[:id])

    respond_to do |format|
      if @arrendamientossoporte.update_attributes(params[:arrendamientossoporte])
        format.html { redirect_to(@arrendamientossoporte, :notice => 'Arrendamientossoporte was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @arrendamientossoporte.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /arrendamientossoportes/1
  # DELETE /arrendamientossoportes/1.xml
  def destroy
    @arrendamientossoporte = Arrendamientossoporte.find(params[:id])
    @arrendamientossoporte.destroy

    respond_to do |format|
      format.html { redirect_to(arrendamientossoportes_url) }
      format.xml  { head :ok }
    end
  end
end

class InterbitacorasController < ApplicationController
  # GET /interbitacoras
  # GET /interbitacoras.xml
  def index
    @interbitacoras = Interbitacora.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @interbitacoras }
    end
  end

  # GET /interbitacoras/1
  # GET /interbitacoras/1.xml
  def show
    @interbitacora = Interbitacora.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @interbitacora }
    end
  end

  # GET /interbitacoras/new
  # GET /interbitacoras/new.xml
  def new
    @interbitacora = Interbitacora.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @interbitacora }
    end
  end

  # GET /interbitacoras/1/edit
  def edit
    @interbitacora = Interbitacora.find(params[:id])
  end

  # POST /interbitacoras
  # POST /interbitacoras.xml
  def create
    @interbitacora = Interbitacora.new(params[:interbitacora])

    respond_to do |format|
      if @interbitacora.save
        format.html { redirect_to(@interbitacora, :notice => 'Interbitacora was successfully created.') }
        format.xml  { render :xml => @interbitacora, :status => :created, :location => @interbitacora }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @interbitacora.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /interbitacoras/1
  # PUT /interbitacoras/1.xml
  def update
    @interbitacora = Interbitacora.find(params[:id])

    respond_to do |format|
      if @interbitacora.update_attributes(params[:interbitacora])
        format.html { redirect_to(@interbitacora, :notice => 'Interbitacora was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interbitacora.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /interbitacoras/1
  # DELETE /interbitacoras/1.xml
  def destroy
    @interbitacora = Interbitacora.find(params[:id])
    @interbitacora.destroy

    respond_to do |format|
      format.html { redirect_to(interbitacoras_url) }
      format.xml  { head :ok }
    end
  end
end

class GestionesController < ApplicationController
  # GET /gestiones
  # GET /gestiones.xml
  def index
    @gestiones = Gestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gestiones }
    end
  end

  # GET /gestiones/1
  # GET /gestiones/1.xml
  def show
    @gestion = Gestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gestion }
    end
  end

  # GET /gestiones/new
  # GET /gestiones/new.xml
  def new
    @gestion = Gestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gestion }
    end
  end

  # GET /gestiones/1/edit
  def edit
    @gestion = Gestion.find(params[:id])
  end

  # POST /gestiones
  # POST /gestiones.xml
  def create
    @gestion = Gestion.new(params[:gestion])

    respond_to do |format|
      if @gestion.save
        format.html { redirect_to(@gestion, :notice => 'Gestion was successfully created.') }
        format.xml  { render :xml => @gestion, :status => :created, :location => @gestion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gestiones/1
  # PUT /gestiones/1.xml
  def update
    @gestion = Gestion.find(params[:id])

    respond_to do |format|
      if @gestion.update_attributes(params[:gestion])
        format.html { redirect_to(@gestion, :notice => 'Gestion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gestion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gestiones/1
  # DELETE /gestiones/1.xml
  def destroy
    @gestion = Gestion.find(params[:id])
    @gestion.destroy

    respond_to do |format|
      format.html { redirect_to(gestiones_url) }
      format.xml  { head :ok }
    end
  end
end

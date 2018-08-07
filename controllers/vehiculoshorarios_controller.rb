class VehiculoshorariosController < ApplicationController
  before_filter :require_user
  # GET /vehiculoshorarios
  # GET /vehiculoshorarios.xml
  def index
    @vehiculoshorarios = Vehiculoshorario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vehiculoshorarios }
    end
  end

  # GET /vehiculoshorarios/1
  # GET /vehiculoshorarios/1.xml
  def show
    @vehiculoshorario = Vehiculoshorario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vehiculoshorario }
    end
  end

  # GET /vehiculoshorarios/new
  # GET /vehiculoshorarios/new.xml
  def new
    @vehiculoshorario = Vehiculoshorario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vehiculoshorario }
    end
  end

  # GET /vehiculoshorarios/1/edit
  def edit
    @vehiculoshorario = Vehiculoshorario.find(params[:id])
  end

  # POST /vehiculoshorarios
  # POST /vehiculoshorarios.xml
  def create
    @vehiculoshorario = Vehiculoshorario.new(params[:vehiculoshorario])

    respond_to do |format|
      if @vehiculoshorario.save
        format.html { redirect_to(@vehiculoshorario, :notice => 'Vehiculoshorario was successfully created.') }
        format.xml  { render :xml => @vehiculoshorario, :status => :created, :location => @vehiculoshorario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vehiculoshorario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vehiculoshorarios/1
  # PUT /vehiculoshorarios/1.xml
  def update
    @vehiculoshorario = Vehiculoshorario.find(params[:id])

    respond_to do |format|
      if @vehiculoshorario.update_attributes(params[:vehiculoshorario])
        format.html { redirect_to(@vehiculoshorario, :notice => 'Vehiculoshorario was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vehiculoshorario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vehiculoshorarios/1
  # DELETE /vehiculoshorarios/1.xml
  def destroy
    @vehiculoshorario = Vehiculoshorario.find(params[:id])
    @vehiculoshorario.destroy

    respond_to do |format|
      format.html { redirect_to(vehiculoshorarios_url) }
      format.xml  { head :ok }
    end
  end
end

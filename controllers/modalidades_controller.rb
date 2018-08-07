class ModalidadesController < ApplicationController
  before_filter :require_user
  # GET /modalidades
  # GET /modalidades.xml
  def index
    @modalidades = Modalidad.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @modalidades }
    end
  end

  # GET /modalidades/1
  # GET /modalidades/1.xml
  def show
    @modalidad = Modalidad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @modalidad }
    end
  end

  # GET /modalidades/new
  # GET /modalidades/new.xml
  def new
    @modalidad = Modalidad.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @modalidad }
    end
  end

  # GET /modalidades/1/edit
  def edit
    @modalidad = Modalidad.find(params[:id])
  end

  # POST /modalidades
  # POST /modalidades.xml
  def create
    @modalidad = Modalidad.new(params[:modalidad])

    respond_to do |format|
      if @modalidad.save
        format.html { redirect_to(@modalidad, :notice => 'Modalidad was successfully created.') }
        format.xml  { render :xml => @modalidad, :status => :created, :location => @modalidad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @modalidad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /modalidades/1
  # PUT /modalidades/1.xml
  def update
    @modalidad = Modalidad.find(params[:id])

    respond_to do |format|
      if @modalidad.update_attributes(params[:modalidad])
        format.html { redirect_to(@modalidad, :notice => 'Modalidad was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @modalidad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /modalidades/1
  # DELETE /modalidades/1.xml
  def destroy
    @modalidad = Modalidad.find(params[:id])
    @modalidad.destroy

    respond_to do |format|
      format.html { redirect_to(modalidades_url) }
      format.xml  { head :ok }
    end
  end
end

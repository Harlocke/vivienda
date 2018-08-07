class RelacionesController < ApplicationController
  
  before_filter :require_user

  def index
    @relaciones = Relacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relaciones }
    end
  end

  # GET /relaciones/1
  # GET /relaciones/1.xml
  def show
    @relacion = Relacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @relacion }
    end
  end

  # GET /relaciones/new
  # GET /relaciones/new.xml
  def new
    @relacion = Relacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @relacion }
    end
  end

  # GET /relaciones/1/edit
  def edit
    @relacion = Relacion.find(params[:id])
  end

  # POST /relaciones
  # POST /relaciones.xml
  def create
    @relacion = Relacion.new(params[:relacion])

    respond_to do |format|
      if @relacion.save
        format.html { redirect_to(@relacion, :notice => 'Relacion was successfully created.') }
        format.xml  { render :xml => @relacion, :status => :created, :location => @relacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @relacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /relaciones/1
  # PUT /relaciones/1.xml
  def update
    @relacion = Relacion.find(params[:id])

    respond_to do |format|
      if @relacion.update_attributes(params[:relacion])
        format.html { redirect_to(@relacion, :notice => 'Relacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @relacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /relaciones/1
  # DELETE /relaciones/1.xml
  def destroy
    @relacion = Relacion.find(params[:id])
    @relacion.destroy

    respond_to do |format|
      format.html { redirect_to(relaciones_url) }
      format.xml  { head :ok }
    end
  end
end

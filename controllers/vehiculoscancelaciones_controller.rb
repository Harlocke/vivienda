class VehiculoscancelacionesController < ApplicationController
  before_filter :require_user
  # GET /vehiculoscancelaciones
  # GET /vehiculoscancelaciones.xml
  def index
    @vehiculoscancelaciones = Vehiculoscancelacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vehiculoscancelaciones }
    end
  end

  # GET /vehiculoscancelaciones/1
  # GET /vehiculoscancelaciones/1.xml
  def show
    @vehiculoscancelacion = Vehiculoscancelacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vehiculoscancelacion }
    end
  end

  # GET /vehiculoscancelaciones/new
  # GET /vehiculoscancelaciones/new.xml
  def new
    @vehiculoscancelacion = Vehiculoscancelacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vehiculoscancelacion }
    end
  end

  # GET /vehiculoscancelaciones/1/edit
  def edit
    @vehiculoscancelacion = Vehiculoscancelacion.find(params[:id])
  end

  # POST /vehiculoscancelaciones
  # POST /vehiculoscancelaciones.xml
  def create
    @vehiculoscancelacion = Vehiculoscancelacion.new(params[:vehiculoscancelacion])

    respond_to do |format|
      if @vehiculoscancelacion.save
        format.html { redirect_to(@vehiculoscancelacion, :notice => 'Vehiculoscancelacion was successfully created.') }
        format.xml  { render :xml => @vehiculoscancelacion, :status => :created, :location => @vehiculoscancelacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vehiculoscancelacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vehiculoscancelaciones/1
  # PUT /vehiculoscancelaciones/1.xml
  def update
    @vehiculoscancelacion = Vehiculoscancelacion.find(params[:id])

    respond_to do |format|
      if @vehiculoscancelacion.update_attributes(params[:vehiculoscancelacion])
        format.html { redirect_to(@vehiculoscancelacion, :notice => 'Vehiculoscancelacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vehiculoscancelacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vehiculoscancelaciones/1
  # DELETE /vehiculoscancelaciones/1.xml
  def destroy
    @vehiculoscancelacion = Vehiculoscancelacion.find(params[:id])
    @vehiculoscancelacion.destroy

    respond_to do |format|
      format.html { redirect_to(vehiculoscancelaciones_url) }
      format.xml  { head :ok }
    end
  end
end

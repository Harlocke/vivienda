class Feria2010observacionesController < ApplicationController
  before_filter :require_user
  # GET /feria2010observaciones
  # GET /feria2010observaciones.xml
  def index
    @feria2010observaciones = Feria2010observacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2010observaciones }
    end
  end

  # GET /feria2010observaciones/1
  # GET /feria2010observaciones/1.xml
  def show
    @feria2010observacion = Feria2010observacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2010observacion }
    end
  end

  # GET /feria2010observaciones/new
  # GET /feria2010observaciones/new.xml
  def new
    @feria2010observacion = Feria2010observacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2010observacion }
    end
  end

  # GET /feria2010observaciones/1/edit
  def edit
    @feria2010observacion = Feria2010observacion.find(params[:id])
  end

  # POST /feria2010observaciones
  # POST /feria2010observaciones.xml
  def create
    @feria2010observacion = Feria2010observacion.new(params[:feria2010observacion])

    respond_to do |format|
      if @feria2010observacion.save
        format.html { redirect_to(@feria2010observacion, :notice => 'Feria2010observacion was successfully created.') }
        format.xml  { render :xml => @feria2010observacion, :status => :created, :location => @feria2010observacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2010observacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2010observaciones/1
  # PUT /feria2010observaciones/1.xml
  def update
    @feria2010observacion = Feria2010observacion.find(params[:id])

    respond_to do |format|
      if @feria2010observacion.update_attributes(params[:feria2010observacion])
        format.html { redirect_to(@feria2010observacion, :notice => 'Feria2010observacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2010observacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2010observaciones/1
  # DELETE /feria2010observaciones/1.xml
  def destroy
    @feria2010observacion = Feria2010observacion.find(params[:id])
    @feria2010observacion.destroy

    respond_to do |format|
      format.html { redirect_to(feria2010observaciones_url) }
      format.xml  { head :ok }
    end
  end
end

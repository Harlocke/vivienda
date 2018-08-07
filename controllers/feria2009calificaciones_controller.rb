class Feria2009calificacionesController < ApplicationController
  before_filter :require_user
  # GET /feria2009calificaciones
  # GET /feria2009calificaciones.xml
  def index
    @feria2009calificaciones = Feria2009calificacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2009calificaciones }
    end
  end

  # GET /feria2009calificaciones/1
  # GET /feria2009calificaciones/1.xml
  def show
    @feria2009calificacion = Feria2009calificacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2009calificacion }
    end
  end

  # GET /feria2009calificaciones/new
  # GET /feria2009calificaciones/new.xml
  def new
    @feria2009calificacion = Feria2009calificacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2009calificacion }
    end
  end

  # GET /feria2009calificaciones/1/edit
  def edit
    @feria2009calificacion = Feria2009calificacion.find(params[:id])
  end

  # POST /feria2009calificaciones
  # POST /feria2009calificaciones.xml
  def create
    @feria2009calificacion = Feria2009calificacion.new(params[:feria2009calificacion])

    respond_to do |format|
      if @feria2009calificacion.save
        format.html { redirect_to(@feria2009calificacion, :notice => 'Feria2009calificacion was successfully created.') }
        format.xml  { render :xml => @feria2009calificacion, :status => :created, :location => @feria2009calificacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2009calificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2009calificaciones/1
  # PUT /feria2009calificaciones/1.xml
  def update
    @feria2009calificacion = Feria2009calificacion.find(params[:id])

    respond_to do |format|
      if @feria2009calificacion.update_attributes(params[:feria2009calificacion])
        format.html { redirect_to(@feria2009calificacion, :notice => 'Feria2009calificacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2009calificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2009calificaciones/1
  # DELETE /feria2009calificaciones/1.xml
  def destroy
    @feria2009calificacion = Feria2009calificacion.find(params[:id])
    @feria2009calificacion.destroy

    respond_to do |format|
      format.html { redirect_to(feria2009calificaciones_url) }
      format.xml  { head :ok }
    end
  end
end

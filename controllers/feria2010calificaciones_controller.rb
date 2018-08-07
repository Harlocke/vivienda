class Feria2010calificacionesController < ApplicationController
  before_filter :require_user
  # GET /feria2010calificaciones
  # GET /feria2010calificaciones.xml
  def index
    @feria2010calificaciones = Feria2010calificacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feria2010calificaciones }
    end
  end

  # GET /feria2010calificaciones/1
  # GET /feria2010calificaciones/1.xml
  def show
    @feria2010calificacion = Feria2010calificacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feria2010calificacion }
    end
  end

  # GET /feria2010calificaciones/new
  # GET /feria2010calificaciones/new.xml
  def new
    @feria2010calificacion = Feria2010calificacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feria2010calificacion }
    end
  end

  # GET /feria2010calificaciones/1/edit
  def edit
    @feria2010calificacion = Feria2010calificacion.find(params[:id])
  end

  # POST /feria2010calificaciones
  # POST /feria2010calificaciones.xml
  def create
    @feria2010calificacion = Feria2010calificacion.new(params[:feria2010calificacion])

    respond_to do |format|
      if @feria2010calificacion.save
        format.html { redirect_to(@feria2010calificacion, :notice => 'Feria2010calificacion was successfully created.') }
        format.xml  { render :xml => @feria2010calificacion, :status => :created, :location => @feria2010calificacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feria2010calificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feria2010calificaciones/1
  # PUT /feria2010calificaciones/1.xml
  def update
    @feria2010calificacion = Feria2010calificacion.find(params[:id])

    respond_to do |format|
      if @feria2010calificacion.update_attributes(params[:feria2010calificacion])
        format.html { redirect_to(@feria2010calificacion, :notice => 'Feria2010calificacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feria2010calificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feria2010calificaciones/1
  # DELETE /feria2010calificaciones/1.xml
  def destroy
    @feria2010calificacion = Feria2010calificacion.find(params[:id])
    @feria2010calificacion.destroy

    respond_to do |format|
      format.html { redirect_to(feria2010calificaciones_url) }
      format.xml  { head :ok }
    end
  end
end

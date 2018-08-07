class ListasverificacionesController < ApplicationController
  # GET /listasverificaciones
  # GET /listasverificaciones.xml
  def index
    @listasverificaciones = Listasverificacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @listasverificaciones }
    end
  end

  # GET /listasverificaciones/1
  # GET /listasverificaciones/1.xml
  def show
    @listasverificacion = Listasverificacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @listasverificacion }
    end
  end

  # GET /listasverificaciones/new
  # GET /listasverificaciones/new.xml
  def new
    @listasverificacion = Listasverificacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @listasverificacion }
    end
  end

  # GET /listasverificaciones/1/edit
  def edit
    @listasverificacion = Listasverificacion.find(params[:id])
  end

  # POST /listasverificaciones
  # POST /listasverificaciones.xml
  def create
    @listasverificacion = Listasverificacion.new(params[:listasverificacion])

    respond_to do |format|
      if @listasverificacion.save
        flash[:notice] = 'Listasverificacion was successfully created.'
        format.html { redirect_to(@listasverificacion) }
        format.xml  { render :xml => @listasverificacion, :status => :created, :location => @listasverificacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @listasverificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /listasverificaciones/1
  # PUT /listasverificaciones/1.xml
  def update
    @listasverificacion = Listasverificacion.find(params[:id])

    respond_to do |format|
      if @listasverificacion.update_attributes(params[:listasverificacion])
        flash[:notice] = 'Listasverificacion was successfully updated.'
        format.html { redirect_to(@listasverificacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @listasverificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /listasverificaciones/1
  # DELETE /listasverificaciones/1.xml
  def destroy
    @listasverificacion = Listasverificacion.find(params[:id])
    @listasverificacion.destroy

    respond_to do |format|
      format.html { redirect_to(listasverificaciones_url) }
      format.xml  { head :ok }
    end
  end
end

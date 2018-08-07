class MejoramientosactualizacionesController < ApplicationController
  # GET /mejoramientosactualizaciones
  # GET /mejoramientosactualizaciones.xml
  def index
    @mejoramientosactualizaciones = Mejoramientosactualizacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mejoramientosactualizaciones }
    end
  end

  # GET /mejoramientosactualizaciones/1
  # GET /mejoramientosactualizaciones/1.xml
  def show
    @mejoramientosactualizacion = Mejoramientosactualizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mejoramientosactualizacion }
    end
  end

  # GET /mejoramientosactualizaciones/new
  # GET /mejoramientosactualizaciones/new.xml
  def new
    @mejoramientosactualizacion = Mejoramientosactualizacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mejoramientosactualizacion }
    end
  end

  # GET /mejoramientosactualizaciones/1/edit
  def edit
    @mejoramientosactualizacion = Mejoramientosactualizacion.find(params[:id])
  end

  # POST /mejoramientosactualizaciones
  # POST /mejoramientosactualizaciones.xml
  def create
    @mejoramientosactualizacion = Mejoramientosactualizacion.new(params[:mejoramientosactualizacion])

    respond_to do |format|
      if @mejoramientosactualizacion.save
        flash[:notice] = 'Mejoramientosactualizacion was successfully created.'
        format.html { redirect_to(@mejoramientosactualizacion) }
        format.xml  { render :xml => @mejoramientosactualizacion, :status => :created, :location => @mejoramientosactualizacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mejoramientosactualizacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mejoramientosactualizaciones/1
  # PUT /mejoramientosactualizaciones/1.xml
  def update
    @mejoramientosactualizacion = Mejoramientosactualizacion.find(params[:id])

    respond_to do |format|
      if @mejoramientosactualizacion.update_attributes(params[:mejoramientosactualizacion])
        flash[:notice] = 'Mejoramientosactualizacion was successfully updated.'
        format.html { redirect_to(@mejoramientosactualizacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mejoramientosactualizacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mejoramientosactualizaciones/1
  # DELETE /mejoramientosactualizaciones/1.xml
  def destroy
    @mejoramientosactualizacion = Mejoramientosactualizacion.find(params[:id])
    @mejoramientosactualizacion.destroy

    respond_to do |format|
      format.html { redirect_to(mejoramientosactualizaciones_url) }
      format.xml  { head :ok }
    end
  end
end

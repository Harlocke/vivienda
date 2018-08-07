class ArchivosactualizacionesController < ApplicationController
  # GET /archivosactualizaciones
  # GET /archivosactualizaciones.xml
  def index
    @archivosactualizaciones = Archivosactualizacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @archivosactualizaciones }
    end
  end

  # GET /archivosactualizaciones/1
  # GET /archivosactualizaciones/1.xml
  def show
    @archivosactualizacion = Archivosactualizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @archivosactualizacion }
    end
  end

  # GET /archivosactualizaciones/new
  # GET /archivosactualizaciones/new.xml
  def new
    @archivosactualizacion = Archivosactualizacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @archivosactualizacion }
    end
  end

  # GET /archivosactualizaciones/1/edit
  def edit
    @archivosactualizacion = Archivosactualizacion.find(params[:id])
  end

  # POST /archivosactualizaciones
  # POST /archivosactualizaciones.xml
  def create
    @archivosactualizacion = Archivosactualizacion.new(params[:archivosactualizacion])

    respond_to do |format|
      if @archivosactualizacion.save
        flash[:notice] = 'Archivosactualizacion was successfully created.'
        format.html { redirect_to(@archivosactualizacion) }
        format.xml  { render :xml => @archivosactualizacion, :status => :created, :location => @archivosactualizacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @archivosactualizacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /archivosactualizaciones/1
  # PUT /archivosactualizaciones/1.xml
  def update
    @archivosactualizacion = Archivosactualizacion.find(params[:id])

    respond_to do |format|
      if @archivosactualizacion.update_attributes(params[:archivosactualizacion])
        flash[:notice] = 'Archivosactualizacion was successfully updated.'
        format.html { redirect_to(@archivosactualizacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @archivosactualizacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /archivosactualizaciones/1
  # DELETE /archivosactualizaciones/1.xml
  def destroy
    @archivosactualizacion = Archivosactualizacion.find(params[:id])
    @archivosactualizacion.destroy

    respond_to do |format|
      format.html { redirect_to(archivosactualizaciones_url) }
      format.xml  { head :ok }
    end
  end
end

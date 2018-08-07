class TitulacionesactualizacionesController < ApplicationController
  # GET /titulacionesactualizaciones
  # GET /titulacionesactualizaciones.xml
  def index
    @titulacionesactualizaciones = Titulacionesactualizacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @titulacionesactualizaciones }
    end
  end

  # GET /titulacionesactualizaciones/1
  # GET /titulacionesactualizaciones/1.xml
  def show
    @titulacionesactualizacion = Titulacionesactualizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @titulacionesactualizacion }
    end
  end

  # GET /titulacionesactualizaciones/new
  # GET /titulacionesactualizaciones/new.xml
  def new
    @titulacionesactualizacion = Titulacionesactualizacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @titulacionesactualizacion }
    end
  end

  # GET /titulacionesactualizaciones/1/edit
  def edit
    @titulacionesactualizacion = Titulacionesactualizacion.find(params[:id])
  end

  # POST /titulacionesactualizaciones
  # POST /titulacionesactualizaciones.xml
  def create
    @titulacionesactualizacion = Titulacionesactualizacion.new(params[:titulacionesactualizacion])

    respond_to do |format|
      if @titulacionesactualizacion.save
        flash[:notice] = 'Titulacionesactualizacion was successfully created.'
        format.html { redirect_to(@titulacionesactualizacion) }
        format.xml  { render :xml => @titulacionesactualizacion, :status => :created, :location => @titulacionesactualizacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @titulacionesactualizacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /titulacionesactualizaciones/1
  # PUT /titulacionesactualizaciones/1.xml
  def update
    @titulacionesactualizacion = Titulacionesactualizacion.find(params[:id])

    respond_to do |format|
      if @titulacionesactualizacion.update_attributes(params[:titulacionesactualizacion])
        flash[:notice] = 'Titulacionesactualizacion was successfully updated.'
        format.html { redirect_to(@titulacionesactualizacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @titulacionesactualizacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /titulacionesactualizaciones/1
  # DELETE /titulacionesactualizaciones/1.xml
  def destroy
    @titulacionesactualizacion = Titulacionesactualizacion.find(params[:id])
    @titulacionesactualizacion.destroy

    respond_to do |format|
      format.html { redirect_to(titulacionesactualizaciones_url) }
      format.xml  { head :ok }
    end
  end
end

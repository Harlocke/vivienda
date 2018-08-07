class CatastrosinterseccionesController < ApplicationController
  # GET /catastrosintersecciones
  # GET /catastrosintersecciones.xml
  def index
    @catastrosintersecciones = Catastrosinterseccion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @catastrosintersecciones }
    end
  end

  # GET /catastrosintersecciones/1
  # GET /catastrosintersecciones/1.xml
  def show
    @catastrosinterseccion = Catastrosinterseccion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @catastrosinterseccion }
    end
  end

  # GET /catastrosintersecciones/new
  # GET /catastrosintersecciones/new.xml
  def new
    @catastrosinterseccion = Catastrosinterseccion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @catastrosinterseccion }
    end
  end

  # GET /catastrosintersecciones/1/edit
  def edit
    @catastrosinterseccion = Catastrosinterseccion.find(params[:id])
  end

  # POST /catastrosintersecciones
  # POST /catastrosintersecciones.xml
  def create
    @catastrosinterseccion = Catastrosinterseccion.new(params[:catastrosinterseccion])

    respond_to do |format|
      if @catastrosinterseccion.save
        format.html { redirect_to(@catastrosinterseccion, :notice => 'Catastrosinterseccion was successfully created.') }
        format.xml  { render :xml => @catastrosinterseccion, :status => :created, :location => @catastrosinterseccion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @catastrosinterseccion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /catastrosintersecciones/1
  # PUT /catastrosintersecciones/1.xml
  def update
    @catastrosinterseccion = Catastrosinterseccion.find(params[:id])

    respond_to do |format|
      if @catastrosinterseccion.update_attributes(params[:catastrosinterseccion])
        format.html { redirect_to(@catastrosinterseccion, :notice => 'Catastrosinterseccion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @catastrosinterseccion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /catastrosintersecciones/1
  # DELETE /catastrosintersecciones/1.xml
  def destroy
    @catastrosinterseccion = Catastrosinterseccion.find(params[:id])
    @catastrosinterseccion.destroy

    respond_to do |format|
      format.html { redirect_to(catastrosintersecciones_url) }
      format.xml  { head :ok }
    end
  end
end

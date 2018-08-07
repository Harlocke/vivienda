class TiposfactibilidadesController < ApplicationController
  # GET /tiposfactibilidades
  # GET /tiposfactibilidades.xml
  def index
    @tiposfactibilidades = Tiposfactibilidad.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposfactibilidades }
    end
  end

  # GET /tiposfactibilidades/1
  # GET /tiposfactibilidades/1.xml
  def show
    @tiposfactibilidad = Tiposfactibilidad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposfactibilidad }
    end
  end

  # GET /tiposfactibilidades/new
  # GET /tiposfactibilidades/new.xml
  def new
    @tiposfactibilidad = Tiposfactibilidad.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposfactibilidad }
    end
  end

  # GET /tiposfactibilidades/1/edit
  def edit
    @tiposfactibilidad = Tiposfactibilidad.find(params[:id])
  end

  # POST /tiposfactibilidades
  # POST /tiposfactibilidades.xml
  def create
    @tiposfactibilidad = Tiposfactibilidad.new(params[:tiposfactibilidad])

    respond_to do |format|
      if @tiposfactibilidad.save
        format.html { redirect_to(@tiposfactibilidad, :notice => 'Tiposfactibilidad was successfully created.') }
        format.xml  { render :xml => @tiposfactibilidad, :status => :created, :location => @tiposfactibilidad }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposfactibilidad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposfactibilidades/1
  # PUT /tiposfactibilidades/1.xml
  def update
    @tiposfactibilidad = Tiposfactibilidad.find(params[:id])

    respond_to do |format|
      if @tiposfactibilidad.update_attributes(params[:tiposfactibilidad])
        format.html { redirect_to(@tiposfactibilidad, :notice => 'Tiposfactibilidad was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposfactibilidad.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposfactibilidades/1
  # DELETE /tiposfactibilidades/1.xml
  def destroy
    @tiposfactibilidad = Tiposfactibilidad.find(params[:id])
    @tiposfactibilidad.destroy

    respond_to do |format|
      format.html { redirect_to(tiposfactibilidades_url) }
      format.xml  { head :ok }
    end
  end
end

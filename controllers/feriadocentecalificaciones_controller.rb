class FeriadocentecalificacionesController < ApplicationController
  before_filter :require_user
  # GET /feriadocentecalificaciones
  # GET /feriadocentecalificaciones.xml
  def index
    @feriadocentecalificaciones = Feriadocentecalificacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feriadocentecalificaciones }
    end
  end

  # GET /feriadocentecalificaciones/1
  # GET /feriadocentecalificaciones/1.xml
  def show
    @feriadocentecalificacion = Feriadocentecalificacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feriadocentecalificacion }
    end
  end

  # GET /feriadocentecalificaciones/new
  # GET /feriadocentecalificaciones/new.xml
  def new
    @feriadocentecalificacion = Feriadocentecalificacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feriadocentecalificacion }
    end
  end

  # GET /feriadocentecalificaciones/1/edit
  def edit
    @feriadocentecalificacion = Feriadocentecalificacion.find(params[:id])
  end

  # POST /feriadocentecalificaciones
  # POST /feriadocentecalificaciones.xml
  def create
    @feriadocentecalificacion = Feriadocentecalificacion.new(params[:feriadocentecalificacion])

    respond_to do |format|
      if @feriadocentecalificacion.save
        format.html { redirect_to(@feriadocentecalificacion, :notice => 'Feriadocentecalificacion was successfully created.') }
        format.xml  { render :xml => @feriadocentecalificacion, :status => :created, :location => @feriadocentecalificacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @feriadocentecalificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feriadocentecalificaciones/1
  # PUT /feriadocentecalificaciones/1.xml
  def update
    @feriadocentecalificacion = Feriadocentecalificacion.find(params[:id])

    respond_to do |format|
      if @feriadocentecalificacion.update_attributes(params[:feriadocentecalificacion])
        format.html { redirect_to(@feriadocentecalificacion, :notice => 'Feriadocentecalificacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feriadocentecalificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feriadocentecalificaciones/1
  # DELETE /feriadocentecalificaciones/1.xml
  def destroy
    @feriadocentecalificacion = Feriadocentecalificacion.find(params[:id])
    @feriadocentecalificacion.destroy

    respond_to do |format|
      format.html { redirect_to(feriadocentecalificaciones_url) }
      format.xml  { head :ok }
    end
  end
end

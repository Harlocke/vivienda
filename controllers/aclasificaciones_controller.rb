class AclasificacionesController < ApplicationController
  # GET /aclasificaciones
  # GET /aclasificaciones.xml
  def index
    @aclasificaciones = Aclasificacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @aclasificaciones }
    end
  end

  # GET /aclasificaciones/1
  # GET /aclasificaciones/1.xml
  def show
    @aclasificacion = Aclasificacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @aclasificacion }
    end
  end

  # GET /aclasificaciones/new
  # GET /aclasificaciones/new.xml
  def new
    @aclasificacion = Aclasificacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @aclasificacion }
    end
  end

  # GET /aclasificaciones/1/edit
  def edit
    @aclasificacion = Aclasificacion.find(params[:id])
  end

  # POST /aclasificaciones
  # POST /aclasificaciones.xml
  def create
    @aclasificacion = Aclasificacion.new(params[:aclasificacion])

    respond_to do |format|
      if @aclasificacion.save
        format.html { redirect_to(@aclasificacion, :notice => 'Aclasificacion was successfully created.') }
        format.xml  { render :xml => @aclasificacion, :status => :created, :location => @aclasificacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @aclasificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /aclasificaciones/1
  # PUT /aclasificaciones/1.xml
  def update
    @aclasificacion = Aclasificacion.find(params[:id])

    respond_to do |format|
      if @aclasificacion.update_attributes(params[:aclasificacion])
        format.html { redirect_to(@aclasificacion, :notice => 'Aclasificacion was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @aclasificacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /aclasificaciones/1
  # DELETE /aclasificaciones/1.xml
  def destroy
    @aclasificacion = Aclasificacion.find(params[:id])
    @aclasificacion.destroy

    respond_to do |format|
      format.html { redirect_to(aclasificaciones_url) }
      format.xml  { head :ok }
    end
  end
end

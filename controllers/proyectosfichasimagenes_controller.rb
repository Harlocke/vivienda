class ProyectosfichasimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_proyectosficha_and_proyectosfichasimagen

  def index
    @proyectosfichasimagenes = @proyectosficha.proyectosfichasimagenes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proyectosfichasimagenes }
    end
  end

  def show
    @proyectosfichasimagen = Proyectosfichasimagen.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proyectosfichasimagen }
    end
  end

  def new
    @proyectosfichasimagen = Proyectosfichasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proyectosfichasimagen }
    end
  end

  def edit
    @proyectosfichasimagen = Proyectosfichasimagen.find(params[:id])
  end

  def create
    @proyectosfichasimagen = Proyectosfichasimagen.new(params[:proyectosfichasimagen])
    @proyectosfichasimagen.proyectosficha_id = @proyectosficha.id
    respond_to do |format|
      if @proyectosfichasimagen.save
        format.html { redirect_to proy_proyectosfichasimagenes_path(@proyectosficha) }
        format.xml  { render :xml => @proyectosfichasimagen, :status => :created, :location => @proyectosfichasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proyectosfichasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @proyectosfichasimagen = Proyectosfichasimagen.find(params[:id])
    respond_to do |format|
      if @proyectosfichasimagen.update_attributes(params[:proyectosfichasimagen])
        format.html { redirect_to proy_proyectosfichasimagenes_url(@proyectosficha) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proyectosfichasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @proyectosfichasimagen = Proyectosfichasimagen.find(params[:id])
    @proyectosfichasimagen.destroy
    respond_to do |format|
      format.html { redirect_to proy_proyectosfichasimagenes_url(@proyectosficha) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_proyectosficha_and_proyectosfichasimagen
      @proyectosficha = Proyectosficha.find(params[:proyectosficha_id])
      @proyectosfichasimagen = Proyectosfichasimagen.find(params[:id]) if params[:id]
  end
end

  #
#  # GET /proyectosfichasimagenes
#  # GET /proyectosfichasimagenes.xml
#  def index
#    @proyectosfichasimagenes = Proyectosfichasimagen.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @proyectosfichasimagenes }
#    end
#  end
#
#  # GET /proyectosfichasimagenes/1
#  # GET /proyectosfichasimagenes/1.xml
#  def show
#    @proyectosfichasimagen = Proyectosfichasimagen.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @proyectosfichasimagen }
#    end
#  end
#
#  # GET /proyectosfichasimagenes/new
#  # GET /proyectosfichasimagenes/new.xml
#  def new
#    @proyectosfichasimagen = Proyectosfichasimagen.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @proyectosfichasimagen }
#    end
#  end
#
#  # GET /proyectosfichasimagenes/1/edit
#  def edit
#    @proyectosfichasimagen = Proyectosfichasimagen.find(params[:id])
#  end
#
#  # POST /proyectosfichasimagenes
#  # POST /proyectosfichasimagenes.xml
#  def create
#    @proyectosfichasimagen = Proyectosfichasimagen.new(params[:proyectosfichasimagen])
#
#    respond_to do |format|
#      if @proyectosfichasimagen.save
#        flash[:notice] = 'Proyectosfichasimagen was successfully created.'
#        format.html { redirect_to(@proyectosfichasimagen) }
#        format.xml  { render :xml => @proyectosfichasimagen, :status => :created, :location => @proyectosfichasimagen }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @proyectosfichasimagen.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /proyectosfichasimagenes/1
#  # PUT /proyectosfichasimagenes/1.xml
#  def update
#    @proyectosfichasimagen = Proyectosfichasimagen.find(params[:id])
#
#    respond_to do |format|
#      if @proyectosfichasimagen.update_attributes(params[:proyectosfichasimagen])
#        flash[:notice] = 'Proyectosfichasimagen was successfully updated.'
#        format.html { redirect_to(@proyectosfichasimagen) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @proyectosfichasimagen.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /proyectosfichasimagenes/1
#  # DELETE /proyectosfichasimagenes/1.xml
#  def destroy
#    @proyectosfichasimagen = Proyectosfichasimagen.find(params[:id])
#    @proyectosfichasimagen.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(proyectosfichasimagenes_url) }
#      format.xml  { head :ok }
#    end
#  end
#end

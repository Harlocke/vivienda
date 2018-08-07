class ResolucionesimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_resolucion_and_resolucionesimagen

  def index
    resolucion   = Resolucion.find(params[:resolucion_id])
    @resolucionesimagenes = resolucion.resolucionesimagenes.all
  end

  def new
    @resolucionesimagen = Resolucionesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resolucionesimagen }
    end
  end

  def create
    @resolucionesimagen = Resolucionesimagen.new(params[:resolucionesimagen])
    @resolucionesimagen.resolucion_id = @resolucion.id
    @resolucionesimagen.user_id = is_admin
    respond_to do |format|
      if @resolucionesimagen.save
        format.html { redirect_to edit_resolucion_path(@resolucion) }
        format.xml  { render :xml => @resolucionesimagen, :status => :created, :location => @resolucionesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resolucionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @resolucionesimagen = Resolucionesimagen.find(params[:id])
    respond_to do |format|
      if @resolucionesimagen.update_attributes(params[:resolucionesimagen])
        format.html { redirect_to resolucion_resolucionesimagenes_path(@resolucion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resolucionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    resolucionesimagen   = Resolucionesimagen.find(params[:id])
    @resolucion         = resolucionesimagen.resolucion
    @resolucionesimagen  = Resolucionesimagen.new
    resolucionesimagen.destroy
    respond_to do |format|
      format.js { render :action => "resolucionesimagenes" }
    end
  end

  def find_resolucion_and_resolucionesimagen
      @resolucion = Resolucion.find(params[:resolucion_id])
      @resolucionesimagen = Resolucionesimagen.find(params[:id]) if params[:id]
  end

end

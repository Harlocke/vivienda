class LegalizacionesimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_legalizacion_and_legalizacionesimagen

  def index
    legalizacion   = Legalizacion.find(params[:legalizacion_id])
    @legalizacionesimagenes = legalizacion.legalizacionesimagenes.all
  end

  def new
    @legalizacionesimagen = Legalizacionesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @legalizacionesimagen }
    end
  end

  def create
    @legalizacionesimagen = Legalizacionesimagen.new(params[:legalizacionesimagen])
    @legalizacionesimagen.legalizacion_id = @legalizacion.id
    @legalizacionesimagen.user_id = is_admin
    respond_to do |format|
      if @legalizacionesimagen.save
        format.html { redirect_to edit_legalizacion_path(@legalizacion) }
        format.xml  { render :xml => @legalizacionesimagen, :status => :created, :location => @legalizacionesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @legalizacionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @legalizacionesimagen = Legalizacionesimagen.find(params[:id])
    respond_to do |format|
      if @legalizacionesimagen.update_attributes(params[:legalizacionesimagen])
        format.html { redirect_to legalizacion_legalizacionesimagenes_path(@legalizacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @legalizacionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    legalizacionesimagen   = Legalizacionesimagen.find(params[:id])
    @legalizacion         = legalizacionesimagen.legalizacion
    @legalizacionesimagen  = Legalizacionesimagen.new
    legalizacionesimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_legalizacion_and_legalizacionesimagen
      @legalizacion = Legalizacion.find(params[:legalizacion_id])
      @legalizacionesimagen = Legalizacionesimagen.find(params[:id]) if params[:id]
  end
end
class LicitacionesimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_licitacion_and_licitacionesimagen

  def index
    licitacion   = Licitacion.find(params[:licitacion_id])
    @licitacionesimagenes = licitacion.licitacionesimagenes.all
  end

  def new
    @licitacionesimagen = Licitacionesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @licitacionesimagen }
    end
  end

  def create
    @licitacionesimagen = Licitacionesimagen.new(params[:licitacionesimagen])
    @licitacionesimagen.licitacion_id = @licitacion.id
    respond_to do |format|
      if @licitacionesimagen.save
        format.html { redirect_to edit_licitacion_path(@licitacion) }
        format.xml  { render :xml => @licitacionesimagen, :status => :created, :location => @licitacionesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @licitacionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @licitacionesimagen = Licitacionesimagen.find(params[:id])
    respond_to do |format|
      if @licitacionesimagen.update_attributes(params[:licitacionesimagen])
        format.html { redirect_to licitacion_licitacionesimagenes_path(@licitacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @licitacionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    licitacionesimagen   = Licitacionesimagen.find(params[:id])
    @licitacion         = licitacionesimagen.licitacion
    @licitacionesimagen  = Licitacionesimagen.new
    licitacionesimagen.destroy
    respond_to do |format|
      format.js { render :action => "licitacionesimagenes" }
    end
  end

  def find_licitacion_and_licitacionesimagen
      @licitacion = Licitacion.find(params[:licitacion_id])
      @licitacionesimagen = Licitacionesimagen.find(params[:id]) if params[:id]
  end

end

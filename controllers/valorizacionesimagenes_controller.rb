class ValorizacionesimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_valorizacion_and_valorizacionesimagen

  def index
    valorizacion   = Valorizacion.find(params[:valorizacion_id])
    @valorizacionesimagenes = valorizacion.valorizacionesimagenes.all
  end

  def new
    @valorizacionesimagen = Valorizacionesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @valorizacionesimagen }
    end
  end

  def create
    @valorizacionesimagen = Valorizacionesimagen.new(params[:valorizacionesimagen])
    @valorizacionesimagen.valorizacion_id = @valorizacion.id
    respond_to do |format|
      if @valorizacionesimagen.save
        format.html { redirect_to edit_valorizacion_path(@valorizacion) }
        format.xml  { render :xml => @valorizacionesimagen, :status => :created, :location => @valorizacionesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @valorizacionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @valorizacionesimagen = Valorizacionesimagen.find(params[:id])
    respond_to do |format|
      if @valorizacionesimagen.update_attributes(params[:valorizacionesimagen])
        format.html { redirect_to valorizacion_valorizacionesimagenes_path(@valorizacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @valorizacionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    valorizacionesimagen   = Valorizacionesimagen.find(params[:id])
    @valorizacion         = valorizacionesimagen.valorizacion
    @valorizacionesimagen  = Valorizacionesimagen.new
    valorizacionesimagen.destroy
    respond_to do |format|
      format.js { render :action => "valorizacionesimagenes" }
    end
  end

  def find_valorizacion_and_valorizacionesimagen
      @valorizacion = Valorizacion.find(params[:valorizacion_id])
      @valorizacionesimagen = Valorizacionesimagen.find(params[:id]) if params[:id]
  end

end


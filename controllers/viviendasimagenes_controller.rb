class ViviendasimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_vivienda_and_viviendasimagen

  def index
    vivienda   = Vivienda.find(params[:vivienda_id])
    @viviendasimagenes = vivienda.viviendasimagenes.all
  end

  def new
    @viviendasimagen = Viviendasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viviendasimagen }
    end
  end

  def create
    @viviendasimagen = Viviendasimagen.new(params[:viviendasimagen])
    @viviendasimagen.vivienda_id = @vivienda.id
    respond_to do |format|
      if @viviendasimagen.save
        format.html { redirect_to edit_vivienda_path(@vivienda) }
        format.xml  { render :xml => @viviendasimagen, :status => :created, :location => @viviendasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viviendasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @viviendasimagen = Viviendasimagen.find(params[:id])
    respond_to do |format|
      if @viviendasimagen.update_attributes(params[:viviendasimagen])
        format.html { redirect_to vivienda_viviendasimagenes_path(@vivienda) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @viviendasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    viviendasimagen   = Viviendasimagen.find(params[:id])
    @vivienda         = viviendasimagen.vivienda
    @viviendasimagen  = Viviendasimagen.new
    viviendasimagen.destroy
    respond_to do |format|
      format.js { render :action => "viviendasimagenes" }
    end
  end

  def find_vivienda_and_viviendasimagen
      @vivienda = Vivienda.find(params[:vivienda_id])
      @viviendasimagen = Viviendasimagen.find(params[:id]) if params[:id]
  end


end
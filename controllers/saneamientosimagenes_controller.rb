class SaneamientosimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_saneamiento_and_saneamientosimagen

  def index
    saneamiento   = Saneamiento.find(params[:saneamiento_id])
    @saneamientosimagenes = saneamiento.saneamientosimagenes.all
  end

  def new
    @saneamientosimagen = Saneamientosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @saneamientosimagen }
    end
  end

  def create
    @saneamientosimagen = Saneamientosimagen.new(params[:saneamientosimagen])
    @saneamientosimagen.saneamiento_id = @saneamiento.id
    @saneamientosimagen.user_id = is_admin
    respond_to do |format|
      if @saneamientosimagen.save
        format.html { redirect_to edit_saneamiento_path(@saneamiento) }
        format.xml  { render :xml => @saneamientosimagen, :status => :created, :location => @saneamientosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @saneamientosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @saneamientosimagen = Saneamientosimagen.find(params[:id])
    respond_to do |format|
      if @saneamientosimagen.update_attributes(params[:saneamientosimagen])
        format.html { redirect_to saneamiento_saneamientosimagenes_path(@saneamiento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @saneamientosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    saneamientosimagen   = Saneamientosimagen.find(params[:id])
    @saneamiento         = saneamientosimagen.saneamiento
    @saneamientosimagen  = Saneamientosimagen.new
    saneamientosimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_saneamiento_and_saneamientosimagen
      @saneamiento = Saneamiento.find(params[:saneamiento_id])
      @saneamientosimagen = Saneamientosimagen.find(params[:id]) if params[:id]
  end
end
class ViviendasusadasimagenesController < ApplicationController

  before_filter :require_user

  before_filter :find_viviendasusada_and_viviendasusadasimagen

  def index
    viviendasusada   = Viviendasusada.find(params[:viviendasusada_id])
    @viviendasusadasimagenes = viviendasusada.viviendasusadasimagenes.all
  end

  def new
    @viviendasusadasimagen = Viviendasusadasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viviendasusadasimagen }
    end
  end

  def create
    @viviendasusadasimagen = Viviendasusadasimagen.new(params[:viviendasusadasimagen])
    @viviendasusadasimagen.viviendasusada_id = @viviendasusada.id
    respond_to do |format|
      if @viviendasusadasimagen.save
        format.html { redirect_to edit_viviendasusada_path(@viviendasusada) }
        format.xml  { render :xml => @viviendasusadasimagen, :status => :created, :location => @viviendasusadasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viviendasusadasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @viviendasusadasimagen = Viviendasusadasimagen.find(params[:id])
    respond_to do |format|
      if @viviendasusadasimagen.update_attributes(params[:viviendasusadasimagen])
        format.html { redirect_to viviendasusada_viviendasusadasimagenes_path(@viviendasusada) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @viviendasusadasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    viviendasusadasimagen   = Viviendasusadasimagen.find(params[:id])
    @viviendasusada         = viviendasusadasimagen.viviendasusada
    @viviendasusadasimagen  = Viviendasusadasimagen.new
    viviendasusadasimagen.destroy
    respond_to do |format|
      format.js { render :action => "viviendasusadasimagenes" }
    end
  end

  def find_viviendasusada_and_viviendasusadasimagen
      @viviendasusada = Viviendasusada.find(params[:viviendasusada_id])
      @viviendasusadasimagen = Viviendasusadasimagen.find(params[:id]) if params[:id]
  end

end


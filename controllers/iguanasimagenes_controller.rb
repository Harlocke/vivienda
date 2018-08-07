class IguanasimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_iguana_and_iguanasimagen

  def index
    iguana   = Iguana.find(params[:iguana_id])
    @iguanasimagenes = iguana.iguanasimagenes.all
  end

  def new
    @iguanasimagen = Iguanasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @iguanasimagen }
    end
  end

  def create
    @iguanasimagen = Iguanasimagen.new(params[:iguanasimagen])
    @iguanasimagen.iguana_id = @iguana.id
    respond_to do |format|
      if @iguanasimagen.save
        is_trigger_iguana(@iguana.id,is_admin,'iguanasimagen','I',@iguanasimagen.id)
        format.html { redirect_to edit_iguana_path(@iguana) }
        format.xml  { render :xml => @iguanasimagen, :status => :created, :location => @iguanasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @iguanasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @iguanasimagen = Iguanasimagen.find(params[:id])
    respond_to do |format|
      if @iguanasimagen.update_attributes(params[:iguanasimagen])
        format.html { redirect_to iguana_iguanasimagenes_path(@iguana) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @iguanasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    iguanasimagen   = Iguanasimagen.find(params[:id])
    @iguana         = iguanasimagen.iguana
    @iguanasimagen  = Iguanasimagen.new
    iguanasimagen.destroy
    respond_to do |format|
      format.js { render :action => "iguanasimagenes" }
    end
  end

  def find_iguana_and_iguanasimagen
      @iguana = Iguana.find(params[:iguana_id])
      @iguanasimagen = Iguanasimagen.find(params[:id]) if params[:id]
  end

end


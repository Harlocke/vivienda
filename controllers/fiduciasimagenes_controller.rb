class FiduciasimagenesController < ApplicationController

  before_filter :require_user

  before_filter :find_fiduciascontrato_and_fiduciasimagen

  def index
    @fiduciasimagenes = @fiduciascontrato.fiduciasimagenes.find(:all, :order => "to_number(mes) asc")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fiduciasimagenes }
    end
  end

  def show
    @fiduciasimagen = Fiduciasimagen.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fiduciasimagen }
    end
  end

  def new
    @fiduciasimagen = Fiduciasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fiduciasimagen }
    end
  end

  def edit
    @fiduciasimagen = Fiduciasimagen.find(params[:id])
  end

  def create
    @fiduciasimagen = Fiduciasimagen.new(params[:fiduciasimagen])
    @fiduciasimagen.fiduciascontrato_id = @fiduciascontrato.id
    @fiduciasimagen.user_id = is_admin
    respond_to do |format|
      if @fiduciasimagen.save
        format.html { redirect_to img_fiduciasimagenes_path(@fiduciascontrato) }
        format.xml  { render :xml => @fiduciasimagen, :status => :created, :location => @fiduciasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fiduciasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @fiduciasimagen = Fiduciasimagen.find(params[:id])
    respond_to do |format|
      if @fiduciasimagen.update_attributes(params[:fiduciasimagen])
        format.html { redirect_to img_fiduciasimagenes_url(@fiduciascontrato) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fiduciasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @fiduciasimagen = Fiduciasimagen.find(params[:id])
    @fiduciasimagen.destroy
    respond_to do |format|
      format.html { redirect_to img_fiduciasimagenes_url(@fiduciascontrato) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_fiduciascontrato_and_fiduciasimagen
      @fiduciascontrato = Fiduciascontrato.find(params[:fiduciascontrato_id])
      @fiduciasimagen = Fiduciasimagen.find(params[:id]) if params[:id]
  end
end

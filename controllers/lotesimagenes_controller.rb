class LotesimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_lote_and_lotesimagen

  def index
    lote   = Lote.find(params[:lote_id])
    @lotesimagenes = lote.lotesimagenes.all
  end

  def new
    @lotesimagen = Lotesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lotesimagen }
    end
  end

  def create
    @lotesimagen = Lotesimagen.new(params[:lotesimagen])
    @lotesimagen.lote_id = @lote.id
    respond_to do |format|
      if @lotesimagen.save
        format.html { redirect_to edit_lote_path(@lote) }
        format.xml  { render :xml => @lotesimagen, :status => :created, :location => @lotesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lotesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @lotesimagen = Lotesimagen.find(params[:id])
    respond_to do |format|
      if @lotesimagen.update_attributes(params[:lotesimagen])
        format.html { redirect_to lote_lotesimagenes_path(@lote) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lotesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    lotesimagen   = Lotesimagen.find(params[:id])
    @lote         = lotesimagen.lote
    @lotesimagen  = Lotesimagen.new
    lotesimagen.destroy
    respond_to do |format|
      format.js { render :action => "lotesimagenes" }
    end
  end

  def find_lote_and_lotesimagen
      @lote = Lote.find(params[:lote_id])
      @lotesimagen = Lotesimagen.find(params[:id]) if params[:id]
  end

end

class PendientesimagenesController < ApplicationController

  before_filter :require_user

  before_filter :find_pendientesnota_and_pendientesimagen

  def index
    @pendientesimagenes = @pendientesnota.pendientesimagenes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pendientesimagenes }
    end
  end

  def show
    @pendientesimagen = Pendientesimagen.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pendientesimagen }
    end
  end

  def new
    @pendientesimagen = Pendientesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pendientesimagen }
    end
  end

  def edit
    @pendientesimagen = Pendientesimagen.find(params[:id])
  end

  def create
    @pendientesimagen = Pendientesimagen.new(params[:pendientesimagen])
    @pendientesimagen.pendientesnota_id = @pendientesnota.id
    @pendientesimagen.user_id = is_admin
    respond_to do |format|
      if @pendientesimagen.save
        format.html { redirect_to img_pendientesimagenes_path(@pendientesnota) }
        format.xml  { render :xml => @pendientesimagen, :status => :created, :location => @pendientesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pendientesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @pendientesimagen = Pendientesimagen.find(params[:id])
    respond_to do |format|
      if @pendientesimagen.update_attributes(params[:pendientesimagen])
        format.html { redirect_to img_pendientesimagenes_url(@pendientesnota) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pendientesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @pendientesimagen = Pendientesimagen.find(params[:id])
    @pendientesimagen.destroy
    respond_to do |format|
      format.html { redirect_to img_pendientesimagenes_url(@pendientesnota) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_pendientesnota_and_pendientesimagen
      @pendientesnota = Pendientesnota.find(params[:pendientesnota_id])
      @pendientesimagen = Pendientesimagen.find(params[:id]) if params[:id]
  end
end

class ImpresorasimagenesController < ApplicationController

  before_filter :require_user

  before_filter :find_impresorasreporte_and_impresorasimagen

  def index
    @impresorasimagenes = @impresorasreporte.impresorasimagenes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @impresorasimagenes }
    end
  end

  def show
    @impresorasimagen = Impresorasimagen.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @impresorasimagen }
    end
  end

  def new
    @impresorasimagen = Impresorasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @impresorasimagen }
    end
  end

  def edit
    @impresorasimagen = Impresorasimagen.find(params[:id])
  end

  def create
    @impresorasimagen = Impresorasimagen.new(params[:impresorasimagen])
    @impresorasimagen.impresorasreporte_id = @impresorasreporte.id
    @impresorasimagen.user_id = is_admin
    respond_to do |format|
      if @impresorasimagen.save
        format.html { redirect_to img_impresorasimagenes_path(@impresorasreporte) }
        format.xml  { render :xml => @impresorasimagen, :status => :created, :location => @impresorasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @impresorasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @impresorasimagen = Impresorasimagen.find(params[:id])
    respond_to do |format|
      if @impresorasimagen.update_attributes(params[:impresorasimagen])
        format.html { redirect_to img_impresorasimagenes_url(@impresorasreporte) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @impresorasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @impresorasimagen = Impresorasimagen.find(params[:id])
    @impresorasimagen.destroy
    respond_to do |format|
      format.html { redirect_to img_impresorasimagenes_url(@impresorasreporte) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_impresorasreporte_and_impresorasimagen
      @impresorasreporte = Impresorasreporte.find(params[:impresorasreporte_id])
      @impresorasimagen = Impresorasimagen.find(params[:id]) if params[:id]
  end
end

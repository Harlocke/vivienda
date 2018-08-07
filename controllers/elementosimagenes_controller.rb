class ElementosimagenesController < ApplicationController

  before_filter :require_user

  before_filter :find_elementosmantenimiento_and_elementosimagen

  def index
    @elementosimagenes = @elementosmantenimiento.elementosimagenes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @elementosimagenes }
    end
  end

  def show
    @elementosimagen = Elementosimagen.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @elementosimagen }
    end
  end

  def new
    @elementosimagen = Elementosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @elementosimagen }
    end
  end

  def edit
    @elementosimagen = Elementosimagen.find(params[:id])
  end

  def create
    @elementosimagen = Elementosimagen.new(params[:elementosimagen])
    @elementosimagen.elementosmantenimiento_id = @elementosmantenimiento.id
    @elementosimagen.user_id = is_admin
    respond_to do |format|
      if @elementosimagen.save
        format.html { redirect_to img_elementosimagenes_path(@elementosmantenimiento) }
        format.xml  { render :xml => @elementosimagen, :status => :created, :location => @elementosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @elementosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @elementosimagen = Elementosimagen.find(params[:id])
    respond_to do |format|
      if @elementosimagen.update_attributes(params[:elementosimagen])
        format.html { redirect_to img_elementosimagenes_url(@elementosmantenimiento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @elementosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @elementosimagen = Elementosimagen.find(params[:id])
    @elementosimagen.destroy
    respond_to do |format|
      format.html { redirect_to img_elementosimagenes_url(@elementosmantenimiento) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_elementosmantenimiento_and_elementosimagen
      @elementosmantenimiento = Elementosmantenimiento.find(params[:elementosmantenimiento_id])
      @elementosimagen = Elementosimagen.find(params[:id]) if params[:id]
  end
end

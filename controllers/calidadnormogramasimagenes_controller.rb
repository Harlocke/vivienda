class CalidadnormogramasimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_calidadnormograma_and_calidadnormogramasimagen

  def index
    calidadnormograma   = Calidadnormograma.find(params[:calidadnormograma_id])
    @calidadnormogramasimagenes = calidadnormograma.calidadnormogramasimagenes.all
  end

  def new
    @calidadnormogramasimagen = Calidadnormogramasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @calidadnormogramasimagen }
    end
  end

  def create
    @calidadnormogramasimagen = Calidadnormogramasimagen.new(params[:calidadnormogramasimagen])
    @calidadnormogramasimagen.calidadnormograma_id = @calidadnormograma.id
    respond_to do |format|
      if @calidadnormogramasimagen.save
        format.html { redirect_to edit_calidadnormograma_path(@calidadnormograma) }
        format.xml  { render :xml => @calidadnormogramasimagen, :status => :created, :location => @calidadnormogramasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calidadnormogramasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @calidadnormogramasimagen = Calidadnormogramasimagen.find(params[:id])
    respond_to do |format|
      if @calidadnormogramasimagen.update_attributes(params[:calidadnormogramasimagen])
        format.html { redirect_to calidadnormograma_calidadnormogramasimagenes_path(@calidadnormograma) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calidadnormogramasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    calidadnormogramasimagen   = Calidadnormogramasimagen.find(params[:id])
    @calidadnormograma         = calidadnormogramasimagen.calidadnormograma
    @calidadnormogramasimagen  = Calidadnormogramasimagen.new
    calidadnormogramasimagen.destroy
    respond_to do |format|
      format.js { render :action => "calidadnormogramasimagenes" }
    end
  end

  def find_calidadnormograma_and_calidadnormogramasimagen
      @calidadnormograma = Calidadnormograma.find(params[:calidadnormograma_id])
      @calidadnormogramasimagen = Calidadnormogramasimagen.find(params[:id]) if params[:id]
  end

end

class MejoraelementosimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_mejoramientoselemento_and_mejoraelementosimagen, :except=>"destroy2"

  def index
    mejoramientoselemento   = Mejoramientoselemento.find(params[:mejoramientoselemento_id])
    @mejoraelementosimagenes = mejoramientoselemento.mejoraelementosimagenes.all
  end

  def new
    @mejoraelementosimagen = Mejoraelementosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mejoraelementosimagen }
    end
  end

  def create
    @mejoraelementosimagen = Mejoraelementosimagen.new(params[:mejoraelementosimagen])
    @mejoraelementosimagen.mejoramientoselemento_id = @mejoramientoselemento.id
    respond_to do |format|
      if @mejoraelementosimagen.save
        is_trigger_mej(@mejoraelementosimagen.mejoramientoselemento.mejoramiento_id,is_admin,'mejoraelementosimagenes','I')
        format.html { redirect_to edit_mejoramiento_path(@mejoramientoselemento.mejoramiento_id) }
        format.xml  { render :xml => @mejoraelementosimagen, :status => :created, :location => @mejoraelementosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mejoraelementosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @mejoraelementosimagen = Mejoraelementosimagen.find(params[:id])
    respond_to do |format|
      if @mejoraelementosimagen.update_attributes(params[:mejoraelementosimagen])
        format.html { redirect_to mejoramientoselemento_mejoraelementosimagenes_path(@mejoramientoselemento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mejoraelementosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    logger.error("Ingresooo")
    mejoraelementosimagen   = Mejoraelementosimagen.find(params[:id])
    @mejoramientoselemento         = mejoraelementosimagen.mejoramientoselemento
    @mejoraelementosimagen  = Mejoraelementosimagen.new
    mejoraelementosimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def destroy2
    logger.error("Ingresooo")
    mejoraelementosimagen   = Mejoraelementosimagen.find(params[:id])
    mejoraelementosimagen.destroy
    redirect_to :controller=>"mejoramientos", :action=>"informefotografia", :id=>params[:mejoramiento_id]
  end

  def find_mejoramientoselemento_and_mejoraelementosimagen
      @mejoramientoselemento = Mejoramientoselemento.find(params[:mejoramientoselemento_id])
      @mejoraelementosimagen = Mejoraelementosimagen.find(params[:id]) if params[:id]
  end

end

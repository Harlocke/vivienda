class AyudasdocimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_ayudasdocumento_and_ayudasdocimagen
  
  def index
    ayudasdocumento   = Ayudasdocumento.find(params[:ayudasdocumento_id])
    @ayudasdocimagenes = ayudasdocumento.ayudasdocimagenes.all
  end

  def new
    @ayudasdocimagen = Ayudasdocimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ayudasdocimagen }
    end
  end

  def create
    @ayudasdocimagen = Ayudasdocimagen.new(params[:ayudasdocimagen])
    @ayudasdocimagen.ayudasdocumento_id = @ayudasdocumento.id
    respond_to do |format|
      if @ayudasdocimagen.save
        format.html { redirect_to edit_ayuda_path(@ayudasdocumento.ayuda_id) }
        format.xml  { render :xml => @ayudasdocimagen, :status => :created, :location => @ayudasdocimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ayudasdocimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @ayudasdocimagen = Ayudasdocimagen.find(params[:id])
    respond_to do |format|
      if @ayudasdocimagen.update_attributes(params[:ayudasdocimagen])
        format.html { redirect_to ayudasdocumento_ayudasdocimagenes_path(@ayudasdocumento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ayudasdocimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    ayudasdocimagen   = Ayudasdocimagen.find(params[:id])
    @ayudasdocumento  = ayudasdocimagen.ayudasdocumento
    @ayudasdocimagen  = Ayudasdocimagen.new
    ayudasdocimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_ayudasdocumento_and_ayudasdocimagen
      @ayudasdocumento = Ayudasdocumento.find(params[:ayudasdocumento_id])
      @ayudasdocimagen = Ayudasdocimagen.find(params[:id]) if params[:id]
  end
end









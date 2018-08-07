class CalidaddocumentosimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_calidaddocumento_and_calidaddocumentosimagen

  def index
    @calidaddocumentosimagenes = @calidaddocumento.calidaddocumentosimagenes.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calidaddocumentosimagenes }
    end
  end

  def show
    @calidaddocumentosimagen = Calidaddocumentosimagen.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calidaddocumentosimagen }
    end
  end

  def new
    @calidaddocumentosimagen = Calidaddocumentosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @calidaddocumentosimagen }
    end
  end

  def edit
    @calidaddocumentosimagen = Calidaddocumentosimagen.find(params[:id])
  end

  def create
    @calidaddocumentosimagen = Calidaddocumentosimagen.new(params[:calidaddocumentosimagen])
    @calidaddocumentosimagen.calidaddocumento_id = @calidaddocumento.id
    @calidaddocumentosimagen.user_id = is_admin
    respond_to do |format|
      if @calidaddocumentosimagen.save
        format.html { redirect_to ima_calidaddocumentosimagenes_path(@calidaddocumento) }
        format.xml  { render :xml => @calidaddocumentosimagen, :status => :created, :location => @calidaddocumentosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calidaddocumentosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @calidaddocumentosimagen = Calidaddocumentosimagen.find(params[:id])
    @calidaddocumentosimagen.user_actualiza = is_admin
    respond_to do |format|
      if @calidaddocumentosimagen.update_attributes(params[:calidaddocumentosimagen])
        format.html { redirect_to ima_calidaddocumentosimagenes_url(@calidaddocumento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calidaddocumentosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @calidaddocumentosimagen = Calidaddocumentosimagen.find(params[:id])
    @calidaddocumentosimagen.destroy
    respond_to do |format|
      format.html { redirect_to ima_calidaddocumentosimagenes_url(@calidaddocumento) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_calidaddocumento_and_calidaddocumentosimagen
      @calidaddocumento = Calidaddocumento.find(params[:calidaddocumento_id])
      @calidaddocumentosimagen = Calidaddocumentosimagen.find(params[:id]) if params[:id]
  end
end

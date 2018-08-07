class InteractimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_interactividad_and_interactimagen

  def index
    interactividad   = Interactividad.find(params[:interactividad_id])
    @interactimagenes = interactividad.interactimagenes.all
  end

  def new
    @interactimagen = Interactimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @interactimagen }
    end
  end

  def create
    @interactimagen = Interactimagen.new(params[:interactimagen])
    @interactimagen.interactividad_id = @interactividad.id
    @interactimagen.user_id = is_admin
    #logger.error("SIFIinteractividad #{params[:interactimagen][:interactividad].to_s}")
    respond_to do |format|
      if @interactimagen.save
        is_trigger_mej(@interactividad.id,is_admin,'interactimagenes','I')
        format.html { redirect_to edit_interactividad_path(@interactividad) }
        format.xml  { render :xml => @interactimagen, :status => :created, :location => @interactimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @interactimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @interactimagen = Interactimagen.find(params[:id])
    respond_to do |format|
      if @interactimagen.update_attributes(params[:interactimagen])
        format.html { redirect_to interactividad_interactimagenes_path(@interactividad) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @interactimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    interactimagen   = Interactimagen.find(params[:id])
    @interactividad         = interactimagen.interactividad
    @interactimagen  = Interactimagen.new
    interactimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_interactividad_and_interactimagen
      @interactividad = Interactividad.find(params[:interactividad_id])
      @interactimagen = Interactimagen.find(params[:id]) if params[:id]
  end

end

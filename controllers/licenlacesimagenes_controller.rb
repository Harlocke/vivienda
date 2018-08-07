class LicenlacesimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_licitacionesenlace_and_licenlacesimagen, :except=>"destroy2"

  def index
    licitacionesenlace   = Licitacionesenlace.find(params[:licitacionesenlace_id])
    @licenlacesimagenes = licitacionesenlace.licenlacesimagenes.all
  end

  def new
    @licenlacesimagen = Licenlacesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @licenlacesimagen }
    end
  end

  def create
    @licenlacesimagen = Licenlacesimagen.new(params[:licenlacesimagen])
    @licenlacesimagen.licitacionesenlace_id = @licitacionesenlace.id
    respond_to do |format|
      if @licenlacesimagen.save
        #is_trigger_mej(@licenlacesimagen.licitacionesenlace.mejoramiento_id,is_admin,'licenlacesimagenes','I')
        format.html { redirect_to edit_licitacion_path(@licitacionesenlace.licitacion_id) }
        format.xml  { render :xml => @licenlacesimagen, :status => :created, :location => @licenlacesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @licenlacesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @licenlacesimagen = Licenlacesimagen.find(params[:id])
    respond_to do |format|
      if @licenlacesimagen.update_attributes(params[:licenlacesimagen])
        format.html { redirect_to licitacionesenlace_licenlacesimagenes_path(@licitacionesenlace) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @licenlacesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    logger.error("Ingresooo")
    licenlacesimagen    = Licenlacesimagen.find(params[:id])
    @licitacionesenlace = licenlacesimagen.licitacionesenlace
    @licenlacesimagen   = Licenlacesimagen.new
    licenlacesimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def destroy2
    logger.error("Ingresooo")
    licenlacesimagen   = Licenlacesimagen.find(params[:id])
    licenlacesimagen.destroy
    redirect_to :controller=>"licitaciones", :action=>"informe", :id=>params[:licitacion_id]
  end

  def find_licitacionesenlace_and_licenlacesimagen
      @licitacionesenlace = Licitacionesenlace.find(params[:licitacionesenlace_id])
      @licenlacesimagen = Licenlacesimagen.find(params[:id]) if params[:id]
  end

end

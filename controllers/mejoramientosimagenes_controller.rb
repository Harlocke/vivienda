class MejoramientosimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_mejoramiento_and_mejoramientosimagen

  def index
    mejoramiento   = Mejoramiento.find(params[:mejoramiento_id])
    @mejoramientosimagenes = mejoramiento.mejoramientosimagenes.all
  end

  def new
    @mejoramientosimagen = Mejoramientosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mejoramientosimagen }
    end
  end

  def create
    @mejoramientosimagen = Mejoramientosimagen.new(params[:mejoramientosimagen])
    @mejoramientosimagen.mejoramiento_id = @mejoramiento.id
    @mejoramientosimagen.user_id = is_admin
    #logger.error("SIFImejoramiento #{params[:mejoramientosimagen][:mejoramiento].to_s}")
    respond_to do |format|
      if @mejoramientosimagen.save
        is_trigger_mej(@mejoramiento.id,is_admin,'mejoramientosimagenes','I')
        format.html { redirect_to edit_mejoramiento_path(@mejoramiento) }
        format.xml  { render :xml => @mejoramientosimagen, :status => :created, :location => @mejoramientosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mejoramientosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @mejoramientosimagen = Mejoramientosimagen.find(params[:id])
    respond_to do |format|
      if @mejoramientosimagen.update_attributes(params[:mejoramientosimagen])
        format.html { redirect_to mejoramiento_mejoramientosimagenes_path(@mejoramiento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mejoramientosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    mejoramientosimagen   = Mejoramientosimagen.find(params[:id])
    @mejoramiento         = mejoramientosimagen.mejoramiento
    @mejoramientosimagen  = Mejoramientosimagen.new
    mejoramientosimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_mejoramiento_and_mejoramientosimagen
      @mejoramiento = Mejoramiento.find(params[:mejoramiento_id])
      @mejoramientosimagen = Mejoramientosimagen.find(params[:id]) if params[:id]
  end

end

class ConveniosimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_convenio_and_conveniosimagen

  def index
    convenio   = Convenio.find(params[:convenio_id])
    @conveniosimagenes = convenio.conveniosimagenes.all
  end

  def new
    @conveniosimagen = Conveniosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @conveniosimagen }
    end
  end

  def create
    @conveniosimagen = Conveniosimagen.new(params[:conveniosimagen])
    @conveniosimagen.convenio_id = @convenio.id
    @conveniosimagen.user_id = is_admin
    respond_to do |format|
      if @conveniosimagen.save
        flash[:notice] = "Documento cargado con exito"
        format.html { redirect_to edit_convenio_path(@convenio) }
        format.xml  { render :xml => @conveniosimagen, :status => :created, :location => @conveniosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @conveniosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @conveniosimagen = Conveniosimagen.find(params[:id])
    respond_to do |format|
      if @conveniosimagen.update_attributes(params[:conveniosimagen])
        format.html { redirect_to convenio_conveniosimagenes_path(@convenio) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conveniosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    conveniosimagen   = Conveniosimagen.find(params[:id])
    @convenio         = conveniosimagen.convenio
    @conveniosimagen  = Conveniosimagen.new
    conveniosimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_convenio_and_conveniosimagen
      @convenio = Convenio.find(params[:convenio_id])
      @conveniosimagen = Conveniosimagen.find(params[:id]) if params[:id]
  end
end

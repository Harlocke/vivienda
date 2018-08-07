class ArchivosimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_archivo_and_archivosimagen

  def index
    archivo   = Archivo.find(params[:archivo_id])
    @archivosimagenes = archivo.archivosimagenes.all
  end

  def new
    @archivosimagen = Archivosimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @archivosimagen }
    end
  end

  def create
    @archivosimagen = Archivosimagen.new(params[:archivosimagen])
    @archivosimagen.archivo_id = @archivo.id
    @archivosimagen.user_id = is_admin
    respond_to do |format|
      if @archivosimagen.save
        flash[:notice] = "Documento cargado con exito"
        format.html { redirect_to edit_archivo_path(@archivo) }
        format.xml  { render :xml => @archivosimagen, :status => :created, :location => @archivosimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @archivosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @archivosimagen = Archivosimagen.find(params[:id])
    respond_to do |format|
      if @archivosimagen.update_attributes(params[:archivosimagen])
        format.html { redirect_to archivo_archivosimagenes_path(@archivo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @archivosimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    archivosimagen   = Archivosimagen.find(params[:id])
    @archivo         = archivosimagen.archivo
    @archivosimagen  = Archivosimagen.new
    archivosimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end
  
  def find_archivo_and_archivosimagen
      @archivo = Archivo.find(params[:archivo_id])
      @archivosimagen = Archivosimagen.find(params[:id]) if params[:id]
  end

end

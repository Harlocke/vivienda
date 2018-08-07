class TitulacionesimagenesController < ApplicationController
before_filter :require_user
  before_filter :find_titulacion_and_titulacionesimagen

  def index
    titulacion   = Titulacion.find(params[:titulacion_id])
    @titulacionesimagenes = titulacion.titulacionesimagenes.all
  end

  def new
    @titulacionesimagen = Titulacionesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @titulacionesimagen }
    end
  end

  def create
    @titulacionesimagen = Titulacionesimagen.new(params[:titulacionesimagen])
    @titulacionesimagen.titulacion_id = @titulacion.id
    @titulacionesimagen.user_id = is_admin
    respond_to do |format|
      if @titulacionesimagen.save
        is_trigger_tit(@titulacion.id,is_admin,'titulacionesimagen','I')
        format.html { redirect_to edit_titulacion_path(@titulacion) }
        format.xml  { render :xml => @titulacionesimagen, :status => :created, :location => @titulacionesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @titulacionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @titulacionesimagen = Titulacionesimagen.find(params[:id])
    respond_to do |format|
      if @titulacionesimagen.update_attributes(params[:titulacionesimagen])
        format.html { redirect_to titulacion_titulacionesimagenes_path(@titulacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @titulacionesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    titulacionesimagen   = Titulacionesimagen.find(params[:id])
    @titulacion         = titulacionesimagen.titulacion
    is_trigger_tite(@titulacion.id,is_admin,'titulacionesimagen','E',titulacionesimagen.titulacion_file_name.to_s)
    @titulacionesimagen  = Titulacionesimagen.new
    titulacionesimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end
  
  def find_titulacion_and_titulacionesimagen
      @titulacion = Titulacion.find(params[:titulacion_id])
      @titulacionesimagen = Titulacionesimagen.find(params[:id]) if params[:id]
  end
end
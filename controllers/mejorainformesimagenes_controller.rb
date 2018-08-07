class MejorainformesimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_mejorainformeselemento_and_mejorainformesimagen

  def index
    mejorainformeselemento   = Mejorainformeselemento.find(params[:mejorainformeselemento_id])
    @mejorainformesimagenes = mejorainformeselemento.mejorainformesimagenes.all
  end

  def new
    @mejorainformesimagen = Mejorainformesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mejorainformesimagen }
    end
  end

  def create
    @mejorainformesimagen = Mejorainformesimagen.new(params[:mejorainformesimagen])
    @mejorainformesimagen.mejorainformeselemento_id = @mejorainformeselemento.id
    respond_to do |format|
      if @mejorainformesimagen.save
        format.html { redirect_to edit_mejorainformeselemento_path(@mejorainformeselemento) }
        format.xml  { render :xml => @mejorainformesimagen, :status => :created, :location => @mejorainformesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mejorainformesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @mejorainformesimagen = Mejorainformesimagen.find(params[:id])
    respond_to do |format|
      if @mejorainformesimagen.update_attributes(params[:mejorainformesimagen])
        format.html { redirect_to mejorainformeselemento_mejorainformesimagenes_path(@mejorainformeselemento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mejorainformesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    mejorainformesimagen   = Mejorainformesimagen.find(params[:id])
    @mejorainformeselemento         = mejorainformesimagen.mejorainformeselemento
    @mejorainformesimagen  = Mejorainformesimagen.new
    mejorainformesimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_mejorainformeselemento_and_mejorainformesimagen
      @mejorainformeselemento = Mejorainformeselemento.find(params[:mejorainformeselemento_id])
      @mejorainformesimagen = Mejorainformesimagen.find(params[:id]) if params[:id]
  end

end

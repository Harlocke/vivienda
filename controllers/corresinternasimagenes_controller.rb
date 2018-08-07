class CorresinternasimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_correspondenciasinterna_and_corresinternasimagen

  def index
    correspondenciasinterna   = Correspondenciasinterna.find(params[:correspondenciasinterna_id])
    @corresinternasimagenes = correspondenciasinterna.corresinternasimagenes.all
  end

  def new
    @corresinternasimagen = Corresinternasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @corresinternasimagen }
    end
  end

    def create
    @corresinternasimagen = Corresinternasimagen.new(params[:corresinternasimagen])
    @corresinternasimagen.correspondenciasinterna_id = @correspondenciasinterna.id
    @corresinternasimagen.user_id = is_admin
    respond_to do |format|
      if @corresinternasimagen.save
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to edit_correspondenciasinterna_path(@correspondenciasinterna) }
        format.xml  { render :xml => @corresinternasimagen, :status => :created, :location => @corresinternasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @corresinternasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @corresinternasimagen = Corresinternasimagen.find(params[:id])
    respond_to do |format|
      if @corresinternasimagen.update_attributes(params[:corresinternasimagen])
        format.html { redirect_to correspondenciasinterna_corresinternasimagenes_path(@correspondenciasinterna) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @corresinternasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    corresinternasimagen   = Corresinternasimagen.find(params[:id])
    @correspondenciasinterna = corresinternasimagen.correspondenciasinterna
    @corresinternasimagen  = Corresinternasimagen.new
    corresinternasimagen.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_correspondenciasinterna_and_corresinternasimagen
      @correspondenciasinterna = Correspondenciasinterna.find(params[:correspondenciasinterna_id])
      @corresinternasimagen = Corresinternasimagen.find(params[:id]) if params[:id]
  end
end
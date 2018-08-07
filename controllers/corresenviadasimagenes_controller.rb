class CorresenviadasimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_correspondenciasenviada_and_corresenviadasimagen

  def index
    correspondenciasenviada   = Correspondenciasenviada.find(params[:correspondenciasenviada_id])
    @corresenviadasimagenes = correspondenciasenviada.corresenviadasimagenes.all
  end

  def new
    @corresenviadasimagen = Corresenviadasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @corresenviadasimagen }
    end
  end

  def create
    @corresenviadasimagen = Corresenviadasimagen.new(params[:corresenviadasimagen])
    @corresenviadasimagen.correspondenciasenviada_id = @correspondenciasenviada.id
    @corresenviadasimagen.user_id = is_admin
    respond_to do |format|
      if @corresenviadasimagen.save
        format.html { redirect_to edit_correspondenciasenviada_path(@correspondenciasenviada) }
        format.xml  { render :xml => @corresenviadasimagen, :status => :created, :location => @corresenviadasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @corresenviadasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @corresenviadasimagen = Corresenviadasimagen.find(params[:id])
    respond_to do |format|
      if @corresenviadasimagen.update_attributes(params[:corresenviadasimagen])
        format.html { redirect_to correspondenciasenviada_corresenviadasimagenes_path(@correspondenciasenviada) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @corresenviadasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    corresenviadasimagen   = Corresenviadasimagen.find(params[:id])
    @correspondenciasenviada         = corresenviadasimagen.correspondenciasenviada
    @corresenviadasimagen  = Corresenviadasimagen.new
    corresenviadasimagen.destroy
    respond_to do |format|
      format.js { render :action => "corresenviadasimagenes" }
    end
  end

  def find_correspondenciasenviada_and_corresenviadasimagen
      @correspondenciasenviada = Correspondenciasenviada.find(params[:correspondenciasenviada_id])
      @corresenviadasimagen = Corresenviadasimagen.find(params[:id]) if params[:id]
  end
end
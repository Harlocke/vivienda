class CorresrecibidasimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_correspondenciasrecibida_and_corresrecibidasimagen

  def index
    correspondenciasrecibida   = Correspondenciasrecibida.find(params[:correspondenciasrecibida_id])
    @corresrecibidasimagenes = correspondenciasrecibida.corresrecibidasimagenes.all
  end

  def new
    @corresrecibidasimagen = Corresrecibidasimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @corresrecibidasimagen }
    end
  end

  def create
    @corresrecibidasimagen = Corresrecibidasimagen.new(params[:corresrecibidasimagen])
    @corresrecibidasimagen.correspondenciasrecibida_id = @correspondenciasrecibida.id
    @corresrecibidasimagen.user_id = is_admin
    respond_to do |format|
      if @corresrecibidasimagen.save
        format.html { redirect_to edit_correspondenciasrecibida_path(@correspondenciasrecibida) }
        format.xml  { render :xml => @corresrecibidasimagen, :status => :created, :location => @corresrecibidasimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @corresrecibidasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @corresrecibidasimagen = Corresrecibidasimagen.find(params[:id])
    respond_to do |format|
      if @corresrecibidasimagen.update_attributes(params[:corresrecibidasimagen])
        format.html { redirect_to correspondenciasrecibida_corresrecibidasimagenes_path(@correspondenciasrecibida) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @corresrecibidasimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    corresrecibidasimagen   = Corresrecibidasimagen.find(params[:id])
    @correspondenciasrecibida         = corresrecibidasimagen.correspondenciasrecibida
    @corresrecibidasimagen  = Corresrecibidasimagen.new
    corresrecibidasimagen.destroy
    respond_to do |format|
      format.js { render :action => "corresrecibidasimagenes" }
    end
  end

  def find_correspondenciasrecibida_and_corresrecibidasimagen
      @correspondenciasrecibida = Correspondenciasrecibida.find(params[:correspondenciasrecibida_id])
      @corresrecibidasimagen = Corresrecibidasimagen.find(params[:id]) if params[:id]
  end
end

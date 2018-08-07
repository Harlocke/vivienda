class CorvidesdocumentosController < ApplicationController
  before_filter :require_user
  before_filter :find_corvide_and_corvidesdocumento

  def index
    corvide   = Corvide.find(params[:corvide_id])
    @corvidesdocumentos = corvide.corvidesdocumentos.all
  end

  def new
    @corvidesdocumento = Corvidesdocumento.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @corvidesdocumento }
    end
  end

  def create
    @corvidesdocumento = Corvidesdocumento.new(params[:corvidesdocumento])
    @corvidesdocumento.corvide_id = @corvide.id
    @corvidesdocumento.user_id = is_admin
    respond_to do |format|
      if @corvidesdocumento.save
        is_trigger_tit(@corvide.id,is_admin,'corvidesdocumento','I')
        format.html { redirect_to edit_corvide_path(@corvide) }
        format.xml  { render :xml => @corvidesdocumento, :status => :created, :location => @corvidesdocumento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @corvidesdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @corvidesdocumento = Corvidesdocumento.find(params[:id])
    respond_to do |format|
      if @corvidesdocumento.update_attributes(params[:corvidesdocumento])
        format.html { redirect_to corvide_corvidesdocumentos_path(@corvide) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @corvidesdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    corvidesdocumento   = Corvidesdocumento.find(params[:id])
    @corvide          = corvidesdocumento.corvide
    @corvidesdocumento  = Corvidesdocumento.new
    corvidesdocumento.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_corvide_and_corvidesdocumento
      @corvide = Corvide.find(params[:corvide_id])
      @corvidesdocumento = Corvidesdocumento.find(params[:id]) if params[:id]
  end
end
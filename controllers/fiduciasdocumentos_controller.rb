class FiduciasdocumentosController < ApplicationController
  before_filter :require_user
  before_filter :find_fiducia_and_fiduciasdocumento

  def index
    fiducia   = Fiducia.find(params[:fiducia_id])
    @fiduciasdocumentos = fiducia.fiduciasdocumentos.all
  end

  def new
    @fiduciasdocumento = Fiduciasdocumento.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fiduciasdocumento }
    end
  end

  def create
    @fiduciasdocumento = Fiduciasdocumento.new(params[:fiduciasdocumento])
    @fiduciasdocumento.fiducia_id = @fiducia.id
    @fiduciasdocumento.user_id = is_admin
    respond_to do |format|
      if @fiduciasdocumento.save
        format.html { redirect_to edit_fiducia_path(@fiducia) }
        format.xml  { render :xml => @fiduciasdocumento, :status => :created, :location => @fiduciasdocumento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fiduciasdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @fiduciasdocumento = Fiduciasdocumento.find(params[:id])
    respond_to do |format|
      if @fiduciasdocumento.update_attributes(params[:fiduciasdocumento])
        format.html { redirect_to fiducia_fiduciasdocumentos_path(@fiducia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fiduciasdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    fiduciasdocumento   = Fiduciasdocumento.find(params[:id])
    @fiducia          = fiduciasdocumento.fiducia
    @fiduciasdocumento  = Fiduciasdocumento.new
    fiduciasdocumento.destroy
    render :update do |page|
      page.alert "SIFI - Documento eliminado"
    end
  end

  def find_fiducia_and_fiduciasdocumento
      @fiducia = Fiducia.find(params[:fiducia_id])
      @fiduciasdocumento = Fiduciasdocumento.find(params[:id]) if params[:id]
  end
end